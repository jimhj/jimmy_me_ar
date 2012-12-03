# coding: utf-8
class BlogsController < ApplicationController
  before_filter :require_login, :except => [:show, :index, :find_all_by_tag]

  def index
    @blogs = Blog.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    set_seo_meta
  end

  def show
    @blog = Blog.find_by_slug(params[:slug])
    set_seo_meta(@blog.title, nil, nil)
  end

  def new
    @blog = Blog.new
    set_seo_meta
  end

  def create
    blog = Blog.create(params[:blog])
    flash[:error] = blog.errors.full_messages
    redirect_to :back
  end

  def edit
    @blog = Blog.find_by_id(params[:id])
    set_seo_meta
  end

  def update
    blog = Blog.find_by_id(params[:id])
    if blog.update_attributes(params[:blog])
      redirect_to blog_path(blog.slug)
    else
      flash[:error] = blog.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    blog = Blog.find_by_id(params[:id])
    blog.destroy
    redirect_to blogs_path
  end

  def find_all_by_tag
    @blogs = Blog.where("tags LIKE '%#{params[:tag]}%'").order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    set_seo_meta
    render :action => :index
  end

end