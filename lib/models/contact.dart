class Contact {
  final int id;
  final String name;
  final int numberAccount;

  Contact(this.name, this.numberAccount, this.id);

  @override
  String toString() {
    return 'name: $name, account: $numberAccount, id:$id';
  }
}
