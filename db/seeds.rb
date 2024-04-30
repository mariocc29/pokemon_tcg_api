# frozen_string_literal: true

# Check if the CardIndex table is empty before performing the PokemonCardsIndexerJob.
# This ensures that the job is only executed when there are no existing records in the CardIndex.
if CardIndex.count == 0
  PokemonCardsIndexerJob.perform_now
end
