project=kafka-producer-wikimedia
rm -rf $project/logs/*
rm -rf $project/logPath_IS_UNDEFINED
rm -rf /data/logs/$project

#cd  springboot-kafka-real-world-project/$project
#git checkout main
#git pull
#rm -rf target
#mvn clean package install -T 1C -DskipTests
#cd ../..

java -jar springboot-kafka-real-world-project/$project/target/$project.jar