import 'dart:math';

class UtilsService {

  int getRandomInt(int length) {
    Random random = new Random();
    int randomNumber = random.nextInt(length);
    return randomNumber;
  }

  List<int> getMultipleRandomInst(int multipleNumber, int length) {  
    Random random = new Random();
    List<int> numbers = List<int>.generate(length, (index) => index);
    numbers.shuffle(random);
    List<int> randomNumbers = numbers.sublist(0, multipleNumber);
    return randomNumbers;
  }

}
