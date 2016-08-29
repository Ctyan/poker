import java.util.ArrayList;
import java.util.Collections;

public class Deck {

  private ArrayList<Card> deck = new ArrayList<Card>();
  private int nextCardCounter = 0;

  public Deck() {
    for (int i=0; i<4; i++) {
      for (int j=0; j<13; ) {
        deck.add(new Card(i, ++j));
      }
    }
  }
  
  public void deckShuffle(){
    println("<< Deck is shuffling >>\n");
    Collections.shuffle(deck);
  }
  
  public Card getNextCard(){
    if(nextCardCounter < 4*13){
      return deck.get(nextCardCounter++);
    }else {
      println("ERROR : It will not exceed the number of cards.");
      return null;
    }
  }

  public void show() {
    System.out.println(this);
  }

  @Override
    public String toString() {
    String str = "<< DeckList is >>\n";
    int counter = 1;
    for (Card c : deck) {
      str += c.toString();
      if (counter++ == 13){
        str += "\n";
        counter = 1;
      }
    }
    return str;
  }
}