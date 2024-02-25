#include <stdio.h>
#include <time.h>

void chenghsun()
{
    static int a;
    a+=1;
    printf("a: %d\n", a);
}

void ttt(int duration)
{
    static time_t start;
    time_t now = clock();
    if((now - start) >= duration)
    {
       start = now;
       printf("yes, That is time out!!%s\n", ctime(&start));

       //struct tm *yes = localtime(&start);
       //printf("yes, That is time out!!%s\n", asctime(yes));
    }
    else
    {
       //printf("wait\n");
    } 
}

int main(int argc, char *argv[])
{
    clock_t c; //clock_t 是 long型別別名
    //time_t time(void *); //取得時間戳，離1900年有多少秒。
    time_t t = time(NULL); //time_t 是 _int64型別別名？
    printf("timestamp: %ld\n", t); //C++才有lld
    //time_t --> tm轉換
    //struct tm* localtime(time_t *time);
    
    //time_t --> char*
    //char *ctime(time_t *time); //
    char *test = ctime(&t);
    printf("check: %s\n", test);

    struct tm *sam=localtime(&t);
    printf("year: %i\n", sam->tm_year + 1900);
    printf("month: %i\n", sam->tm_mon + 1);
    printf("day: %i\n", sam->tm_mday);
    printf("hour: %i\n", sam->tm_hour - 1);
    printf("minute: %i\n", sam->tm_min);
    printf("second: %i\n", sam->tm_sec);

    char *afu = asctime(sam);
    puts(afu);    
    //tm --> char*
    //char *asctime(struct tm* ptime);
    
    //tm --> time_t*
    //time_t mktime(struct tm* ptime);
    
    //------------------------------------------------------
    //time_t clock();      //取得程式運行到當前代碼的時間。
    chenghsun();
    chenghsun();
    chenghsun();
    while(1)
    {
	      ttt(10000);
    }
    return 0;
}
