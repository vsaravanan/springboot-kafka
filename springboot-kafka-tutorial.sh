project=springboot-kafka-tutorial
rm -rf $project/logs/*
rm -rf $project/logPath_IS_UNDEFINED
rm -rf /data/logs/$project
java -jar $project/target/$project.jar

