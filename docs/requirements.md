# 検証要件

## 要件

- [dynamic templates](https://www.elastic.co/guide/en/elasticsearch/reference/7.10/dynamic-templates.html)
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
PUT /test-products
{
  "mappings": {
    "dynamic_templates": [
      {
        "dynamic_string": {
          "match": "*_str",
          "mapping": {
            "type": "keyword"
          }
        }
      },
      {
        "dynamic_boolean": {
          "match": "*_bool",
          "mapping": {
            "type": "boolean"
          }
        }
      },
      {
        "dynamic_localed_string": {
          "match": "*_localed_string",
          "mapping": {
            "type": "object",
            "properties": {
              "ja": { "type": "keyword" },
              "en": { "type": "keyword" }
            }
          }
        }
      }
    ],
    "properties": {
      "product_number": { "type": "integer" },
      "product_name": { "type": "keyword" },
      "is_enabled": { "type": "boolean" },
      "localed_string": {
        "properties": {
          "ja": { "type": "keyword" },
          "en": { "type": "keyword" }
        }
      }
    }
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
{
  "product_number": 1,
  "product_name": "商品1",
  "is_enabled": true,
  "other_str": "hoge",
  "other_bool": true,
  "localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "other_localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "array": [
    "hoge",
    "fuga"
  ]
}

POST /test-products/_doc/2
{
  "product_number": 2,
  "product_name": "商品2",
  "is_enabled": true,
  "other_str": "hoge",
  "other_bool": false,
  "localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "other_localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "array": [
    "hoge",
    "fuga"
  ]
}

POST /test-products/_doc/3
{
  "product_number": 3,
  "product_name": "商品3",
  "is_enabled": true,
  "other_str": "fuga",
  "other_bool": false,
  "localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "other_localed_string": {
    "ja": "日本語",
    "en": "English"
  },
  "array": [
    "hoge",
    "fuga"
  ]
}
```

```json
GET /test-products/_doc/1
```

### ファセット検索

```
GET /test-products/_search
{
  "size": 0,
  "aggs": {
    "categories": {
      "terms": {
        "field": "other_bool",
        "size": 10
      }
    }
  },
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "other_str": "hoge"
          }
        }
      ]
    }
  }
}
```
