# Step Counter
Step Counter is an iOS sample project of [IceCream](https://github.com/caiyue1993/IceCream). IceCream itself provides an example project as well. However, it is hard to test it. As it used SPM and SPM can't solve the dependencies well here.

So I created my own iOS sample project here. Also, there are some tips that are important and not mentioned in the original docs.

> For testing CloudKit, you should do it in two real devices, or the remote push notification may never triggered. 
> Don't forget to log in the same iCloud account.

## When Model
> IceCream supports Realm 10. But not all. You can't used many new features like `ObjectId` and `@@Persisted`.
> 
> Also, there are limitation when you are using `primaryKey`.
> 
> IceCream request you to provide `primaryKey` in every model class.

```swift
// For more: https://developer.apple.com/documentation/cloudkit/ckrecord/id/1500975-init
assert(primaryValueString.allSatisfy({ $0.isASCII }), "Primary value for CKRecord name must contain only ASCII characters")
assert(primaryValueString.count <= 255, "Primary value for CKRecord name must not exceed 255 characters")
assert(!primaryValueString.starts(with: "_"), "Primary value for CKRecord name must not start with an underscore")
```

## How to testing
1. download source code
2. pod install
3. open "Step Counter.xcworkspace"

## References
* [Deploying an iCloud Container’s Schema](https://developer.apple.com/documentation/cloudkit/managing_icloud_containers_with_the_cloudkit_database_app/deploying_an_icloud_container_s_schema)