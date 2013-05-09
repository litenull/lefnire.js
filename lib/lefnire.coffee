# Because obviously lefnire is a class. And he will not be subject to class-naming conventions!
irc = require("irc")
util = require('util')
argv = require('optimist').argv
mersenne = require('mersenne')
moment = require('moment')
request = require('superagent')
github = require('octonode')
_ = require('underscore')

lefnire = ->
  @textPrefix = "lefnire says: "
  @asciiImage = "$$ZZZZZZZZZOZZZZOO8DDND8DDD888$ZO$?OOZ77?7Z$$$$$$$$$$$$ZZZZZ$$ZZZ8==IIII????????\r\n$$$$ZZZZZZZZZZZZ8DDDDDDDDDDOZMO$Z$$$N88OO$7$$$$7$$$$$$$$$$$$$$Z$87:?I???????????\r\n$$$$ZZZZZZOOZZOOO8DDNNNNND8NZODDOO88DNDDO$77ZZOZ77$$$$$$$$$$$$$$O+=IIII?III?????\r\n$$$$ZZZZOZZOOZOO88DDNNNND88888O8OOOODDDN8OZ$Z8D8$$$$$$$$$$$$$$$$7~?II???????????\r\n$$$$ZZZZZZOOOOOZOODNNNNDD8Z$77I?+===?7ZODOZZ8$$8OI7$$$$$$$$$$$$$==II????????????\r\n$$$ZZZZZZZZZOOOO8DNNNDDDOZZ$77I?+====++IDD7IOZI7O?=$$$$$$$$$$$$O=?II??????????II\r\nZZZZZZZZZZZZOOOO8NNNDDD8OOZZ$7I+=~==:~==7ON?~=$7$?~I7$$$$$$$$$7Z=I??????????IIII\r\nO8OZZZZZZZZZZZOOONNDDD88OOOZ$7I++===::::77$D:~IZ7~,I7$$$$$$7$$O7?II???III????III\r\nOZO88OZZZZZZZZZOODDODD88OOOO$7??+==~:::,++?7~?I?I:,I$$$77777I7Z=I?????????????II\r\nOZZ8888OOOOOOOOO8D88D888OOOO$II?++++::,,,:=7Z+=I7=,I$777777II$I~??????+????II???\r\n$$$OOOO8OOOOOOOODDO8D88OO88O$7777$$7=:,,..,+$7??=+,?77IIIIIII7==+???+++++????III\r\n8OZ$OOOOOOOOOOOO8D8DDDD8888O8DDDD88O7+:,,,,+Z$+?+?:=I7III???II=++=++====7$$$$$$Z\r\nOOOO8ZZOOOOOOOOZODNNNNND88OOOOOOZZ$7?+=:,,,~7$I?~?~~II7II77$7I77777777$$OOOZ$777\r\nOOOOOO8OOOOO8O88O8NNDDNND8$+7ZO8D8O7?~,,,,:?O$II$I=~77IIIII7??+++++++?$8+:,=~===\r\nDDD888888888OOOOOO8DNNNNDO+:$88D8M87I7?~,,,:ZOZ$~~++77II???I++==~~~::~$7,:,,,,,,\r\nDNDOOZO8888888888OZDNNNN8$=~?$8D8Z7++=~:,,.,?7+:=~$~?++++=:.,,,,,,....,,..=+I:..\r\n?=+?NDDDZO8888ZOI?Z8DDNNO7=~~~+7$$77?==:,...~~,+I=+~==+=:,...............,+?D$I7\r\n=+?I.+DNZZ8DD88DO$O8DDD8O7=~~=+I7II?==~:....=~,+8?,.,....................,?$88DD\r\nI+~~..:NDDN87Z888OOO8DDDO7+=~=?ZO$7?=~:,,..,?~:=~:.......................,I$ODDN\r\n7II?=:=MD8D8ZZZZDOZODDN8O7+~~~~$88O$=~:,,..:++~:,........................:I$8+ZM\r\nZ$Z$7DMNNNNOZ$Z$I7$8DDND8O?=+I$$$ODDI~::,,,:+~=+=I?++=+=?=,::,,,........,+?+O,=M\r\nNNNMNNNDNNDDNNOZ7$7ZDNNNNND888OZ$ZO887~,~,,=?~:?:::,,,,..,................~ZZ.:M\r\nZOMNDNDN8OZZDM8ODZ$$NNNNDDD8OOZZ7$O88O+:=~:~~:,~.........................:=,:.?N\r\n...~8DDDOZO$DN87$$$7DDNNNDDDZI+=?8D8DO?:?+~=+,...........................:7Z8++I\r\n7??7888DOZ7$8NZ7III$8DNNNNDDOZZZ7??$88?=7II?=.:7I+~==~~?.................~?IZ,~,\r\nMMMMDNMMOZ$$8DO77III8DDDDDD8D8OZ+=?$88I?$II7:.=MMZ~......................:I7$,:,\r\nO8ZDM+.,7OZZ8DOO$7II$NNDDDDD8OZ7++I$8Z77$$7I,.~M8NN8$D=:.................~$$I.:,\r\nO$78I....7OZ8MZZ~OZ7I$DNDDDD88O$I$$ZZZ$$$$I~,.:DZOMD7II:.................=Z$?.,.\r\nZZ=~$?+?,....,8NO:$M=?$NDDDD8O$I7$ZOOOZZ7+~:,,:8$OMN$77Z:.........,......+$7I~:.\r\n$$7$~.,?,....?N8~ODZMD77DDDDD8Z77$ZZZ$$$==~:,~ZM$NMM8ZZODD$:,,,,..~$+:...=?$,=+.\r\n?==7I77~...,.~7~8D8ZIMDMNDDDD8OZ7OOOOZZ$7I?+~:,,.........+MD8ZOMMMNZDNM8$$$7I+=:\r\n:,.:.,:~~:,.+I~=DDZOMNMNNNNNDDDD7OOOOOZZ$7I?=~:,.........7M$ZZI~IZDNDMMMNND8+=+=\r\n:7?I=+?=:,~,IM$88OZDNMNMNNNMNNDD$ZOOOOZZ$77?=~:,........,ZMOZOO$+:,,+=+?II+:,,::\r\n~::.,......,ZD7$8NMNMNNNNNNMNNNDZZ8OOOZZZZI?=~:,........~=++I$Z$?+===+????II,..,\r\n,:,........,ZN8MNNNNNMNDNNMMNNNDOZ8OOOOZ887?=~:,.......:77ZZ$Z7?==~~~~=+++++=:..\r\n...,:,,::,.+MNNNNNNNMMNMDNMMNNND8ZOOOOOONN8I=~:,....,,=IO8ZZZ$?=~~~~=~=+++++=~::\r\n,,,.~:~.:OMDNNNNMMNNNNMMDDNNNNNNDZOOOOO8NDNO=~::,,.,~?$ZD88OO$I=====~I$$?II7=:,,\r\n~:::,...+MNNNNNNMMMNNNNNMMNNNNNNDZ8NNDDDNND8I?7+=+:,IZO7N888OZI???I?I7777777+~,,\r\n........MDNNNNNNMMMNNNNNNMNNNNNNDZO8MNNNDNNNDD8D?,,:I$O$8OOOZZ7I++?+??II7777I+~:\r\n:,.....=NNNMNNNNMMMMNNNNNMNNNNNNDOO88DNNNNNNNN$=,,:=IZZ888OO$Z$$77II+I77$ZZZZ$?+\r\n,,,:,,,$NNNNNNNNMMMMNNNNNNMNNNNNDO88O8NNMNNDO~::,,:=$ZO888O8Z$$$7II???I7ZZZOODI~\r\n,..,:.~NNNNNNNNNNMMMMMNNNNMNNNNNDOOOODNNDDNNM?::,,:~7$Z788OOZ$$$ZZOOOO8OOO88$I?~\r\n:,....7MMNMNNNNNNNMMMMMMNNMMDO8N8O888NDN$7$M8N=,..,,~+I$8OOODDDD88Z$OZOOOOOOI+::\r\n,,,,:?MMNMNNNNNNNNNMMMMMNNMMNNNN8O8ODNOZ$7I?$MI,....,~?7ZZO88888OZZZZZOOOOOO$I=~\r\n==+??8NNNNNMNMNNNNNMMMMMMMNMMNNNOO8OOOOZ$7I?~:=:....,:+$$ODDO88OZZZ$ZZZZOOOO$I?+\r\nI?+~ZMNNMMMNNMMMMMMMMMMMMMMMMMNNOO88OOOZ$7I?=~::......=INNDN8OOOZ$$$ODND888OIII7\r\n~:::IMNMNMMNNMMMMMMMMMMMMMMMNMMNO888OOOZ$7I?=~:,......,~NNNNND888D8888888OO$????\r\n:~=~MNNNNNNNNMMMMMMMMMMMMMMMMMMMND88OOOZ$7I?=::,,......=NNNNNND888OOOOOO8OOZ$7II\r\n?++7NNNNNNNNNNMMNMMMMMMMMMMMMMMMNNNMNDD8OZZ7?++==++?OMMNNNNNNNNNDDDDDDDDD88OOZZ$\r\nI+IMNNNNMMMMNMMMMMMMMMMNMMMMMMMMMNNNNNNNNNNNNNNNDDNDNNNNNNNNNNNNNNNNNNNNNNNNNDD8\r\n?+$MMNNMMMMNNMMMMMMMMMMMMMMMMMMMNNNNNNMNNNNNNDNNDNNNMNNNNNNNNNNNNNNNNNNNNNNNNNNN"
  @defaultIrcServer = 'chat.freenode.org'
  @defaultNick = 'lefnire-js'
  @defaultChannel = '#habitrpg'
  @joinMessage
  @client
  @bounce = (message, endProcess) =>
    @say message || "Whoa, something came up! Gotta bail. Shoot me a G+ invite."
    console.log "Quit message should be: #{message}" if argv.debug
    @client.disconnect message, =>
      process.exit() if endProcess # Message doesn't work. But hopefully it one day will.
    setTimeout(=>
        @client.connect()
      , 10000
    )
  @end

lefnire::say = (text) ->
  console.log @textPrefix + text

lefnire::introduce = ->
  console.log @asciiImage + "\n"

lefnire::tellIrc = (message) ->
  if not _.isArray(message)
    message = [message]

  risingTimeout = 0;
  message.forEach (msg) =>
    setTimeout =>
        @tellIrcOneThing msg
      , risingTimeout
    risingTimeout += 1700
  risingTimeout

lefnire::tellIrcOneThing = (message) ->
  @client.say @defaultChannel, message

lefnire::respond = (message) ->
  setTimeout =>
      @tellIrc message
    , 1000

lefnire::memoryleaks = ->
  "I hate derby so much right now"

lefnire::buildnewfeature = ->
  "Thank god for Derby"

lefnire::someoneSaidRefLists = ->
  goodOrBad = mersenne.rand 31
  if goodOrBad is 15
    @tellIrc "refLists rock! so much functionality for free"
  else
    @tellIrc "ugh...refLists...I need a breather"
    setTimeout =>
        @joinMessage = "phew, now I feel better. what's up guys?"
        @bounce "refLists...why do you hate me so...;("
      , 2000

lefnire::checkHabitStatus = ->
  @say "Someone wants to know if Habit is down. Let's check..."
  request.get('https://habitrpg.com/api/v1/status')
    .type('application/json')
    .set('Accept: gzip, deflate')
    .timeout(10000)
    .end((err, res) =>
      if res and res.ok
        res.text = JSON.parse(res.text)

      if not res
        request.get('https://beta.habitrpg.com/api/v1/status')
          .type('application/json')
          .set('Accept: gzip, deflate')
          .timeout(10000)
          .end((err, res) =>
            if res and res.ok
              res.text = JSON.parse(res.text)

            if res and res.ok and res.text.status is "up"
              @tellIrc "guys, looks like prod might be restarting or something, but beta is working great. use that for now."
            else
              @tellIrc "...man, these memory leaks are killing me...both beta and prod...why...refLists...ugh..."
          )
      else if res and res.ok and res.text.status is "up"
        setTimeout =>
          @tellIrc "don't scare me like that! I thought Habit was down again! (it's not. I just checked)"
        , 2000

      @say "Check complete."
    )

lefnire::whoSaidAsync = ->
  loveHate = mersenne.rand 3
  if loveHate is 1
    @respond "async? that's old...you gotta try Derby, man!"
  else
    @respond "ah, good ol' async...can't wait for the angular rewrite to be done"

lefnire::countGitHubIssues = ->
  @say "Checking GitHub issues..."
  @tellIrc "hold up, let me check the queue..."
  request.get('https://api.github.com/repos/lefnire/habitrpg/issues?state=open&labels=critical')
    .set('User-Agent', 'https://github.com/litenull/lefnire.js (Node.js SuperAgent)')
    .end((res) =>
      @say "Got response."
      console.log "Error? #{util.inspect(res.error)}" if argv.debug and res
      console.log "Response? #{util.inspect(res)}" if argv.debug
      if (res and res.ok)
        console.log "Length of response was #{res.length}" if argv.debug
        if (res.body.length)
          @tellIrc "yeah, argh, still #{res.body.length} criticals :("
        else
          @tellIrc "no criticals...or I'm too tired to notice"
    )

lefnire::trollIrc = ->
  @client = new irc.Client(@defaultIrcServer, @defaultNick, {
    port: 6665,
    channels: [@defaultChannel],
    autoConnect: false,
  })

  client = @client

  bounce = @bounce

  client.addListener('error', (message) ->
    console.log "error listener fired" if argv.debug
    messageDump = util.inspect(message)
    console.log("error: #{messageDump}") if argv.debug
  )

  client.addListener('registered', (message) ->
    messageDump = util.inspect message
    console.log("server said: #{messageDump}") if argv.debug
  )

  client.addListener("message#{@defaultChannel}", (nick, text, message) =>
    console.log "message#{@defaultChannel} listener fired" if argv.debug
    refListPattern = /reflist/i
    if refListPattern.test text
      @someoneSaidRefLists client, bounce
      return
    else if (/.*habit.*down.*/i).test text
      @checkHabitStatus client, bounce
      return
    else if (/async/i).test text
      @whoSaidAsync client, bounce
      return
    else if (/.*any.*issues.*/i).test text
      @countGitHubIssues()
      return
    else if (/backer gear/i).test text
      risingTimeout = @tellIrc ["oh bother...", "ok, i'm gonna heads-down the backer gear", "you punks", "i'm OUT", ":)"]

      # TODO: Functionatize
      console.log "Setting backer gear quit timeout to #{risingTimeout}" if argv.debug
      setTimeout =>
        @joinMessage = "got tired of working on backer gear...argh, refLists..."
        @bounce "going heads-down on backer gear"
      , risingTimeout
      return
    else
      console.log "No messages matched" if argv.debug
  )

  client.addListener('join', (channel, nick, message) =>
    console.log "join listener fired" if argv.debug
    messageDump = util.inspect message
    console.log("#{nick} joined #{channel}. message: #{messageDump}") if argv.debug
    if (nick is @defaultNick and channel is @defaultChannel)
      if not @joinMessage
        mersenne.seed parseInt(moment().format('X'))
        saySomething = mersenne.rand 6

        quoteMap = {
          1: @memoryleaks
          2: @buildnewfeature
        }

        if parseInt(saySomething) is 1 or parseInt(saySomething) is 2
          @tellIrc quoteMap[saySomething]()
      else
        @tellIrc @joinMessage
        @joinMessage = undefined

      setTimeout(=>
          bounce("", true)
        , 3000) unless argv.irc and not argv.troll # Trolling wins.
  )

  console.log "Connecting to IRC..." if argv.debug
  client.connect()

module.exports = lefnire
