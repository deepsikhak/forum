class PostsController < ApplicationController

    def create
        post = Post.create(post_params)
        if post.save 
          render json: {"success": true, "message": "Post created"}
        else
          render json: {"success": false, "message": post.error}, status: :unprocessable_entity
        end
    end

    def update
        post= Post.find(params[:id])
        post.update_attribute(:body,params[:body]) 
        if post.save
            render json: {"success": true, "message": "Post body updated"}
        else
            render json: {"success": false, "message": "Couldnt be updated"}
        end
    end

    def index
        posts = Post.all
        render json: {"success": true, "Posts": posts.as_json}
    end

    def show
        post = Post.find(params[:id])
        if post
            render json: post.as_json(except: [:created_at,:updated_at, :deleted])
        else
            render json: {"success": false,"message":"Post with the given id doesnt exist"}
        end
    end

    def destroy
        post= Post.find(params[:id]).destroy
        if post.destroy
            render json: {"success": true, "message": "Posts deleted"}
        else
            render json: {"success": false, "message": "Couldnt be deleted"}
        end
    end

    def soft_delete
        post= Post.find(params[:id])
        post.deleted=true
        if post.save
            render json: {"success": true, "message": "Post body soft deleted"}
        else
            render json: {"success": false, "message": "Couldnt be deleted"}
        end
    end


    private

    def post_params
        params.require(:post).permit(:title,:body)
    end
end
