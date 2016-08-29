final static int NUMBER_OF_PLAYER = 6;
Deck aDeck;
Poker aPoker;

void setup() {

  aDeck = new Deck();
  aPoker = new Poker();

  aDeck.show();
  aDeck.deckShuffle();
  aDeck.show();

  addPlayerCard();

  aPoker.addFieldCard(aDeck.getNextCard());
  aPoker.addFieldCard(aDeck.getNextCard());
  aPoker.addFieldCard(aDeck.getNextCard());

  aPoker.addFieldCard(aDeck.getNextCard());
  aPoker.addFieldCard(aDeck.getNextCard());

  println("\n<< Player cards >>");
  for (int n=0; n<NUMBER_OF_PLAYER; n++) {
    print(" << Player" + n + " cards >>   ");
    for (int i=0; i<2; i++) {
      print(aPoker.getPlayerCards(n)[i].toString());
    }
    println();
  }

  println("\n<< Field cards >>");
  for (int i=0; i<fieldCardCounter; i++) {
    print(aPoker.getFieldCards()[i].toString());
  }
  println("\n");

  check();
}

void draw() {
}

void addPlayerCard() {
  for (int n=0; n<2; n++) {
    for (int i=0; i<NUMBER_OF_PLAYER; i++) {
      aPoker.addPlayerCard(aDeck.getNextCard(), i);
    }
  }
}

void check() {

  int[][] playerNumbersList = new int[NUMBER_OF_PLAYER][3];

  for (int playerNumber=0; playerNumber<NUMBER_OF_PLAYER; playerNumber++) {
    print("Player" + playerNumber + " is ");

    int[] marks = new int[4];
    for (int i=0; i<4; i++)marks[i] = 0;

    for (int i=0; i<2; i++)marks[aPoker.getPlayerCards(playerNumber)[i].getMark()]++;
    for (int i=0; i<fieldCardCounter; i++)marks[aPoker.getFieldCards()[i].getMark()]++;

    boolean flushFlag = false;

    for (int i=0; i<4; i++) {
      if (marks[i] == 5)flushFlag = true;
    }

    // ------------------------------------------------------------------------------------

    int[] numbers = new int[16];
    for (int i=0; i<16; i++)numbers[i] = 0;

    for (int i=0; i<2; i++)numbers[aPoker.getPlayerCards(playerNumber)[i].getNumber()]++;
    for (int i=0; i<fieldCardCounter; i++)numbers[aPoker.getFieldCards()[i].getNumber()]++;

    numbers[14] = numbers[1];

    int n[] = new int[5];
    for (int i=0; i<5; i++)n[i] = 0;

    boolean straightFlag = true;

    for (int i=1, j=0; i<15; i++) {
      n[numbers[i]]++;
      if (numbers[i] == 1) {
        if (j++ >= 1) {
          if (numbers[0]+1 != i)straightFlag = false;
        }
        numbers[0] = i;
      }
      if (numbers[i] == 2 || numbers[i] == 3 || numbers[i] == 4) {
        if (numbers[15] < i) numbers[15] = i;
      }
    }

    String num1 = new String();
    String num2 = new String();

    switch (numbers[0]) {
    case 1:
      num1 = " A";
      break;

    case 11:
      num1 = " J";
      break;

    case 12:
      num1 = " Q";
      break;

    case 13:
      num1 = " K";
      break;

    case 14:
      num1 = " A";
      break;

    default:
      if (2 <= numbers[0] && numbers[0] <= 9) {
        num1 = " " + String.valueOf(numbers[0]);
      } else if (numbers[0] == 10) {
        num1 = "10";
      } else {
        num1 = "  ";
      }
      break;
    }

    switch (numbers[15]) {
    case 1:
      num2 = " A";
      break;

    case 11:
      num2 = " J";
      break;

    case 12:
      num2 = " Q";
      break;

    case 13:
      num2 = " K";
      break;

    case 14:
      num2 = " A";
      break;

    default:
      if (2 <= numbers[15] && numbers[15] <= 9) {
        num2 = " " + String.valueOf(numbers[15]);
      } else if (numbers[15] == 10) {
        num2 = "10";
      } else {
        num2 = "  ";
      }
      break;
    }

    if (n[4] == 1) {
      println("FourCard !           | 8 " + num2 + "|");
      playerNumbersList[playerNumber][0] = 8;
      straightFlag = false;
    } else if (n[3] == 1) {
      if (n[2] == 1) {
        println("FullHouse !          | 7 " + num2 + "|");
        playerNumbersList[playerNumber][0] = 7;
        straightFlag = false;
      } else {
        println("ThreeCard !          | 3 " + num2 + "|");
        playerNumbersList[playerNumber][0] = 3;
        straightFlag = false;
      }
    } else if (n[2] == 2) {
      println("TwoPear !            | 2 " + num2 + "|" + num1);
      playerNumbersList[playerNumber][0] = 2;
      straightFlag = false;
    } else if (n[2] == 1) {
      println("OwnPear !            | 1 " + num2 + "|" + num1);
      playerNumbersList[playerNumber][0] = 1;
      straightFlag = false;
    } else {
      if (straightFlag && flushFlag) {
        if (numbers[0] == 14) {
          println("RoyalStraightFlush !| 10 ");
          playerNumbersList[playerNumber][0] = 10;
        } else {
          println("StraightFlush !      | 9 " + num1 + "|");
          playerNumbersList[playerNumber][0] = 9;
        }
      } else if (straightFlag && !flushFlag) {
        println("Straight !           | 5 " + num1 + "|");
        playerNumbersList[playerNumber][0] = 5;
      } else if (!straightFlag && flushFlag) {
        println("Flush !              | 6 " + num1 + "|");
        playerNumbersList[playerNumber][0] = 6;
      } else {
        println("HighCard .           | 0 " + num1 + "|");
        playerNumbersList[playerNumber][0] = 0;
      }
    }

    playerNumbersList[playerNumber][1] = numbers[0];
    playerNumbersList[playerNumber][2] = numbers[15];
  }

  int[][] winer = new int[NUMBER_OF_PLAYER][4];
  int winerCounter = 0;

  for (int n=0; n<NUMBER_OF_PLAYER; n++) {
    if (winer[winerCounter][0] > playerNumbersList[n][0]) {
      //break;
    } else if (winer[winerCounter][1] > playerNumbersList[n][1]) {
      //break;
    } else if (winer[winerCounter][2] > playerNumbersList[n][2]) {
      //break;
    } else {
      if(winer[winerCounter][0] == playerNumbersList[n][0] && 
         winer[winerCounter][1] == playerNumbersList[n][1] && 
         winer[winerCounter][2] == playerNumbersList[n][2])winerCounter++;
      for (int i=0; i<3; i++) {
        winer[winerCounter][i] = playerNumbersList[n][i];
      }
      winer[winerCounter][3] = n;
    }
  }
  
  println("\n<< WinerPlayer is ... >>");
  for(int i=0;i<=winerCounter;i++){
    println("Player" + winer[i][3] + " !!");
  }
  
}

/*
 
 プレイヤーの制限人数：
 15人
 
 カードの強さ：
 2 << K < A
 
 ハイカード：
 どの役も存在しない状態。
 ハイカード同士の戦いは最も強いカードを持っている方が勝ち。
 
 ワンペア：
 同じ数字のカードが２枚。
 ワンペア同士の戦いは強いカードを持っている方が勝ち。
 同じ数字のワンペア同士の場合は残りの３枚のカードでより強いカードを持っている方が勝ちとなる。
 
 ツーペア：
 ワンペアが２組。
 ツーペア同士の戦いは強いカードで作ったペアを持っている方が勝ち。
 ２組とも同じ数字の場合は残りの１枚が強いカードの方が勝ち。
 
 スリーカード：
 同じカードが３枚。
 スリーカード同士の戦いは強いカードで作ったスリーカードを持っている方が勝ち。
 
 ストレート：
 続き数字で５枚、かつその種類が同じでないとき。
 J・Q・K・A・２で役を作ることはできない。
 Aは、Aで始まるT・J・Q・K・Aか、Aで終わるA・２・３・４・５でしか役を作れない。
 ストレート同士の戦いは、より強いカードを持っている方が勝ち。
 
 フラッシュ：
 同じ種類が５枚。
 数字はばらばらでかまわない。
 フラッシュ同士の戦いは、強いカードを持っている方が勝ち。
 
 フルハウス：
 スリーカードとワンペアの組み合わせ。
 フルハウス同士の戦いは、スリーカードが強いほうが勝ち。
 
 フォーカード：
 同じ数字が４枚。
 
 ストレートフラッシュ：
 続き数字で５枚、かつ種類も同じ。
 
 ロイヤルストレートフラッシュ：
 同じ種類でT・J・Q・K・A。
 最強ハンド。
 
 */