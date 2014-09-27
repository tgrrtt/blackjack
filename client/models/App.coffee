#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on('hit', @checkPlayerHand, this)
    @get('playerHand').on('stand', @playDealer, this)

    @checkInitialScores()

  checkPlayerHand: ->
    scores = @get('playerHand').scores()
    if scores[0] > 21
      @outcomes('player bust')

  checkInitialScores: ->
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').dealerScores()
    # console.log playerScores
    # console.log dealerScores
    if (playerScores[1] == 21)
      @outcomes('player blackjack');
    if (dealerScores[1] == 21)
      @outcomes('dealer blackjack');

  newHand: ->
    # if deck length < 26
    # reset everything (but not chip count)
    # reset hand collection ( not delete)
    # pop 2 cards off deck
    newPlayerHand = [@get('deck').pop(),@get('deck').pop()]
    # add them to hands
    @get('playerHand').reset(newPlayerHand)
    newDealerHand = [@get('deck').pop().flip(),@get('deck').pop()]
    @get('dealerHand').reset(newDealerHand)
    @trigger('newHand')

  playDealer: ->
    @get('dealerHand').at(0).flip()
    dlrScores = @get('dealerHand').dealerScores()
    console.log('before dealer hit', dlrScores)

    while (dlrScores[1]<= 17) or ((not dlrScores[1]) and (dlrScores[0]<=16))
      @get('dealerHand').hit()
      dlrScores = @get('dealerHand').dealerScores()
      console.log dlrScores

    if dlrScores[1] > 21
      @outcomes('dealer bust')
    else
      @outcomes('compare scores')

  outcomes: (eventType) ->
    switch eventType
      when 'player blackjack'
        alert('player blackjack!')
      when 'dealer blackjack'
        alert('dealer blackjack!')
      when 'player bust'
        alert('player busted!')
      when 'dealer bust'
        alert('dealer bust')
      else
        # compare scores
        console.log('scores compared')
        playerScore = if @get('playerHand').scores()[1] <= 21 then @get('playerHand').scores()[1] else @get('playerHand').scores()[0]
        dealerScore = if @get('dealerHand').scores()[1] <= 21 then @get('dealerHand').scores()[1] else @get('dealerHand').scores()[0]
        if playerScore == dealerScore
          alert('push!')
        else if playerScore > dealerScore
          alert('You Win!')
        else
          alert('You Suck At LIFE!')




























