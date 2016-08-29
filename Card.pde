public class Card {
  private int mark;
  private int number;

  public static final int SPADE = 0;
  public static final int HEART = 1;
  public static final int CLUB = 2;
  public static final int DIAMOND = 3;

  public Card(int m, int num) {
    mark = m;
    number = num;
  }

  @Override
    public String toString() {
    String mark, number;
    switch (this.mark) {
    case SPADE:
      mark = "S";
      break;

    case HEART:
      mark = "H";
      break;

    case CLUB:
      mark = "C";
      break;

    case DIAMOND:
      mark = "D";
      break;

    default:
      mark = " ";
      break;
    }

    switch (this.number) {
    case 1:
      number = " A";
      break;

    case 11:
      number = " J";
      break;

    case 12:
      number = " Q";
      break;

    case 13:
      number = " K";
      break;

    default:
      if (2 <= this.number && this.number <= 9) {
        number = " " + String.valueOf(this.number);
      } else if(this.number == 10){
        number = "10";
      } else {
        number = "  ";
      }
      break;
    }

    return " [" + mark + "," + number + "] ";
  }

  public int getMark() {return mark;}
  public int getNumber() {return number;}
  
}