class Transaction {
  String name;
  String phoneNumber;
  int montant;
  DateTime dateTime;
  bool isSend;

  Transaction(
      this.name, this.phoneNumber, this.montant, this.dateTime, this.isSend);
}
