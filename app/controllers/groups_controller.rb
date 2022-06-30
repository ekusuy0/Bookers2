class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.owner_id = current_user.id
      @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user
      redirect_to groups_path
    end
  end
end
