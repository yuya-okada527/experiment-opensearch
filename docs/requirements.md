# 検証要件

## 要件

- dynamic templates
- nested fields
- 各種のデータ型

## サンプルデータ構造

### index 構築

#### 作成

```curl
PUT /test-products
```

#### 確認

```curl
GET /test-products
```

### mapping 定義

#### 作成

```curl
PUT /test-products/_mapping
{
  "properties": {
    "product_number": { "type": "integer" },
    "product_name": { "type": "keyword" },
    "is_enabled": { "type": "boolean" }
  }
}
```

#### 確認

```curl
GET /test-products/_mapping
```

### ドキュメント登録

##### TODO bulk インサートが動かない

```json
POST /test-products/_doc/1
{"product_number": 1, "product_name": "商品1", "is_enabled": true}

GET /test-products/_doc/1
```
