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
    console.log scores

  checkInitialScores: ->
    playerScores = @get('playerHand').scores()
    dealerScores = @get('dealerHand').dealerScores()
    # console.log playerScores
    # console.log dealerScores
    if (playerScores[1] == 21)
      console.log('Player BlackJack')
    if (dealerScores[1] == 21)
      console.log('Dealer BlackJack')

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

    # if dealer hand[1]
    #   hit if dealer hand[1] < 18
    # else if dealer hand[0] < 17
    #   hit

    while (dlrScores[1]<= 17) or ((not dlrScores[1]) and (dlrScores[0]<=16))
      @get('dealerHand').hit()
      dlrScores = @get('dealerHand').dealerScores()
      console.log dlrScores

  outcomes: (eventType) ->
    if eventType is 'player blackjack'
      console.log('player blackjack!')
    else if eventType is 'dealer blackjack'
      console.log('dealer blackjack!')
    else if eventType is 'player bust'
      console.log('player busted!')
    else if eventType is 'dealer bust'
      console.log('dealer busted!')
    else
      # compare scores

