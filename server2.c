#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <pthread.h>

#define bufferSize 1024

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

void *clientHandler(void *sockfd)
{
    char *buffer=(char *)malloc(bufferSize*sizeof(char));
    int *sockin = (int*)sockfd;
    
    int n = read(*sockin, buffer, bufferSize);
    if(n<0) error("ERROR reading from socket");
    
    printf("sam -> %s/n", buffer);

    n = write(*sockin, "yes", 3);
    close(*sockin);
}

int main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno;
    //socklen_t clilen;
    char buffer[256];
    struct sockaddr_in serv_addr, cli_addr;
    int n;
    if (argc < 2) {
        fprintf(stderr,"ERROR, no port provided");
        exit(1);
    }
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0){
        error("ERROR opening socket");
    }
    bzero((char *) &serv_addr, sizeof(serv_addr));
    portno = atoi(argv[1]);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);
    if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0){
        error("ERROR on binding");
    }
    listen(sockfd,5);

    while(true)
    {
       socklen_t clilen = sizeof(cli_addr);
       newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
       if (newsockfd < 0){ 
           error("ERROR on accept");
       }
       bzero(buffer,256);

       pthread_t t;
       pthread_create(&t, NULL, clientHandler, &newsockfd);

       /*
       n = read(newsockfd,buffer,255);
       if (n < 0) error("ERROR reading from socket");
       printf("Here is the message: %s",buffer);
       n = write(newsockfd,"I got your message",18);
       if (n < 0) error("ERROR writing to socket");
       close(newsockfd);
       */
    }

    close(sockfd);
    return 0;
}
