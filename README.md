##In Swift closures are not dispatched, they dispatch themselves

Forward was created in need of encapsulating and giving a place for our so often used GCD dispatch functions. Using GCD in Swift felt cumbersome in such a rich-in-features language because of their global scope. Forward gives a closure an ability to be dispatched by one of the most used GCD mechanisms. 

**Notice**

In Swift semicolons are optional but in case of inline closures which are about to be dispatched one has to put a semicolon at the end of last code line or else inline closure needs to be captured in (). This seems reasonable as compiler needs to know if the inline closure is a trailing closure connected to the above line or another independent line of code.


**Without semicolon before**

```
({ print("inline with parenthesis\n") })>>>forward_async(onQueue: dispatch_get_main_queue());
```

**With semicolon before**

```
{ print("inline without parenthesis\n") }>>>forward_async(onQueue: dispatch_get_main_queue())
```

**Supported GCD functions**

* dispatch_once (forward\_once)
* dispatch_async (forward\_async)
* dispatch_sync (forward\_sync)
* dispatch_after (forward\_after)

