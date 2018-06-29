FROM maven:latest
LABEL maintainer="jorge.martinez@gmail.com"
COPY . /app
WORKDIR /app
RUN mvn clean package -Dmaven.test.skip=true
RUN mv /app/target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar /spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar
RUN rm -R /app
WORKDIR /
CMD ["java", "-jar", "spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar"]
#CMD ["mvn","spring-boot:run"]


