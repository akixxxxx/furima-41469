# テーブル設計

## usersテーブル

|column             |  type     |  options  |
|----------         |---------  |-----------|
|nick_name          |  string   |null:false |
| email             |  string   |null: false, unique: true |
|encrypted_password |  string   | null: false|
| family_name  |  string   | null:false |
| given_name   |  string   | null:false |
| family_name_yomi     |  string   | null: false|
| given_name_yomi   |  string   | null:false |
| date_of_birth     |  date  　 | null:false |

### Association
- has_many : items
- has_many : purchase_records

## productsテーブル

|column                        | type      |  options   |
|---------------------         | ------------|-----------|
|product_names                 | string     | null: false|
|  product_descriptions        | text      | null: false|
| category_information_id         |  integer   | null: false|
|product_condition_information_id |  integer   | null: false|
|shipping_cost_information_id   |  integer   | null: false|
|shipping_origin_information_id   |  integer   | null: false|
|shipping_time_id                 |  integer   | null: false|
|pricing_information           |  integer   | null: false|

### Association
- belongs_to: user
- has_one : purchase_record

## purchase_recordsテーブル

|column    | type      |  options   |
|-------   |-----------|------------|
|item      |references | null: false ,foreign_key: true|
|user      |references | null: false ,foreign_key: true|

### Association

- belongs_to : user
- belongs_to : item
- has_one    : shipping_information

## shipping_informationsテーブル

|column                        | type      |  options   |
｜ーーーーーーーーーーーーーーーーー |-----------|------------|
|postal_code                   |string     |null:false  |
|shipping_origin_information_id   |  integer   | null: false|
|city                          |string     |null:false  |
|address                       |string     |null:false  |
|building_name                 |string     |            |
|purchase_record              |references | null: false ,foreign_key: true|
|phone_number                  |string     |null:false  |

### Association
- belongs_to : purchase_record

