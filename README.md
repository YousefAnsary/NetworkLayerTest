
# NetworkingFramework
***Swift Framework That Simply Handles Any Network Operation for You.***

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

----

### Features

- [x] Fully Based on URLSessions and Written using Swift 4.2
- [x] Supports all Basic HTTP Methods, File Upload& Download
- [x] URL, JSON Parameter Encoding
- [x] Supports multipart uploading
- [x] Extends UIImageView to Set online Images Directly with caching options
- [x] Comes with a Variety of Response Handling Styles inluding Generic Dedcoding

----

### Requirements
- Swift 4.2+
- Xcode 11+

----

### Usage

&nbsp; &nbsp; **JetRequest**
| Method  | Params  | Completion |
| :------------ |:---------------:|:-----:|
| request      | stringURL: String, method: HTTPMethod, headers:<br/> StringsDictionary, parameters: Dictionary | Data?, URLResponse?, Error? |
| request      | stringURL: String, method: HTTPMethod, headers:<br/> StringsDictionary, parameters: Dictionary, validator: ClosedRange<Int> = 200...299 | Result<Dictionary, NetworkingError> |
| request      | stringURL: String, method: HTTPMethod, headers:<br/> StringsDictionary, parameters: Dictionary, decodingType: Codable.Type, decoder: JSONDecoder, validator: ClosedRange<Int> | Result<T, NetworkingError> |
| request      | request: Request, decodingType: Codable.Type, decoder: JSONDecoder, validator: ClosedRange<Int>,  | Result<T, NetworkingError> |
| upload //multipart | stringURL: String, objects: [Uploadables], headers: [String: String]?, parameters: [String: String]? | Data, URLResponse, Error |

----
&nbsp; &nbsp; **UIIMageView Extension**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| loadImage | fromUrl: String, defaultImage: UIImage | - |
| cancelImageLoad | - | - |