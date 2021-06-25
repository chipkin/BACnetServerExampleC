/*
 * CAS BACnet Stack Example "C"
 * ----------------------------------------------------------------------------
 * This project is used to show how to compile "C" files and the "CPP" files from 
 * the CAS BACnet Stack together into a single project. 
 * 
 * More information https://github.com/chipkin/BACnetServerExampleCPP
 * 
 * Created by: Steven Smethurst
 */

#include "CASBACnetStackAdapter.h"
#include <stdio.h>

int main(int argc, char** argv)
{
	printf("hello world\n");

	// 1. Load the CAS BACnet stack functions
	// ---------------------------------------------------------------------------
	printf("FYI: Loading CAS BACnet Stack functions... \n");
	if (!LoadBACnetFunctions()) {
		printf("Error: Failed to load the functions from the DLL\n" );
		return 1;
	}

	// Print the version to show that the CAS BACnet Stack compiled correctly.
	printf( "FYI: CAS BACnet Stack version: %d.%d.%d.%d\n", fpGetAPIMajorVersion(), fpGetAPIMinorVersion(), fpGetAPIPatchVersion(), fpGetAPIBuildVersion() ); 

	return 0; 
}