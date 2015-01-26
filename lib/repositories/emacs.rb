class Repositories
  class Emacs < Base
    HAS_VERSIONS = false
    HAS_DEPENDENCIES = true
    URL = 'http://melpa.org'

    def self.project_names
      projects.keys.sort
    end

    def self.projects
      @projects ||= get("http://melpa.org/archive.json")
    end

    def self.project(name)
      projects[name].merge({"name" => name})
    end

    def self.mapping(project)
      {
        :name => project["name"],
        :description => project["desc"],
        :repository_url => project.fetch("props", {}).try(:fetch, 'url', ''),
        :keywords => project.fetch("props", {}).try(:fetch, 'keywords', []).try(:join, ',')
      }
    end
  end
end
