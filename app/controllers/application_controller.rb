class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :getLocaleCode
  before_action :set_type_and_version
  before_action :config_devise_params, if: :devise_controller?

  include ApplicationHelper

  # put locale in url
  # - see: http://guides.rubyonrails.org/i18n.html#setting-the-locale-from-url-params
  # - see config/routes.rb locale scope, placing the locale after domain name and before rest of path (not in query string)
  # - now *_path and *_url now place locale in url
  def default_url_options
    { locale: I18n.locale }
  end

  private

  # set the locale codes in controllers: 'before_action :getLocaleCode'
  def getLocaleCode
    # first default locale to default locale
    @locale_code = Rails.application.config.i18n.default_locale
    # next set locale to the locale in user record
    @locale_code = current_user.try(:locale) || @locale_code
    # next set locale to the locale passed as the locale param
    if (params.present? &&
      params['locale'].present? &&
      BaseRec::VALID_LOCALES.include?(params['locale'].to_s)
    )
      @locale_code = params['locale']
    end
    # set the locale in I18n
    I18n.locale = @locale_code
    Rails.logger.debug "@locale_code: #{@locale_code.inspect}"
  end

  def set_type_and_version
    @treeTypeRec = TreeType.find(BaseRec::TREE_TYPE_ID)
    if @treeTypeRec.blank?
      raise "ERROR missing Tree Type Record"
    elsif @treeTypeRec.code != BaseRec::TREE_TYPE_CODE
      raise "ERROR invalid Tree Type Code"
    end
    @versionRec = Version.find(BaseRec::VERSION_ID)
    if @versionRec.blank?
      raise "ERROR missing Version Record"
    elsif @versionRec.code != BaseRec::VERSION_CODE
      raise "ERROR invalid Version Code"
    end
  end

  def config_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :given_name,
      :family_name,
      :govt_level,
      :govt_level_name,
      :municipality,
      :institute_type,
      :institute_name_loc,
      :position_type,
      :subject1,
      :subject2,
      :gender,
      :education_level,
      :work_phone,
      :work_address,
      :terms_accepted
    ])
  end

end
