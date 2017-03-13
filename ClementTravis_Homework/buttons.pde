ControlP5 p5;

void buttons() {


  p5 = new ControlP5(this);



 p5.addButton("WorkingOut")
    .setPosition(0, 50)
    .setSize(80, 80)
    .setLabel("Working Out")
    ;


  p5.addButton("Walking")
    .setPosition(80, 50)
    .setSize(80, 80)
    .setLabel("Walking")
    ;

  p5.addButton("Socializing")
    .setPosition(160, 50)
    .setSize(80, 80)
    .setLabel("Socializing")
    ;


  p5.addButton("Presenting")
    .setPosition(240, 50)
    .setSize(80, 80)
    .setLabel("Presenting")
    ;

//// Event buttons and other
 p5.addButton("Heartbeat")
    .setPosition(0, 150)
    .setSize(80, 80)
    .setLabel("Heart Beat")
    ;


  p5.addButton("Data1")
    .setPosition(80, 150)
    .setSize(80, 80)
    .setLabel("Stream \nExampleData_1")
    ;

  p5.addButton("Data2")
    .setPosition(160, 150)
    .setSize(80, 80)
    .setLabel("Stream \n ExampleData_2")
    ;


  p5.addButton("Debug")
    .setPosition(240, 150)
    .setSize(80, 80)
    .setLabel("Framework \ndebug_data")
    ;

  events = p5.addCheckBox("Events")
                .setPosition(400, 50)
                .setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(0))
                .setSize(40, 40)
                .setItemsPerRow(1)
                .setSpacingColumn(30)
                .addItem("Email", 0)
                .addItem("Phone Call", 0)
                .addItem("Text", 0)
                .addItem("Twitter", 0)
                .addItem("Voice Mail", 0)
                ;
}
 