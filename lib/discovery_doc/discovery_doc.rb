require "yaml"

module DiscoveryDoc
  class DocBuilder
    ## Returns Markdown document from a file that specified by given filepath.
    ##
    ## @param filepath [String] File path to a discovery file.
    ## @return String
    def from_file(filepath)
      discovery = YAML.load_file(filepath)
      parse(discovery)
    end

    ## Returns built Markdown document.
    ##
    ## @param discovery [Hash]
    ## @return String
    def parse(discovery)
      doc = ""
      doc << parse_service(discovery["service"])
      doc << parse_endpoints(discovery["endpoint"])
      doc << parse_entities(discovery["entity"])
      doc
    end

    ## Working with Service

    def parse_service(service)
      name = service["name"]
      base_url = service["base_url"]

      doc = ""

      doc << "## #{name} Service \n\n"

      doc << "### Base URL \n\n"

      doc << base_url

      doc << "\n\n"

      doc
    end

    ## Working with Entity

    def parse_entities(entities)
      doc = ""

      doc << "## Entity\n\n"

      entities.each do |name, entity|
        doc << "### #{name} \n\n"

        doc << table_from_field_type_hash(entity)
      end

      doc
    end

    ## Working with Endpoint

    ## @param endpoints [Hash]
    def parse_endpoints(endpoints)
      doc = ""
      doc << "## Endpoint\n\n"

      endpoints.each do |name, endpoint|
        doc << parse_endpoint(name, endpoint)
      end

      doc
    end

    ## @param name [String] Endpoint's name
    ## @param endpoint [Hash]
    ## @return String
    def parse_endpoint(name, endpoint)
      doc = ""
      path = endpoint["path"]
      parameters = endpoint["params"]
      response = endpoint["response"]
      content_type = endpoint["content_type"]

      doc << "### `#{path}` (#{name}) \n\n"

      if content_type
        doc << "Content-Type: #{content_type}\n\n"
      end
      doc << parse_parameters(parameters)

      doc << parse_response(response)

      doc
    end

    ## @param parameters [Hash]
    def parse_parameters(parameters)
      return "" unless parameters

      doc = ""
      doc << "#### Parameters \n\n"

      if parameters.is_a?(String) or parameters.is_a?(Array)
        doc << link_to_entity(parameters)
      elsif parameters.is_a?(Hash)
        doc << table_from_field_type_hash(parameters)
      end

      doc
    end

    ## @param response [String|Hash|Array]
    def parse_response(response)
      doc = ""

      doc << "#### Response \n\n"

      if response.is_a?(String)
        doc << "[#{response}](##{response.downcase})\n\n"
      elsif response.is_a?(Array)
        doc << "[Array<#{response[0]}>](##{response[0].downcase})\n\n"
      else
        doc << table_from_field_type_hash(response)
      end

      doc
    end

    ## Helpers (Working with Markdown)


    ## @param entity [String|Array]
    def link_to_entity(entity)
      if entity.is_a?(String)
        "[#{entity}](##{entity.downcase})"
      elsif entity.is_a?(Array)
        "[Array(#{entity[0]})](##{entity[0].downcase})"
      end
    end

    ## Returns table markdown with Field to Type hash.
    ##
    ## @param field_type_hash [Hash]
    ## @return String
    def table_from_field_type_hash(field_type_hash)
      doc = ""
      doc << "|Field|Type|\n"
      doc << "|-----|----|\n"
      field_type_hash.each do |field, type|
        type = "Array<#{type[0]}>" if type.is_a?(Array) ## For [Entity] literal.
        doc << "|#{field}|`#{type}`|\n"
      end
      doc << "\n"

      doc
    end
  end
end