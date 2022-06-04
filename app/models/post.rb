class Post < ApplicationRecord
  belongs_to :user
  
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  # throuth オプションによってtag_mapsを通してtagsとの関連づけを行う
  # →Post.tagsとすればPostに紐づけられたTagが取得できる
  # 中間テーブルにdependent　destroyをつけることでPost削除と同時にTagの削除ができる
  # ＜注意！！！＞throughオプションを使う場合、先に中間テーブルとの関連づけを行う必要がある
end
