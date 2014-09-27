#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on('hit', @checkPlayerHand, this)
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

  newDeck: ->

  newHand: ->
    # reset hand collection ( not delete)
    # pop 2 cards off deck
    newPlayerHand = [@get('deck').pop(),@get('deck').pop()]
    # add them to hands
    @get('playerHand').reset(newPlayerHand)
    console.log(@get('playerHand').scores())
    @trigger('newHand')
