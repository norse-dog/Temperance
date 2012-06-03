//
//  Utils.h
//  Temperance
//
//  Created by Norse Dog on 6/1/12.
//  Copyright (c) 2012 Folkwang Enterprises. All rights reserved.
//

#ifndef Temperance_Utils_h
#define Temperance_Utils_h

void nd_log(NSString* msg, char* file, int line, char* method);

// Debug logging
#ifndef NOLOGGING
#define NDLog(msg, ...) \
    nd_log( \
        [NSString stringWithFormat:msg, ## __VA_ARGS__], \
        __FILE__, __LINE__, __PRETTY_FUNCTION__)
#else
#define NDLog(msg, ...)
#endif


#endif
