CC = g++
CFLAGS = -std=c++11 -Wall
INCLUDES = -I/opt/live/UsageEnvironment/include \
           -I/opt/live/groupsock/include \
           -I/opt/live/liveMedia/include \
           -I/opt/live/BasicUsageEnvironment/include
LDFLAGS = -L/opt/live/liveMedia \
          -L/opt/live/groupsock \
          -L/opt/live/BasicUsageEnvironment \
          -L/opt/live/UsageEnvironment
LIBS = -lliveMedia -lgroupsock -lBasicUsageEnvironment -lUsageEnvironment

TARGET = samplestream
SRCS = main.cpp

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(TARGET) $(SRCS) $(LDFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(TARGET)
