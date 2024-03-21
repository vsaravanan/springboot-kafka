project=kafka-producer-wikimedia
rm -rf $project/logs/*
rm -rf $project/logPath_IS_UNDEFINED
rm -rf /data/logs/$project
java -jar springboot-kafka-real-world-project/$project/target/$project.jar