# Swift Scripting

This repo demonstrates how you can use Swift to write commandline scripts. It forms the basis of a screencast available at https://videos.raywenderlich.com.

Feel free to say hi: [@iwantmyrealname](https://twitter.com/iwantmyrealname).


samx


## Notes

To set the toolchain for the current session only:

```sh
$ export DEVELOPER_DIR=/Applications/Xcode9β1.app
```

To build the RandomStringGeneration directory as a dylib:

```sh
$ swiftc -emit-library -o RandomStringGeneration/libRandomStringGeneration.dylib -target x86_64-apple-macosx10.13 -emit-module -module-name RandomStringGeneration RandomStringGeneration/*.swift
```
