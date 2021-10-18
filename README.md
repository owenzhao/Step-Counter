# Step Counter
Step Counter is an iOS sample project of [IceCream](https://github.com/caiyue1993/IceCream). IceCream itself provides an example project as well. However, it is hard to test it. As it used SPM and SPM can't solve the dependencies well here.

So I created my own iOS sample project here. Also, there are some tips that are important and not mentioned in the original docs.

> For testing CloudKit, you should do it in two real devices, or the remote push notification may never triggered. 
> Don't forget to log in the same iCloud account.

## How to testing
1. download source code
2. pod install
3. open "Step Counter.xcworkspace"
