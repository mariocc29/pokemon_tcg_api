# frozen_string_literal: true

# PokemonCardsIndexerJob class representing a background job for indexing Pokemon cards
class PokemonCardsIndexerJob < ApplicationJob
  queue_as :default

  # Performs the indexing of Pokemon cards data
  # @param page [Integer] The page number of data to fetch
  def perform(page = 1)
    response = fetch_data(page)
    CardIndex.import response['data']

    return unless page == 1

    total_records = response['totalCount']
    batch_size = response['count']

    num_batches = (total_records / batch_size).ceil
    num_batches.times do |batch_index|
      next if batch_index.zero?
      PokemonCardsIndexerJob.perform_later(batch_index + 1)
    end
  end

  private

  # Fetches Pokemon card data from the API for the specified page
  # @param page [Integer] The page number of data to fetch
  # @return [Hash] The response data from the API
  def fetch_data(page)
    pokemon_service = Pokemon::Service.instance
    pokemon_service.endpoint = 'cards'
    pokemon_service.querystring = "page=#{page}"
    pokemon_service.get
  end
end
