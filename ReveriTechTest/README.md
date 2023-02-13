

Reveri Senior iOS interview demo project
==================================

We expect candidates to submit a demo project for review.
This can be:
1. [The Reveri iOS project described below](#1-the-reveri-demo-project)
2. [An existing project](#2-something-youve-already-built)

**IMPORTANT**:
* Submissions should be either hosted and linked through a public repo or sent to tristan@reveri.com
* Please send your submission as a `.zip`
* The project should compile and run with Xcode 14.


### Our goals with this test
* Establish that you value similar things to us (simplicity, testability, readability, maintainability)
* See how you think and which problems you decide to tackle 
* Establish a gauge of your technical competence with Swift and iOS frameworks
* See what UI, UX and accessibility considerations you choose to spend time on
* Set the foundation for further conversations from a common point of reference
* Review your attention to detail

### Some advice before starting

* Timebox your submission to less than 2 hours, your time is valuable (ours is too)
* Write production-quality code - if you find you need to cut features for time, mention what you would have done
* When you make unclear but deliberate choices, add a comment
* Keep in mind best practices using patterns such as SOLID to guide your implementation
* We use SwiftUI, Combine, and Swift Concurrency but we don't expect everyone to know all of these
* Use the latest technologies that _you know how to use_ and that illustrate your strengths
* Find an architecture that you think works for this project
* If you use third party libraries and frameworks, be ready to explain your reasons

### 1. The Reveri project

The app should comprise of a list of products with the ability to add products to a cart that you can manage.

#### Products List

_Show a list of products._

A product has a brand, title, description, price, stock level, images and other metadata.
You can decide what to show and how to display it but show at least one image.

To retrieve products use the following API:

* https://dummyjson.com/docs/products
* The API returns a pageable list of items with configurable fetch limit and skip behaviour

_Expose the ability to add a product to your cart._

* You should only be able to add products up to the number of items in stock 

#### Cart

_Enable showing a shopping cart detailing the products and quantities added._

_How you choose to display the cart is up to you_

* You should be able to increase and decrease the number of products



#### Project Requirements

The following should be met:

* The project should compile and run on Xcode 14
* Products and images shown should be available offline
* The code should be production-worthy
* We use SwiftUI, Combine and Swift Concurrency, use at least one of these technologies in your submission


### 2. An existing project you built

If you already have an existing project that covers the project requirmements above (even a tech test for another company), so long as it:

* Is non-trivial
* Is clear that you are the author
* Meets the other requirements above

Attach some additional context about the project where it's not clear from the submission itself and send it to us.


#### Thank you for your time! We look forward to hearing from you!
Team Reveri

