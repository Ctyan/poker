private Player[] player = new Player[NUMBER_OF_PLAYER];
private Card[] field = new Card[5];
public static int fieldCardCounter = 0;

public Poker(){
  for(int n=0;n<NUMBER_OF_PLAYER;n++){
    player[n] = new Player();
  }
}

public void addFieldCard(Card card) {
  if (fieldCardCounter < 5) {
    field[fieldCardCounter++] = card;
    println("The field have " + fieldCardCounter + " cards.");
  } else {
    println("ERROR : The field have already 5 cards!");
  }
}

public void addPlayerCard(Card card, int playerNumber) {
  if (0 <= playerNumber && playerNumber < NUMBER_OF_PLAYER) {
    player[playerNumber].addCard(card, playerNumber);
  } else {
    println("ERROR : Invalid numeric value.");
  }
}

public Card[] getFieldCards() {
  return field;
}
public Card[] getPlayerCards(int playerNumber) {
  if (0 <= playerNumber && playerNumber < NUMBER_OF_PLAYER) {
    return player[playerNumber].getCards();
  } else {
    println("ERROR : Invalid numeric value.");
    return null;
  }
}