class SuggestionPresenter < BasePresenter
  presents :suggestion

  def progress_in_favour
    total = suggestion.votes_in_favour_and_against
    in_favour = suggestion.votes_in_favour
    if total != 0
      return ((in_favour.to_f / total) * 100).to_i
    else
      return 0
    end
  end

  def progress_against
    against = suggestion.votes_against
    if against != 0
      return 100 - progress_in_favour
    else
      return 0
    end
  end

  def suggestion_closed_icon
    if suggestion.closed?
      h.content_tag :i, nil, class: 'lock glyphicon glyphicon-lock', :"data-toggle" => 'tooltip', :"data-title" => I18n.t('suggestions.show.info_suggestion_closed')
    end
  end
end
