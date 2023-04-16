abstract class Helper{
  String getHelpText();
}

class RunserverHelp implements Helper{
  @override
  String getHelpText(){
    String helpText = '''
Runserver               Runs http server on given hostname and port under option keyword arguments host and port.
                        In case run without optional keyword arguments, default values of host and port are asusmed.
                        Default value - host "localhost" and port 8000
                        Usage
                            runserver
                            Runs with default hostname and port

                            runserver host:"localhost"                            
                            Runs with supplied hostname and default port

                            runserver port:8000                            
                            Runs with supplied port and default hostname

                            runserver host:"localhost" port:8000
                            Runs with supplied hostname and port
''';
    return helpText;
  }
}

class MakemigrationsHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class MigrateHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class CreateuserHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class CreatesuperuserHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class CollectstaticHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class StartappHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class VersionHelp implements Helper{
  @override
  String getHelpText(){
    String helpText ='''''';
    //TODO complete implementation
    return helpText;
  }
}

class HelpHelp implements Helper{
  @override
  String getHelpText(){
    String helpText = '''
Help                    Shows help menu with all Commands possible and options to run those commands.
                        Can be optionally be run with an argument which takes in the command on which help is required.
                        Commands on which help is available ["runserver","makemigrations","migrate","startapp","createuser","createsuperuser","collectstatic","version","help"]
                        Usage
                            help
                            Shows help menu with all commands and options

                            help runserver
                            Shows help menu for only runserver command
''';
    return helpText;
  }
}

class AllHelp implements Helper{
  @override
  String getHelpText(){
    List<Helper> helpers = [
      RunserverHelp(),
      MakemigrationsHelp(),
      MigrateHelp(),
      CreateuserHelp(),
      CreatesuperuserHelp(),
      CollectstaticHelp(),
      StartappHelp(),
      VersionHelp(),
      HelpHelp(),
    ];
    String helpText = '''''';
    for(var helper in helpers){
      helpText = "$helpText\n${helper.getHelpText()}";
    }
    return helpText;
  }
}

String getHelpText([String? command]){
    Helper helper = HelpHelp();
    switch (command) {
      case "runserver":
        helper = RunserverHelp();
        break;
      case "makemigrations":
        helper = MakemigrationsHelp();
        break;
      case "migrate":
        helper = MigrateHelp();
        break;
      case "createuser":
        helper = CreateuserHelp();
        break;
      case "createsuperuser":
        helper = CreatesuperuserHelp();
        break;
      case "collectstatic":
        helper = CollectstaticHelp();
        break;
      case "startapp":
        helper = StartappHelp();
        break;
      case "version":
        helper = VersionHelp();
        break;
      case "help":
        helper = HelpHelp();
        break;
      default:
        helper = AllHelp();
    }
    return helper.getHelpText();
}