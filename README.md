![Mobile Detect](http://demo.mobiledetect.net/logo-github.png)

> Motto: "Every business should have a mobile detection script to detect mobile readers."

MobileDetect is a CFC port of the Mobile_Detect PHP Library which was originally authored by
Victor Stanciu <vic.stanciu@gmail.com> and is now currently authored by
Serban Ghita <serbanghita@gmail.com> and Nick Ilyin <nick.ilyin@gmail.com>.

Their project is on GitHub and can be seen here<br />
https://github.com/serbanghita/Mobile-Detect

The site for their project is<br />
http://mobiledetect.net/

I've used this library in various PHP projects and decided to port it over to be able to use
in my ColdFusion Projects.

The library is used for detecting mobile devices (including tablets)
It uses the UserAgent string combined with specific HTTP headers to detect the mobile environment.

This current version is based on their 2.8.11 release

###Supported Versions
This CFC is script based and written using some of the new language enhancements in ColdFusion 11. Although making it compatible with earlier versions can be done by replacing the code using the Member Functions for their previous equivalent global functions.

###Differences from PHP Library
The one main difference is the "is" function. As it is a reserved word in ColdFusion I had to chage it to "_is". Below are some examples of how to use.

```coldfusion
MobileDetect = new MobileDetect();

// Basic Detection
MobileDetect.isMobile();
MobileDetect.isTablet();

// Magic Methods
MobileDetect.isIPhone();
MobileDetect.isSamsung();
// [...]

// Alternative to magic methods.
MobileDetect._is('iphone');

// Additional match method.
MobileDetect.match('regex.*here');

// Browser grade method.
MobileDetect.mobileGrade();

// Overwrite UserAgent or HttpHeaders to use
MobileDetect.setUserAgent(userAgent); // string
MobileDetect.setHttpHeaders(httpHeaders); // struct
```

This should help you familiarize with how the CFC works. You can compare it to their Wiki Page and get even more examples of how to use).

https://github.com/serbanghita/Mobile-Detect/wiki/Code-examples




