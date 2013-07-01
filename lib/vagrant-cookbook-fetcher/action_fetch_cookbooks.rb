require_relative "guts"

module VagrantPlugins
  module CookbookFetcher
    class FetchCookbooksAction

      def initialize(app, env)
        @app = app
      end
      
      def call(env)

        vcf_config = env[:machine].config.cookbook_fetcher
        unless vcf_config.disable then
          CookbookFetcher.perform_fetch(env)
        else
          env[:ui].info "Cookbook fetching disabled, skipping"
        end
        
        # Continue daisy chain
        @app.call(env)        
      end
    end
  end
end
