class CommentsController < ApplicationController

    def create
        comment = Comment.create(comment_params)
        if comment.save 
          render json: {"success": true, "message": "comment created"}
        else
          render json: {"success": false, "message": "comment couldnt be created"}, status: :unprocessable_entity
        end
    end

    def update
        comment= Comment.find(params[:comment_id])
        comment.update_attribute(:content,params[:content]) 
        if comment.save
            render json: {"success": true, "message": "comment body updated"}
        else
            render json: {"success": false, "message": "Couldnt be updated"}
        end
    end

    # def index
    #     comments = Comment.all
    #     render json: {"success": true, "comments": comments.as_json}
    # end

    def show
        begin 
            comment = Comment.find(params[:comment_id])
            render json: comment.as_json(except: [:created_at,:updated_at,:deleted])
        rescue Exception => e
            render json: {"success": false,"message":"comment with the given id doesnt exist"}
        end
    end

    def destroy
        comment= Comment.find(params[:comment_id]).destroy
        if comment.destroy
            render json: {"success": true, "message": "comments deleted"}
        else
            render json: {"success": false, "message": "Couldnt be deleted"}
        end
    end

    def soft_delete
        comment= Comment.find(params[:comment_id])
        comment.deleted=true
        if comment.save
            render json: {"success": true, "message": "comment body soft deleted"}
        else
            render json: {"success": false, "message": "Couldnt be deleted"}
        end
    end


    private

    def comment_params
        params.require(:comment).permit(:content,:post_id)
    end
end
