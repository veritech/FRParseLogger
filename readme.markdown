FRParseLogger
-------------

Ever wanted to collect logs from beta testers without doing any additional steps?

Well here's one solution. *FRParseLogger* implements the [Parse](http://parse.com) API within a DDLogger to enable your code to send it's logging data directly to your Parse account (as *FRParseLogger* objects).

The setup is fairly simple you'll need a parse account, and if your not already using parse in your app, you will need to insert your parse app id and key into the file.

If your not familiar with [CocoaLumberJack](https://github.com/robbiehanson/CocoaLumberjack), you'll also need to set this up, and then register the *FRParseLogger* with the *DDLog* instance like so:

	[DDLog addLogger:[FRParseLogger sharedInstance]];

After that your logging statements (made with the *DDLog* macros) will appear in your Parse acount as *FRParseLogger* objects.

This solution is best used when your working with a small team of beta testers as Parse's as request limits setup, and depending on how verbose your logging is, you may use up your free allowance fairly rapidly.

Contact [Jonathan Dalrymple](http://twitter.com/veritech)

Dependencies
[Parse](http://parse.com)
[CocoaLumberJack](https://github.com/robbiehanson/CocoaLumberjack)