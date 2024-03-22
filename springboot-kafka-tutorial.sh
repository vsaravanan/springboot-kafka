
project=springboot-kafka-tutorial
rm -rf $project/logs/*
rm -rf $project/logPath_IS_UNDEFINED
rm -rf /data/logs/$project

#git checkout main
#git pull
#cd  $project
#rm -rf target
#mvn clean package install -T 1C -DskipTests
#cd ..
java -jar $project/target/$project.jar
