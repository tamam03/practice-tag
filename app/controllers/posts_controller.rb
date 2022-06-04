class PostsController < ApplicationController
  
def create
   @post = current_user.posts.new(post_params)
  # ログインユーザーのuser_idで投稿を作成
   tag_list = params[:post][:tag_name].split(nil)
  # formから@postオブジェクトを参照してtag_nameも送信
  # split(nil)→送信されてきた値をスペースで区切って配列化　　（？）
    if @post.save
      @post.save_tag(tag_list)
      # tag_listの配列を保存
      
      save_tag(sent_tag)
      current_tags = self.tags.plunk(:tag_name)unless self.tags.nil?
      # createで保存した@postに紐づいているタグが存在する場合、「タグの名前を配列として」全て取得
      # plunk→特定のカラムの値だけ
      # self→オブジェクトを指す特殊変数　　　　　　　　　　　（？）
      old_tags = current_tags - sent_tags
      # 現在取得した@postに存在するタグから新たに送信されてきたタグを除いたタグをold_tags
      new_tags = sent_tags - current_tags
      # 送られてきたタグから現在存在するタグを除いたタグをnew_tags
      
      old_tags.each do |old|
        self.post_tags.delete PostTag.find_by(tag_name: old)
      # 古いタグを削除
      
      new.tags.each do |new|
        new_post_tag = Tag.find_or_create_by(tag_name: new)
        新しいタグをひとつづつ取り出してデータベースに保存
        self.post_tags << new_post_tag
        
      
        redirect_to root_path
    else
      redirect_to root_path
    end
end
  
def index
    @tag_list = Tag.all
    # タグ一覧表示
    @posts = Post.all
    @post = current_user.posts.new
end
  
def show
end
  
  
  
private
 def post_params
    params.require(:post).permit(:content)
 end
  
  
end
