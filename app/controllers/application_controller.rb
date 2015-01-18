class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_user

  WillPaginate.per_page = 20

  SEX = [{id: 1, name: '男'}, {id: 2, name: '女'}]

  def current_user
    if !cookies[:user_id] || cookies[:user_id].empty?
      nil
    else
      if User.find(cookies[:user_id])
        User.find(cookies[:user_id])
      else
        User.new
      end
    end
  end

  def check_power
    if !current_user
      redirect_to :controller => :index, :action => :login
    else
      check_action unless current_user.id == 1
      get_price_log
    end
  end

  def get_price_log
    if current_user.id != 1
      user = User.find(current_user.id)
      puts user.name
      if user.tip_id
        @index_price_log_list = PriceLog.where("id > ?", user.tip_id).order(id: :desc)
      else
        @index_price_log_list = PriceLog.all.order(id: :desc)
      end
      if @index_price_log_list.count > 0
        user.tip_id = @index_price_log_list.first.id
        user.save
      end
    end
  end

  def check_action
    if current_user.actions.where("controller = ? and action = ?", params[:controller], params[:action]).empty?
      redirect_to controller: "index", action: "nopower"
    end
  end

  def get_car_no
    max_no = CarNo.maximum(:no)
    if max_no
      max_no = max_no + 1
    else
      max_no = 1
    end
    CarNo.create(:no => max_no)
    (DateTime.now.strftime("%Y%m%d").to_i*1000 + max_no).to_s
  end

  def get_customer_no
    max_no = CustomerNo.maximum(:no)
    if max_no
      max_no = max_no + 1
    else
      max_no = 1
    end
    CustomerNo.create(:no => max_no)
    (DateTime.now.strftime("%Y%m%d").to_i*1000 + max_no).to_s
  end

  private

  def set_user
    if current_user
      if session[:log_time] && session[:log_time] + 10.minutes < Time.now
        cookies.delete(:user_id)
        session[:log_time] = nil
        reset_session
        @current_user = User.new
      else
        session[:log_time] = Time.now
        @current_user = current_user
      end
    else
      @current_user = User.new
    end
  end
end

  # A custom renderer class for WillPaginate that produces markup suitable for use with Semantic.
  class SemanticPagination < WillPaginate::ActionView::LinkRenderer
    ELLIPSIS = "&hellip;"

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end.join(@options[:link_separator])

      tag("div", list_items, class: "pagination pagination-centered")
    end

    def container_attributes
      super.except(*[:link_options])
    end

    protected

    def page_number(page)
      link_options = @options[:link_options] || {}

      if page == current_page
        #link(page, nil, :class => "active")
        tag("li", link(page, nil), :class => "active")
      else
        #link(page, page)
        tag("li", link(page, page))
      end
    end

    def previous_or_next_page(page, text, classname)
      link_options = @options[:link_options] || {}

      if page
        tag("li", link(text, page, link_options))
        #link(tag("i", nil, class: classname), page, class: "icon item")
      else
        #tag("li", tag("span", text), class: "%s disabled" % classname)
        tag("li", link(text, nil), class: "active")
        #link(tag("i", nil, class: classname), nil, class: "icon item")
      end
    end

    def gap
      tag("li", link(ELLIPSIS, "#"), class: "disabled")
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      #previous_or_next_page(num, @options[:previous_label], "")
      previous_or_next_page(num, "上一页", "")
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      #previous_or_next_page(num, @options[:next_label], "")
      previous_or_next_page(num, "下一页", "")
    end

    def ul_class
      ["pagination", @options[:class]].compact.join(" ")
    end
  end
