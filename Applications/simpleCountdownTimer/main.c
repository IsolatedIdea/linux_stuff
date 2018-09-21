//A simple countdown timer application that will trigger a notify on complete

#include <stdio.h>
#include <ncurses.h>

struct Args
{
	int numArgs;
	int numVals;
	char** args;
	char** vals;
};

int checkValidArguments(int numArgs, char** args)
{
	//Check to make sure we have arguments
	if(numArgs < 2)
	{
		printf("No arguments passed, exiting");
		return 0;
	}

	for(int i=0; i< numArgs; ++i)
	{
		if(args[i][0] == '-')
		{
			
		}
		else
		{
		}
	}
}//checkValidArgument(...) ends


//---------------------------------------------------------------------main(...)
int main(int argv, char** argc)
{
	checkValidArguments(argv, argc);

	return 1;
}//main(...) ends
