

TextToSpeechMaker ttsMaker; 


void ttsExamplePlayback(String inputSpeech) {
 //create TTS file and play it back immediately
 //the SamplePlayer will remove itself when it is finished in this case
  
 String ttsFilePath = ttsMaker.createTTSWavFile(inputSpeech);
 println("File created at " + ttsFilePath);
  
  
 SamplePlayer textToSpeech = getSamplePlayer(ttsFilePath, true); 
 //true means it will delete itself when it is finished playing
 //you may or may not want this behavior!
  
 ac.out.addInput(textToSpeech);
 textToSpeech.setToLoopStart();
 textToSpeech.start();
}

