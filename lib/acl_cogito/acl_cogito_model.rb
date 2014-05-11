require 'acl_cogito/acl_cogito_model/validations'

module AclCogito
  module AclCogitoModel

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    
      # Adds the Opinio functionallity to the model
      # You can pass a hash of options to customize the Opinio model
      def acl_cogito(*args)
        return if self.included_modules.include?(AclCogito::AclCogitoModel::Validations)
        options = args.extract_options!

        if Cogito.use_title
          attr_accessible :title 
        end
        attr_accessible :body

        belongs_to :commentable, :polymorphic => true, :counter_cache => options.fetch(:counter_cache, false) 
        belongs_to :owner, :class_name => options.fetch(:owner_class_name, AclCogito.owner_class_name)

        scope :owned_by, lambda {|owner| where('owner_id = ?', owner.id) }

        send :include, AclCogito::AclCogitoModel::Validations

        if AclCogito.accept_replies
          send :include, RepliesSupport
        end

        if AclCogito.strip_html_tags_on_save
          send :include, Sanitizing
        end

      end
    end

    module Sanitizing
      def self.included(base)
        base.class_eval do
          send :include, ActionView::Helpers::SanitizeHelper
          before_save :strip_html_tags
        end
      end

      private

      def strip_html_tags
        self.body = strip_tags(self.body)
      end
    end

    module RepliesSupport
      def self.included(base)
        base.class_eval do
          validate :cannot_be_comment_of_a_comments_comment
          acl_cogito_subjectum :order => 'created_at ASC'
        end
      end

      private

      # Validates that you cannot comment on a comment's comment
      def cannot_be_comment_of_a_comments_comment
        if new_record? && self.commentable_type == AclCogito.model_name
          if commentable.commentable_type == AclCogito.model_name
            errors.add :base, I18n.t('acl_cogito.messages.cannot_be_comment_of_comment')
          end
        end
      end

    end
  end
end