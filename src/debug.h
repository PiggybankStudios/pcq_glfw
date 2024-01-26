/*
File:   debug.h
Author: Taylor Robbins
Date:   05\11\2020
*/

#ifndef _GLFW_DEBUG_H
#define _GLFW_DEBUG_H

void GlfwDebugOutput(const char* filePath, uint32_t lineNumber, const char* funcName, bool isError, bool newLine, const char* message);
void GlfwDebugPrint(const char* filePath, uint32_t lineNumber, const char* funcName, bool isError, bool newLine, const char* formatString, ...);

#define GlfwWrite_I(message)                         GlfwDebugOutput(__FILE__, __LINE__, __func__, false, false, (message))
#define GlfwWriteLine_I(message)                     GlfwDebugOutput(__FILE__, __LINE__, __func__, false, true,  (message))
#define GlfwPrint_I(formatString, ...)               GlfwDebugPrint (__FILE__, __LINE__, __func__, false, false, (formatString), ##__VA_ARGS__)
#define GlfwPrintLine_I(formatString, ...)           GlfwDebugPrint (__FILE__, __LINE__, __func__, false, true,  (formatString), ##__VA_ARGS__)

#define GlfwWrite_E(message)                         GlfwDebugOutput(__FILE__, __LINE__, __func__, true, false, (message))
#define GlfwWriteLine_E(message)                     GlfwDebugOutput(__FILE__, __LINE__, __func__, true, true,  (message))
#define GlfwPrint_E(formatString, ...)               GlfwDebugPrint (__FILE__, __LINE__, __func__, true, false, (formatString), ##__VA_ARGS__)
#define GlfwPrintLine_E(formatString, ...)           GlfwDebugPrint (__FILE__, __LINE__, __func__, true, true,  (formatString), ##__VA_ARGS__)

#endif //_GLFW_DEBUG_H