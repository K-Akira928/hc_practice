## REST APIについて自分の言葉でまとめる
RESTという設計ルールに基づいて設計されたAPI(ApplicationProgrammingInterface)  
RESTで求められている原則に従っていることをRESTfulと言い、その原則は6種類

1. クライアント/サーバー
1. ステートレス
1. キャッシュ制御
1. 統一インターフェース
1. 階層化システム
1. コードオンデマンド

そしてこの原則に乗っ取って設計されたREST APIのレベルは4つのレベルに分類できる

1. LEVEL0 HTTPを使っている
1. LEVEL1 リソースの概念を導入
1. LEVEL2 HTTPの動詞を導入
1. LEVEL3 HATEOSの概念を導入

## movieをリソースとして CRUD操作のURI、HTTPメソッドを定義

|      URI       | HTTP method |
|      ---       |     ---     |
| /api/movie/:id |     POST    |
| /api/movie/:id |     PUT     |
| /api/movie     |     GET     |
| /api/movie/:id |     GET     |
| /api/movie/:id |     DLETE   |