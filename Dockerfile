# JRE base
FROM openjdk:11.0.9.1-slim-buster

# Environment variables
ENV MC_VERSION="1.16.4" \
    PAPER_BUILD="latest" \
    MC_RAM="6G" \
    SEED="9058136630944956755" \
    RCON="true" \
    RCON_PASSWORD="changetoastrongpassword" \
    JAVA_OPTS=" \
       -XX:+UseG1GC \
       -XX:+ParallelRefProcEnabled \
       -XX:MaxGCPauseMillis=200 \
       -XX:+UnlockExperimentalVMOptions \
       -XX:+DisableExplicitGC \
       -XX:+AlwaysPreTouch \
       -XX:G1NewSizePercent=30 \
       -XX:G1MaxNewSizePercent=40 \
       -XX:G1HeapRegionSize=8M \
       -XX:G1ReservePercent=20 \
       -XX:G1HeapWastePercent=5 \
       -XX:G1MixedGCCountTarget=4 \
       -XX:InitiatingHeapOccupancyPercent=15 \
       -XX:G1MixedGCLiveThresholdPercent=90 \
       -XX:G1RSetUpdatingPauseTimePercent=5 \
       -XX:SurvivorRatio=32 \
       -XX:+PerfDisableSharedMem \
       -XX:MaxTenuringThreshold=1 \
       -Dusing.aikars.flags=https://mcflags.emc.gs \
       -Daikars.new.flags=true"

ADD papermc.sh .

RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /papermc \
    && wget https://papermc.io/api/v1/paper/${MC_VERSION}/latest -O /papermc/latest

# Start script
CMD ["sh", "./papermc.sh"]

# Game Directory
VOLUME /papermc

#GAME
EXPOSE 25565/tcp 
EXPOSE 25565/udp

#RCON
EXPOSE 25575/tcp
