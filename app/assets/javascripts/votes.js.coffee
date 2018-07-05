App.Votes =

  hoverize: (votes) ->
    $(document).on {
      'mouseenter focus': ->
        $("div.participation-not-allowed", this).show()
        $("div.participation-allowed", this).hide()
      mouseleave: ->
        $("div.participation-not-allowed", this).hide()
        $("div.participation-allowed", this).show()
    }, votes

  update: (votable, data) ->
    $("a.like, a.unlike", votable).removeClass("no-voted").removeClass("voted")
    $("a.like", votable).addClass(data["classes"]["in_favor"])
    $("a.unlike", votable).addClass(data["classes"]["against"])

    $(".likes-percentage", votable).text(data["likes_percentage"])
    $(".unlikes-percentage", votable).text(data["dislikes_percentage"])
    $(".total-votes", votable).text(data["total_votes"])

  initialize: ->
    App.Votes.hoverize "div.votes"
    App.Votes.hoverize "div.supports"
    App.Votes.hoverize "div.debate-questions"
    App.Votes.hoverize "div.comment-footer"
    false
