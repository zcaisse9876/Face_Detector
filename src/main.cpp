#include <opencv2/highgui.hpp>
#include <iostream>
#include <sstream>
#include "config.h"
#include "DNNFaceDetector.h"

void drawImage(cv::Mat &image, const std::vector<std::vector<float>> &faces);
void drawLandmarks(cv::Mat &image, std::map<std::string, std::vector<std::vector<float>>> landmarks);

int main() {
    std::cout << PROJECT_NAME << " " << PROJECT_VER << std::endl;
    const int frameRate = 80;
    const std::string caffeModel = "../assets/res10_300x300_ssd_iter_140000.caffemodel";
    const std::string protoText = "../assets/deploy.prototxt.txt";
    const std::string facemarkModel = "../assets/shape_predictor_68_face_landmarks.dat";
    //DNNFaceDetector detector(protoText, caffeModel);
    DNNLandmarkDetector detector(protoText, caffeModel, facemarkModel);
    cv::VideoCapture capture;
    cv::Mat frame;

    capture.open(0);
    if (!capture.isOpened()) {
        std::cout << "Could not open camera!" << std::endl;
        return 1;
    }

    while (1) {
        capture >> frame;
        if (frame.empty())
            break;
        auto landmarks = detector.getFacialLandmarks(frame);
        drawLandmarks(frame, landmarks);
        // auto faces = detector.getBoundingBoxes(frame);
        // drawImage(frame, faces);
        char c = static_cast<char>(cv::waitKey(1000 / frameRate));
        if (c == 27 || c == 'q' || c == 'Q')
            break;
    }
    return 0;
}

void drawLandmarks(cv::Mat &image, std::map<std::string, std::vector<std::vector<float>>> landmarks) {
    std::vector<std::vector<float>> lm = landmarks["LM"];
    std::vector<std::vector<float>> faces = landmarks["ROI"];

    for (size_t i = 0; i < faces.size(); ++i)
    {
        const float confidence = faces[i][0];
        const int x1 = static_cast<int>(faces[i][1]);
        const int y1 = static_cast<int>(faces[i][2]);
        const int x2 = static_cast<int>(faces[i][3]);
        const int y2 = static_cast<int>(faces[i][4]);

        for (size_t j = 0; j < lm[i].size() - 1; j+=2)
        {
            cv::circle(image, cv::Point(lm[i][j], lm[i][j+1]), 3, cv::Scalar(255, 0, 0), cv::FILLED);
        }
        std::ostringstream in;
        in << "Face: " << std::setprecision(2) << std::fixed << confidence * 100 << "%";
        const int textY = y1 - 10 > 10 ? y1 - 10 : y1 + 10;
        cv::rectangle(image, cv::Point(x1, y1), cv::Point(x2, y2), cv::Scalar(0, 255, 0), 2, 4);
        cv::putText(image, in.str(), cv::Point(x1, textY), cv::FONT_HERSHEY_SIMPLEX, 0.45, cv::Scalar(0, 255, 0), 1);
    }
    cv::imshow("Output", image);
}

void drawImage(cv::Mat &image, const std::vector<std::vector<float>> &faces)
{
    for (size_t i = 0; i < faces.size(); ++i) {
        const float confidence = faces[i][0];
        const int x1 = static_cast<int>(faces[i][1]);
        const int y1 = static_cast<int>(faces[i][2]);
        const int x2 = static_cast<int>(faces[i][3]);
        const int y2 = static_cast<int>(faces[i][4]);
        std::ostringstream in;
        in << "Face: " << std::setprecision(2) << std::fixed << confidence * 100 << "%";
        const int textY = y1 - 10 > 10 ? y1 - 10 : y1 + 10;
        cv::rectangle(image, cv::Point(x1, y1), cv::Point(x2, y2), cv::Scalar(0, 255, 0), 2, 4);
        cv::putText(image, in.str(), cv::Point(x1, textY), cv::FONT_HERSHEY_SIMPLEX, 0.45, cv::Scalar(0, 255, 0), 1);
    }
    cv::imshow("Output", image);
}
