

void endListen() {

  tweet.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      tweet.setToLoopStart();
      tweet.pause(true);
    }
  }
  );



  phone.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      phone.setToLoopStart();
      phone.pause(true);
    }
  }
  );

  vm.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      vm.setToLoopStart();
      vm.pause(true);
    }
  }
  );

  mail.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      mail.setToLoopStart();
      mail.pause(true);
    }
  }
  );

  text.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      text.setToLoopStart();
      text.pause(true);
    }
  }
  );


    textToSpeech.setEndListener(new Bead() {
    public void messageReceived(Bead mess) {
      textToSpeech.setToLoopStart();

      textToSpeech.pause(true);
      println("TEXT TO SPEECH" + textToSpeech.isPaused());
    }
  }
  );

}
