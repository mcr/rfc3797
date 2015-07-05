rfc3797
=======

Easily compiled version of RFC3797: Publicly Verifiable Random Selection

Also contains a copy of the MD5 reference implementation from RFC 1321.

The code contains one globals.h change relative to the MD5 code in RFC 1321:

* OLD: typedef unsigned long int UINT4;
* NEW: typedef unsigned int UINT4;

This typedef works better on modern (2015) machines; leaving it as-is
produces wrong hashes.
