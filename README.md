# Azure Easy Auth library for iOS

This repository contains source code for _Azure Easy Auth_ iOS library. For more details about _Azure Easy Auth_, refer https://docs.microsoft.com/en-us/azure/app-service/app-service-authentication-overview.

## Repository structure

The repository contains 2 directories at the root:
- `src` - This contains the library source code and an XCode project `AzureEasyAuth.xcodeproj` for it
- `demo` - This contains a demo project `AzureEasyAuthDemo.xcodeproj`

The `AzureEasyAuth.xworkspace` defines an XCode workspace containing both, the demo project and the library project.

## Build

The XCode project `AzureEasyAuth.xcodeproj` defines 3 targets:
- `AzureEasyAuth` - This builds a static library `libAzureEasyAuth.a`
- `AzureEasyAuthUniversalFramework` - This builds a universal static framework (containing a fat static library) `AzureEasyAuth.framework` that can run on all architectures (simulator as well as device)
- `AzureEasyAuthDynamicFramework` - This builds a dynamic framework `AzureEasyAuth.framework`

To build, open `AzureEasyAuth.xworkspace` or `AzureEasyAuth.xcodeproj` in Xcode and build for any of the above targets

## Demo

To run the demo project, open `AzureEasyAuth.xworkspace` in XCode, select the `AzureEasyAuthDemo` target and run.

## Contribute Code or Provide Feedback
This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

If you would like to become an active contributor to this project please follow the instructions provided in [Microsoft Azure Projects Contribution Guidelines](http://azure.github.com/guidelines.html).

If you encounter any bugs with the library please file an issue in the [Issues](https://github.com/Azure/azure-easyauth-ios/issues) section of the project.
