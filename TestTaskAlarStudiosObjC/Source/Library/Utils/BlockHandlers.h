//
//  Block0.h
//  TestTaskAlarStudiosObjC
//
//  Created by Oleg Soloviev on 10.02.2019.
//  Copyright © 2019 varton. All rights reserved.
//

typedef void (^Block1Bool)(BOOL value);

static inline void Block1BoolSafeCall(Block1Bool action, BOOL value)
{
    if( NULL != action )
    {
        action(value);
    }
}
