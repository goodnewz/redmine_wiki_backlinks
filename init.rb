require 'wiki_links_hook_listener'

Rails.configuration.to_prepare do
  unless WikiContent.included_modules.include?(WikiLinksWikiContentPatch)
    WikiContent.send(:include, WikiLinksWikiContentPatch)
  end
  unless WikiContent.included_modules.include?(WikiLinksWikiPagePatch)
    WikiPage.send(:include, WikiLinksWikiPagePatch)
  end
  unless WikiContent.included_modules.include?(WikiLinksWikiPatch)
    Wiki.send(:include, WikiLinksWikiPatch)
  end
end

Redmine::Plugin.register :redmine_wiki_backlinks do
  name 'Redmine Wiki Backlinks plugin'
  author 'Antonio Garcia-Dominguez'
  description 'Provides reports with backlinks, orphan pages and wanted pages for Redmine wikis'
  version '0.0.2'
  url 'http://github.com/bluezio/redmine_wiki_backlinks'
  author_url 'http://neptuno.uca.es/~agarcia'

  # Add the permission to the Wiki module
  project_module :wiki do
    permission :view_wiki_links, {
      :wiki_links => [:links_to, :links_from,:orphan, :wanted]
    }, :read => true
  end

  requires_redmine :version_or_higher => '2.2'

  menu :admin_menu,
       :wiki_links,
       { :controller => 'wiki_links', :action => 'index'},
       :caption => :label_admin_wiki_links,
       :html => {:class => 'icon icon-wiki-links wiki-links'}

end
