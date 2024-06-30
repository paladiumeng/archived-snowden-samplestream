#include <liveMedia.hh>
#include <BasicUsageEnvironment.hh>
#include <GroupsockHelper.hh>

UsageEnvironment* env;

void play();
char const* streamName = "fipStream";
char const* inputFileName = "video.mp4";
portNumBits rtspServerPortNum = 8554;
ServerMediaSession* sms;

int main(int argc, char** argv) {
    TaskScheduler* scheduler = BasicTaskScheduler::createNew();
    env = BasicUsageEnvironment::createNew(*scheduler);

    UserAuthenticationDatabase* authDB = NULL;
    RTSPServer* rtspServer = RTSPServer::createNew(*env, rtspServerPortNum, authDB);
    if (rtspServer == NULL) {
        *env << "Failed to create RTSP server: " << env->getResultMsg() << "\n";
        exit(1);
    }

    sms = ServerMediaSession::createNew(*env, streamName, streamName, "Fake IP Camera Stream");
    OutPacketBuffer::increaseMaxSizeTo(500000);

    FramedSource* videoSource = ByteStreamFileSource::createNew(*env, inputFileName);
    if (videoSource == NULL) {
        *env << "Unable to open file \"" << inputFileName << "\" as a byte-stream file source\n";
        exit(1);
    }

    // Create a framer for the Video Elementary Stream:
    FramedSource* videoES = MPEG4VideoStreamFramer::createNew(*env, videoSource);

    // Create and add the video track to the server media session:
    sms->addSubsession(MPEG4VideoFileServerMediaSubsession::createNew(*env, videoES, True));

    rtspServer->addServerMediaSession(sms);

    char* url = rtspServer->rtspURL(sms);
    *env << "Play this stream using the URL \"" << url << "\"\n";
    delete[] url;

    play();

    env->taskScheduler().doEventLoop();
    return 0;
}

void play() {
    *env << "Beginning streaming...\n";
}
