public class Player{
  
  private Card playerCards[] = new Card[2];
  private int cardCounter = 0;
  
  public void addCard(Card card, int playerNumber){
    if(cardCounter < 2){
      playerCards[cardCounter++] = card;
      println("Player" + playerNumber + " have " + cardCounter + " cards.");
    }else {
      println("ERROR : This player have already 2 cards!");
    }
  }
  
  public Card[] getCards(){return playerCards;}
  
}