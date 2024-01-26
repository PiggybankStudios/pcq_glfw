/*
File:   debug.c
Author: Taylor Robbins
Date:   05\11\2020
Description: 
	** Handles routing debug ouput from GLFW to the application
*/

#include "internal.h"
#include "debug.h"

#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>

#define ArrayCount(Array) (sizeof(Array) / sizeof((Array)[0]))

void GlfwDebugOutput(const char* filePath, uint32_t lineNumber, const char* funcName, bool isError, bool newLine, const char* message)
{
	if (_glfw.callbacks.debugOutput)
	{
		_glfw.callbacks.debugOutput(filePath, lineNumber, funcName, isError, newLine, message);
	}
}
void GlfwDebugPrint(const char* filePath, uint32_t lineNumber, const char* funcName, bool isError, bool newLine, const char* formatString, ...)
{
	char printBuffer[257];
	va_list args;
	va_start(args, formatString);
	uint32_t printLength = (uint32_t)vsnprintf(printBuffer, ArrayCount(printBuffer), formatString, args);
	va_end(args);
	printBuffer[ArrayCount(printBuffer)-1] = '\0';
	GlfwDebugOutput(filePath, lineNumber, funcName, isError, newLine, &printBuffer[0]);
}
