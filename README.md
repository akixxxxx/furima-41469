# テーブル設計

## usersテーブル

|column             |  type     |  options  |
|----------         |---------  |-----------|
|nick_name          |  string   |null:false |
| email             |  string   |null: false, unique: true |
|password           |  string   | null:false |
|encrypted_password |  string   | null: false|
| name_kanji        |  string   | null: false|
| name_hiragana     |  string   | null: false|
| name_katakana     |  string   | null: false|
| date_of_birth     |  string   | null:false |

### Association
- has_many : items
- has_many : purchase_records

## itemsテーブル

|column                        | type      |  options   |
|---------------------         | ------------|-----------|
| product_images               |  string   | null: false|
|product_names                 | text      | null: false|
|  product_descriptions        | text      | null: false|
| category_information         |  string   | null: false|
|product_condition_information |  string   | null: false|
|shipping_cost_information     |  string   | null: false|
|shipping_origin_information   |  string   | null: false|
|shipping_time                 |  string   | null: false|
|pricing_information           |  string   | null: false|

### Association
- belongs_to: users
- has_one :  purchase_records

## purchase_recordsテーブル

|column    | type      |  options   |
|-------   |-----------|------------|
|item      |references | null: false ,foreign_key: true|
|user      |references | null: false ,foreign_key: true|

### Association

- belongs_to : users
- belongs_to : items
- has_one    : shipping_informations

## shipping_informationsテーブル

|column                        | type      |  options   |
｜ーーーーーーーーーーーーーーーーー |-----------|------------|
|postal_code                   |string     |null:false  |
|prefecture                    |string     |null:false  |
|city                          |string     |null:false  |
|address                       |string     |null:false  |
|phone_number                  |string     |null:false  |

### Association
- belongs_to : purchase_records

