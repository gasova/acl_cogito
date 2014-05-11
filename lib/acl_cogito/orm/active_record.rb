require 'active_record/connection_adapters/abstract/schema_definitions'

module AclCogito
  module Orm
    module ActiveRecord
      module Schema
        include AclCogito::Schema
        # Tell how to apply schema methods.
        def apply_schema(name, type, options={})
          column name, type.to_s.downcase.to_sym, options
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, AclCogito::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, AclCogito::Orm::ActiveRecord::Schema