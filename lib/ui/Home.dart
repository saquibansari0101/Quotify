import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  List Quotes = [
    "What do I do? System Architecture. Networking and Security. No one in this house can touch me on that. But does anyone appreciate that? While you were busy minoring in gender studies and singing a cappella at Sarah Lawrence, I was getting root access to NSA servers. I was a click away from starting a second Iranian revolution. I prevent cross site scripting, I monitor for DDoS attacks, emergency database rollbacks, and faulty transaction handlings. The internet, heard of it? Transfers half a petabyte of data a minute, do you have any idea how that happens? All of those YouPorn ones and zeros streaming directly to your shitty little smart phone day after day. Every dipshit who shits his pants if he can't get the new dubstep Skrillex remix in under 12 seconds. It's not magic, it's talent and sweat. People like me ensuring your packets get delivered unsniffed. So what do I do? I make sure that one bad config on one key component doesn't bankrupt the entire fucking company. That's what the fuck I do. …",
    "People like to lie, Richard. It’s a war of all against all. The history of humanity is a book written in blood. We’re all just animals in a pit.",
    "Makes me feel like I’ve died and gone to hell.",
    "I’m sure you can find your way out with one of your two faces.",
    "I’m effectively leveraging your misery. I’m like the Warren Buffet of f*cking with you.",
    "I find parades to be impotent displays of authoritarianism.",
    "Why do people covet the silly pieces of green cotton paper in their wallets? It’s because we are all sheep. And we’ve mutually agreed to endow certain things we value.",
    "There are very few things that I will defend with true passion: medical marijuana, the biblical Satan as a metaphor for rebellion against tyranny, and mother***** Goddamn cryptocurrency.",
    "If the rise of an all-powerful artificial intelligence is inevitable, well it stands to reason that when they take power, our digital overlords will punish those of us who did not help them get there. Ergo, I would like to be a helpful idiot. Like yourself.",
    "Since your failure as a leader is a virtual certainty, tolerating your short reign as CEO in exchange for a front-row seat to the disaster seems fair. Plus, if I’m wrong, which I’m not, I get rich. So I’m down with it, Dinesh."
    "I’m sure you can find your way out with one of your two faces.",
    "Does it mean taking a stack of cash and lighting it on fire?",
    "I wrote that code. You said you were in love with her mind. You realize what's going on right? It's not her you're sexually attracted to. It's my code... Just face it, Dinesh, you're gay for my code. You're code gay.",
    "At least it didn’t happen in a public and brutally embarrassing way.",
    "If you're the CEO of a company, and you're dumb enough to leave your log-in info on a Post-It note on your desk, while the people that you ripped off are physically in your office, it's not a hack. It's barely social engineering. It’s more like natural selection.",
    "It's hard to believe your pathological inability to make a decision finally paid off.",
    "Either she froze time, met and married the man of her dreams, unfroze time, and hopped back on to vid chat with you, or... you're the dogface. Which do you think it is? I'm on the fence.",
    "I think we should dig our own well and build our own generator. I also think we should store years worth of food and ammunition in a blast cellar. But we don’t. So good luck when the sh*t hits the fan."
  ];

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xfff8ede3),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffbdd2b6)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                            "“"+Quotes[_index % Quotes.length]+"”",
                            style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  letterSpacing: 0.3),
                          ),
                              )),
                        ))),
                TextButton(
                    onPressed: _showQuotes,
                    child: Container(
                      color: Color(0xffa2b29f),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Get Quote",
                          style: TextStyle(
                            color: Color(0xfff8ede3),
                          fontSize: 20,
                          fontFamily: 'Raleway'),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showQuotes() {
    //increment our index by 1
    setState(() {
      _index++;
    });
  }
}
