# Cocoapods-Issue-Example

Demonstrates issue where app crashes due to image not found from dependency in included framework.

Download the zip.
Do 'pod install'
Configure signing credentials for the MemoryLeaksExample target.
Run MemoryLeaksExample

Error will be:


    dyld: Library not loaded: @rpath/NonEmpty.framework/NonEmpty
      Referenced from: /private/var/containers/Bundle/Application/F85E00E9-7532-4D71-87DC-D5513DDFA021/MemoryLeaksExample.app/Frameworks/CMUtilities.framework/CMUtilities
      Reason: image not found
      
MemoryLeaksExample includes CMUtilities framework
CMUtilities framework as dependency on PointFree-Validated pod.
PointFree-Validated pod has dependency on NonEmpty pod.
