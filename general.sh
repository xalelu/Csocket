#!/bin/bash

filepath="./server.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "#include <stdio.h>" >> $filepath
    echo "#include <stdlib.h>" >> $filepath
    echo "#include <string.h>" >> $filepath
    echo "#include <unistd.h>" >> $filepath
    echo "#include <sys/types.h>" >> $filepath
    echo "#include <sys/socket.h>" >> $filepath
    echo "#include <netinet/in.h>" >> $filepath
    echo "" >> $filepath
    echo "void error(const char *msg)" >> $filepath
    echo "{" >> $filepath
    echo "    perror(msg);" >> $filepath
    echo "    exit(1);" >> $filepath
    echo "}" >> $filepath
    echo "" >> $filepath
    echo "int main(int argc, char *argv[])" >> $filepath
    echo "{" >> $filepath
    echo "    int sockfd, newsockfd, portno;" >> $filepath
    echo "    socklen_t clilen;" >> $filepath
    echo "    char buffer[256];" >> $filepath
    echo "    struct sockaddr_in serv_addr, cli_addr;" >> $filepath
    echo "    int n;" >> $filepath
    echo "    if (argc < 2) {" >> $filepath
    echo "        fprintf(stderr,\"ERROR, no port provided\n\");" >> $filepath
    echo "        exit(1);" >> $filepath
    echo "    }" >> $filepath
    echo "    sockfd = socket(AF_INET, SOCK_STREAM, 0);" >> $filepath
    echo "    if (sockfd < 0){" >> $filepath
    echo "        error(\"ERROR opening socket\");" >> $filepath
    echo "    }" >> $filepath
    echo "    bzero((char *) &serv_addr, sizeof(serv_addr));" >> $filepath
    echo "    portno = atoi(argv[1]);" >> $filepath
    echo "    serv_addr.sin_family = AF_INET;" >> $filepath
    echo "    serv_addr.sin_addr.s_addr = INADDR_ANY;" >> $filepath
    echo "    serv_addr.sin_port = htons(portno);" >> $filepath
    echo "    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0){" >> $filepath 
    echo "        error(\"ERROR on binding\");" >> $filepath
    echo "    }" >> $filepath
    echo "    listen(sockfd,5);" >> $filepath
    echo "    clilen = sizeof(cli_addr);" >> $filepath
    echo "    newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);" >> $filepath
    echo "    if (newsockfd < 0){ " >> $filepath
    echo "        error(\"ERROR on accept\");" >> $filepath
    echo "    }" >> $filepath
    echo "    bzero(buffer,256);" >> $filepath
    echo "    n = read(newsockfd,buffer,255);" >> $filepath
    echo "    if (n < 0) error(\"ERROR reading from socket\");" >> $filepath
    echo "    printf(\"Here is the message: %s\n\",buffer);" >> $filepath
    echo "    n = write(newsockfd,\"I got your message\",18);" >> $filepath
    echo "    if (n < 0) error(\"ERROR writing to socket\");" >> $filepath
    echo "    close(newsockfd);" >> $filepath
    echo "    close(sockfd);" >> $filepath
    echo "    return 0;" >> $filepath
    echo "}" >> $filepath
    chmod 777 "$filepath"
else
    echo "file server.c has be exists.."
fi

filepath="./client.c"
if [ ! -f "$filepath" ];then
    touch $filepath
    echo "#include <stdio.h>" >> $filepath
    echo "#include <stdlib.h>" >> $filepath
    echo "#include <unistd.h>" >> $filepath
    echo "#include <string.h>" >> $filepath
    echo "#include <sys/types.h>" >> $filepath
    echo "#include <sys/socket.h>" >> $filepath
    echo "#include <netinet/in.h>" >> $filepath
    echo "#include <netdb.h>" >> $filepath
    echo "" >> $filepath
    echo "void error(const char *msg)" >> $filepath
    echo "{" >> $filepath
    echo "    perror(msg);" >> $filepath
    echo "    exit(0);" >> $filepath
    echo "}" >> $filepath
    echo "" >> $filepath
    echo "int main(int argc, char *argv[])" >> $filepath
    echo "{" >> $filepath
    echo "    int sockfd, portno, n;" >> $filepath
    echo "    struct sockaddr_in serv_addr;" >> $filepath
    echo "    struct hostent *server;" >> $filepath

    echo "    char buffer[256];" >> $filepath
    echo "    if (argc < 3) {" >> $filepath
    echo "        fprintf(stderr,\"usage %s hostname port\n\", argv[0]);" >> $filepath
    echo "        exit(0);" >> $filepath
    echo "    }" >> $filepath
    echo "    portno = atoi(argv[2]);" >> $filepath
    echo "    sockfd = socket(AF_INET, SOCK_STREAM, 0);" >> $filepath
    echo "    if (sockfd < 0) {" >> $filepath
    echo "        error("ERROR opening socket");" >> $filepath
    echo "    server = gethostbyname(argv[1]);" >> $filepath
    echo "    if (server == NULL) {" >> $filepath
    echo "        fprintf(stderr,\"ERROR, no such host\n\");" >> $filepath
    echo "        exit(0);" >> $filepath
    echo "    }" >> $filepath
    echo "    bzero((char *) &serv_addr, sizeof(serv_addr));" >> $filepath
    echo "    serv_addr.sin_family = AF_INET;" >> $filepath
    echo "    bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);" >> $filepath
    echo "    serv_addr.sin_port = htons(portno);" >> $filepath
    echo "    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0){" >> $filepath 
    echo "        error(\"ERROR connecting\");" >> $filepath
    echo "    printf(\"Please enter the message: \");" >> $filepath
    echo "    bzero(buffer,256);" >> $filepath
    echo "    fgets(buffer,255,stdin);" >> $filepath
    echo "    n = write(sockfd,buffer,strlen(buffer));" >> $filepath
    echo "    if (n < 0) " >> $filepath
    echo "        error(\"ERROR writing to socket\");" >> $filepath
    echo "    bzero(buffer,256);" >> $filepath
    echo "    n = read(sockfd,buffer,255);" >> $filepath
    echo "    if (n < 0){ " >> $filepath
    echo "        error(\"ERROR reading from socket\");" >> $filepath
    echo "    printf("%s\n",buffer);" >> $filepath
    echo "    close(sockfd);" >> $filepath
    echo "    return 0;" >> $filepath
    echo "}" >> $filepath
    chmod 777 "$filepath"
else
    echo "file client.c has be exists."
fi
