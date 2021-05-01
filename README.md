
# NetworkingFramework
***Swift Framework That Simply Handles Any Network Operation for You.***

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)

----

### Features

- [x] Fully Based on URLSessions and Written using Swift
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

&nbsp; &nbsp; **NetworkingFramework**
| Method  | Params  | Completion |
| :------------ |:---------------:|:-----:|
| request      | stringURL: String, method: HTTPMethod, <br/>headers: StringsDictionary?,<br/> parameters: Dictionary? | Data?, URLResponse?, Error? |
| request      | stringURL: String, method: HTTPMethod, <br/>headers: StringsDictionary?,<br/> parameters: Dictionary?, validator: ClosedRange<Int>? | Result<Dictionary, NetworkingError> |
| request<T: Codable>      | stringURL: String, method: HTTPMethod, <br/>headers: StringsDictionary?, parameters: Dictionary?, decodingType: T.Type, decoder: JSONDecoder?, validator: ClosedRange<Int>? | Result<T, NetworkingError> |
| request<T: Codable>      | request: Request, decodingType: Codable.Type,<br/> decoder: JSONDecoder?, validator: ClosedRange<Int>?,  | Result<T, NetworkingError> |
| upload //multipart | stringURL: String, objects: [Uploadables],<br/> headers: [String: String]?, parameters: [String: String]? | Data?, URLResponse?, Error? |

----
&nbsp; &nbsp; **UIIMageView Extension**
| Method  | Params  | Return Type |
| :------------ |:---------------:|:-----:|
| loadImage | fromUrl: String, defaultImage: UIImage | - |
| cancelImageLoad | - | - |
