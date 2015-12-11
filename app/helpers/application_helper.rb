module ApplicationHelper

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true, tables: true, no_intra_emphasis: true)
    @markdown.render(content)
  end

  def image_link_to(image_path, target_link,options={})
    link_to(image_tag(image_path, :border => "0"), target_link, options)
  end  

   def avatar_url(user, size)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end

end
