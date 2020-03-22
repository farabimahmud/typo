class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
  def edit; new_or_edit;  end
  def new; new_or_edit; end
    
  def new_or_edit
    if params[:id].nil?
      create_new_category
    else 
      edit_category
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end


  private
  
  def create_new_category
    if request.post?
      respond_to do |format|
        format.html { create_category }
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
    end
    @categories = Category.find(:all)
    render 'new'
  end


  def edit_category
    @categories = Category.find(:all)
    @category = Category.find(params[:id])
    # puts @category 
    if request.post?
      respond_to do |format|
        format.html { save_category }
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
      redirect_to :action => 'index' 
      return 
    end
    render 'new'
  end
  
  def create_category
    @category = Category.create!(params[:category])  
    flash[:notice] = _('Category was successfully saved.')
    @categories = Category.find(:all)
  end

  
  def save_category

    @category = Category.update(params[:id], params[:category])
    flash[:notice] = _('Category was successfully updated.')
    @categories = Category.find(:all)

    
  end

end
