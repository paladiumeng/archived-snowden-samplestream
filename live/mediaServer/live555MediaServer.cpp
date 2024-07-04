#include <BasicUsageEnvironment.hh>
#include "DynamicRTSPServer.hh"

int main(int argc, char** argv) {
  TaskScheduler* scheduler = BasicTaskScheduler::createNew();
  UsageEnvironment* env = BasicUsageEnvironment::createNew(*scheduler);

  UserAuthenticationDatabase* authDB = new UserAuthenticationDatabase;
  authDB->addUserRecord("a", "b");

  RTSPServer* rtspServer;
  portNumBits rtspServerPortNum = 8554;
  rtspServer = DynamicRTSPServer::createNew(*env, rtspServerPortNum, NULL);

  if (rtspServer == NULL) {
    *env << "Failed to create RTSP server: " << env->getResultMsg() << "\n";
    exit(1);
  }

  env->taskScheduler().doEventLoop();

  return 0;
}
