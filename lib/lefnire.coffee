# Because obviously lefnire is a class. And he will not be subject to class-naming conventions!
irc = require("irc")
util = require('util')
argv = require('optimist').argv
mersenne = require('mersenne')
moment = require('moment')
request = require('superagent')
GitHubApi = require('github')
_ = require('underscore')
understand = require('sentimental')
# understand = require('speakeasy-nlp')

argv.debug = true if argv.dump # --dump implies --debug

lefnire = ->
  @textPrefix = "lefnire says: "
  @asciiImage = "$$ZZZZZZZZZOZZZZOO8DDND8DDD888$ZO$?OOZ77?7Z$$$$$$$$$$$$ZZZZZ$$ZZZ8==IIII????????\r\n$$$$ZZZZZZZZZZZZ8DDDDDDDDDDOZMO$Z$$$N88OO$7$$$$7$$$$$$$$$$$$$$Z$87:?I???????????\r\n$$$$ZZZZZZOOZZOOO8DDNNNNND8NZODDOO88DNDDO$77ZZOZ77$$$$$$$$$$$$$$O+=IIII?III?????\r\n$$$$ZZZZOZZOOZOO88DDNNNND88888O8OOOODDDN8OZ$Z8D8$$$$$$$$$$$$$$$$7~?II???????????\r\n$$$$ZZZZZZOOOOOZOODNNNNDD8Z$77I?+===?7ZODOZZ8$$8OI7$$$$$$$$$$$$$==II????????????\r\n$$$ZZZZZZZZZOOOO8DNNNDDDOZZ$77I?+====++IDD7IOZI7O?=$$$$$$$$$$$$O=?II??????????II\r\nZZZZZZZZZZZZOOOO8NNNDDD8OOZZ$7I+=~==:~==7ON?~=$7$?~I7$$$$$$$$$7Z=I??????????IIII\r\nO8OZZZZZZZZZZZOOONNDDD88OOOZ$7I++===::::77$D:~IZ7~,I7$$$$$$7$$O7?II???III????III\r\nOZO88OZZZZZZZZZOODDODD88OOOO$7??+==~:::,++?7~?I?I:,I$$$77777I7Z=I?????????????II\r\nOZZ8888OOOOOOOOO8D88D888OOOO$II?++++::,,,:=7Z+=I7=,I$777777II$I~??????+????II???\r\n$$$OOOO8OOOOOOOODDO8D88OO88O$7777$$7=:,,..,+$7??=+,?77IIIIIII7==+???+++++????III\r\n8OZ$OOOOOOOOOOOO8D8DDDD8888O8DDDD88O7+:,,,,+Z$+?+?:=I7III???II=++=++====7$$$$$$Z\r\nOOOO8ZZOOOOOOOOZODNNNNND88OOOOOOZZ$7?+=:,,,~7$I?~?~~II7II77$7I77777777$$OOOZ$777\r\nOOOOOO8OOOOO8O88O8NNDDNND8$+7ZO8D8O7?~,,,,:?O$II$I=~77IIIII7??+++++++?$8+:,=~===\r\nDDD888888888OOOOOO8DNNNNDO+:$88D8M87I7?~,,,:ZOZ$~~++77II???I++==~~~::~$7,:,,,,,,\r\nDNDOOZO8888888888OZDNNNN8$=~?$8D8Z7++=~:,,.,?7+:=~$~?++++=:.,,,,,,....,,..=+I:..\r\n?=+?NDDDZO8888ZOI?Z8DDNNO7=~~~+7$$77?==:,...~~,+I=+~==+=:,...............,+?D$I7\r\n=+?I.+DNZZ8DD88DO$O8DDD8O7=~~=+I7II?==~:....=~,+8?,.,....................,?$88DD\r\nI+~~..:NDDN87Z888OOO8DDDO7+=~=?ZO$7?=~:,,..,?~:=~:.......................,I$ODDN\r\n7II?=:=MD8D8ZZZZDOZODDN8O7+~~~~$88O$=~:,,..:++~:,........................:I$8+ZM\r\nZ$Z$7DMNNNNOZ$Z$I7$8DDND8O?=+I$$$ODDI~::,,,:+~=+=I?++=+=?=,::,,,........,+?+O,=M\r\nNNNMNNNDNNDDNNOZ7$7ZDNNNNND888OZ$ZO887~,~,,=?~:?:::,,,,..,................~ZZ.:M\r\nZOMNDNDN8OZZDM8ODZ$$NNNNDDD8OOZZ7$O88O+:=~:~~:,~.........................:=,:.?N\r\n...~8DDDOZO$DN87$$$7DDNNNDDDZI+=?8D8DO?:?+~=+,...........................:7Z8++I\r\n7??7888DOZ7$8NZ7III$8DNNNNDDOZZZ7??$88?=7II?=.:7I+~==~~?.................~?IZ,~,\r\nMMMMDNMMOZ$$8DO77III8DDDDDD8D8OZ+=?$88I?$II7:.=MMZ~......................:I7$,:,\r\nO8ZDM+.,7OZZ8DOO$7II$NNDDDDD8OZ7++I$8Z77$$7I,.~M8NN8$D=:.................~$$I.:,\r\nO$78I....7OZ8MZZ~OZ7I$DNDDDD88O$I$$ZZZ$$$$I~,.:DZOMD7II:.................=Z$?.,.\r\nZZ=~$?+?,....,8NO:$M=?$NDDDD8O$I7$ZOOOZZ7+~:,,:8$OMN$77Z:.........,......+$7I~:.\r\n$$7$~.,?,....?N8~ODZMD77DDDDD8Z77$ZZZ$$$==~:,~ZM$NMM8ZZODD$:,,,,..~$+:...=?$,=+.\r\n?==7I77~...,.~7~8D8ZIMDMNDDDD8OZ7OOOOZZ$7I?+~:,,.........+MD8ZOMMMNZDNM8$$$7I+=:\r\n:,.:.,:~~:,.+I~=DDZOMNMNNNNNDDDD7OOOOOZZ$7I?=~:,.........7M$ZZI~IZDNDMMMNND8+=+=\r\n:7?I=+?=:,~,IM$88OZDNMNMNNNMNNDD$ZOOOOZZ$77?=~:,........,ZMOZOO$+:,,+=+?II+:,,::\r\n~::.,......,ZD7$8NMNMNNNNNNMNNNDZZ8OOOZZZZI?=~:,........~=++I$Z$?+===+????II,..,\r\n,:,........,ZN8MNNNNNMNDNNMMNNNDOZ8OOOOZ887?=~:,.......:77ZZ$Z7?==~~~~=+++++=:..\r\n...,:,,::,.+MNNNNNNNMMNMDNMMNNND8ZOOOOOONN8I=~:,....,,=IO8ZZZ$?=~~~~=~=+++++=~::\r\n,,,.~:~.:OMDNNNNMMNNNNMMDDNNNNNNDZOOOOO8NDNO=~::,,.,~?$ZD88OO$I=====~I$$?II7=:,,\r\n~:::,...+MNNNNNNMMMNNNNNMMNNNNNNDZ8NNDDDNND8I?7+=+:,IZO7N888OZI???I?I7777777+~,,\r\n........MDNNNNNNMMMNNNNNNMNNNNNNDZO8MNNNDNNNDD8D?,,:I$O$8OOOZZ7I++?+??II7777I+~:\r\n:,.....=NNNMNNNNMMMMNNNNNMNNNNNNDOO88DNNNNNNNN$=,,:=IZZ888OO$Z$$77II+I77$ZZZZ$?+\r\n,,,:,,,$NNNNNNNNMMMMNNNNNNMNNNNNDO88O8NNMNNDO~::,,:=$ZO888O8Z$$$7II???I7ZZZOODI~\r\n,..,:.~NNNNNNNNNNMMMMMNNNNMNNNNNDOOOODNNDDNNM?::,,:~7$Z788OOZ$$$ZZOOOO8OOO88$I?~\r\n:,....7MMNMNNNNNNNMMMMMMNNMMDO8N8O888NDN$7$M8N=,..,,~+I$8OOODDDD88Z$OZOOOOOOI+::\r\n,,,,:?MMNMNNNNNNNNNMMMMMNNMMNNNN8O8ODNOZ$7I?$MI,....,~?7ZZO88888OZZZZZOOOOOO$I=~\r\n==+??8NNNNNMNMNNNNNMMMMMMMNMMNNNOO8OOOOZ$7I?~:=:....,:+$$ODDO88OZZZ$ZZZZOOOO$I?+\r\nI?+~ZMNNMMMNNMMMMMMMMMMMMMMMMMNNOO88OOOZ$7I?=~::......=INNDN8OOOZ$$$ODND888OIII7\r\n~:::IMNMNMMNNMMMMMMMMMMMMMMMNMMNO888OOOZ$7I?=~:,......,~NNNNND888D8888888OO$????\r\n:~=~MNNNNNNNNMMMMMMMMMMMMMMMMMMMND88OOOZ$7I?=::,,......=NNNNNND888OOOOOO8OOZ$7II\r\n?++7NNNNNNNNNNMMNMMMMMMMMMMMMMMMNNNMNDD8OZZ7?++==++?OMMNNNNNNNNNDDDDDDDDD88OOZZ$\r\nI+IMNNNNMMMMNMMMMMMMMMMNMMMMMMMMMNNNNNNNNNNNNNNNDDNDNNNNNNNNNNNNNNNNNNNNNNNNNDD8\r\n?+$MMNNMMMMNNMMMMMMMMMMMMMMMMMMMNNNNNNMNNNNNNDNNDNNNMNNNNNNNNNNNNNNNNNNNNNNNNNNN"
  @defaultIrcServer = 'chat.freenode.org'
  @defaultNick = 'lefnire-js'
  @politenessNick = 'tyler-js'
  @impersonatorNick = 'lefnire'
  @myNick = @defaultNick
  # Allow specifying moodNick on the command line for testing purposes
  @moodNick = if argv.moodNick then argv.moodNick else 'lefnire'
  @githubMoodNick = 'lefnire'
  @moodFactors = {
    github: 0
    githubEvents: 0
    sentiment: 0
    refLists: 0
    habitStatus: 0
  }
  @speechScoreNormalizer = 0.25
  @github = new GitHubApi {
    version: "3.0.0"
  }
  @defaultChannel = if argv.channel then argv.channel else '#habitrpg'
  @joinMessage
  @client
  @bounce = (message, endProcess) =>
    @say (message || "Whoa, something came up! Gotta bail. Shoot me a G+ invite.") unless @seriousTrolling
    console.log "Quit message should be: #{message}" if argv.debug
    @client.disconnect message, =>
      if @seriousTrolling
        @say "Oh, there we go!"
      process.exit() if endProcess # Message doesn't work. But hopefully it one day will.
    setTimeout(=>
        @client.connect()
      , 10000
    )
  @getCriticalCount = (callback) =>
    @github.issues.repoIssues({
      user: "lefnire"
      repo: "habitrpg"
      state: "open"
      labels: "critical"
      per_page: 100
    }, (err, res) =>
      @say "Got response."
      console.log "Error? #{util.inspect(err)}" if argv.dump and err
      console.log "Response? #{util.inspect(res)}" if argv.dump
      if (!err)
        count = res.length
        callback(count)
    )
  @getGitHubEvents = (callback) =>
    @github.events.getFromUser({
      user: @githubMoodNick
      per_page: 100
    }, callback) # (err, res)
  @currentMood = 0
  @adjustMoodFromCrits()
  @adjustMoodFromActivity()

  @say "My mood is based on what #{@moodNick} says." if argv.debug
  @end

lefnire::say = (text) ->
  console.log @textPrefix + text

lefnire::introduce = ->
  console.log @asciiImage + "\n"

lefnire::maybe = (chance) ->
  chance = parseInt chance
  mersenne.seed parseInt(moment().format('X'))
  randomness = mersenne.rand chance + 1
  if randomness is chance
    return true
  false

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

lefnire::maybeRespond = (message, chance) ->
  chance = parseInt chance || 4
  console.log "1 in #{chance} chance of actually saying \"#{message}\"" if argv.debug
  if @maybe chance
    @respond message
  else
    @say "#{message}? I ain't saying that."

lefnire::memoryleaks = ->
  "I hate derby so much right now"

lefnire::buildnewfeature = ->
  "Thank god for Derby"

lefnire::someoneSaidRefLists = ->
  if @maybe (@currentMood / 4)
    @tellIrc "refLists rock! so much functionality for free"
    @moodFactors.refLists -= 0.1
    @updateMood()
  else
    @tellIrc "ugh...refLists...I need a breather"
    setTimeout((=>
      @joinMessage = "phew, now I feel better. what's up guys?"
      @moodFactors.refLists -= 0.5
      @updateMood()
      @bounce "refLists...why do you hate me so...;("
    ), 2000)

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
              @tellIrc "yeah, I can't get to it either. beta's working though. try that?"
              @moodFactors.habitStatus += 0.5
              @updateMood()
            else
              @tellIrc "...man, these memory leaks are killing me...both beta and prod...ugh..."
              @moodFactors.habitStatus += 1
              @updateMood()
          )
      else if res and res.ok and res.text.status is "up"
        setTimeout =>
          @tellIrc "works for me"
        , 2000

      @say "Check complete."
    )

lefnire::whoSaidAsync = ->
  if @maybe 2
    @maybeRespond "async? that's old...you gotta try Derby, man!", 2
  else
    @maybeRespond "ah, good ol' async...can't wait for the angular rewrite to be done", 2

lefnire::updateMood = ->
  # Reset mood
  @currentMood = 0
  # Put all the mood factors together
  theKeys = Object.keys(@moodFactors)
  theKeys.forEach((value, key) =>
    # Ignore if undefined. Probably an Object.keys artifact
    if value isnt undefined
      console.log "updateMood values are #{value}, #{@moodFactors[value]}" if argv.debug
      @currentMood += @moodFactors[value]
  )

  @currentMood = 0 if @currentMood < 0
  @currentMood = 30 if @currentMood > 30

lefnire::adjustMoodFromCrits = ->
  @getCriticalCount (count) =>
    @moodFactors.github = count
    @updateMood()

lefnire::adjustMoodFromActivity = ->
  @moodFactors.githubEvents = 0 # Reset

  # Get up to 100 events (probably 30, GitHub hard limit?) and analyze
  @getGitHubEvents((err, resArray) =>
    if (!err)
      resArray.forEach((res, resNumber) =>
        text = undefined
        switch res.type
          when "CommitCommentEvent", "IssueCommentEvent", "PullRequestReviewCommentEvent"
            text = res.payload.comment.body
          when "IssuesEvent"
            if res.payload.action is "opened"
              text = res.payload.issue.body
          when "PullRequestEvent"
            if res.payload.pull_request.action is "opened"
              text = res.payload.pull_request.body
          when "PushEvent" # This one is extra fun
            commitText = []
            res.payload.commits.forEach((commit, commitNumber) =>
              commitText[commitText.length] = commit.message
            )
            text = commitText.join ", "
          else text = undefined

        if text
          score = understand.analyze text
          scoreDump = util.inspect(score)
          console.log "Scored text from GitHub #{res.type}, \"#{text}\", as follows: #{scoreDump}" if argv.debug
          @moodFactors.githubEvents -= (score.score * @speechScoreNormalizer)
        else
          console.log "We don't process #{res.type}, so we skipped it." if argv.debug
      )
      console.log "Final GitHub Events adjustment: #{@moodFactors.githubEvents}" if argv.debug
      @updateMood()
  )

lefnire::countGitHubIssues = ->
  @say "Checking GitHub issues..."
  @tellIrc "hold up, let me check the queue..."
  @getCriticalCount (count) =>
    if (count)
      @tellIrc "yeah, argh, still #{count} criticals :("
    else
      @tellIrc "no criticals...or I'm too tired to notice"

# Like @tellIrc, but delayed a little
lefnire::ohYeahBackerGear = ->
  @respond "backer gear is almost done :)"

lefnire::mrConceptThinksIAm = (nick) ->
  @say "Did you see that!? #{nick} doesn't think I'm real!"
  @tellIrc "A testimonial from MrConcept: \"I just can't distinguish real from fake anymore\"; you be the judge"

lefnire::mage = ->
  if @currentMood >= 20
    @respond "dude, you know the right way to pronounce \"mage\" right? https://soundcloud.com/user87743033/lefnire-js-mez"
  else
    @respond "have you heard The Habit Way™ to say \"mage\" ? https://soundcloud.com/user87743033/lefnire-js-mez :D"

lefnire::selfRename = (newNick) ->
  @client.send('NICK', newNick)

lefnire::disambiguate = ->
  @selfRename @politenessNick

lefnire::ambiguate = ->
  @selfRename @defaultNick

lefnire::trollIrc = ->
  @client = new irc.Client(@defaultIrcServer, @defaultNick, {
    port: 6665,
    channels: [@defaultChannel],
    autoConnect: false,
  })

  @client.addListener('error', (message) =>
    console.log "error listener fired" if argv.debug
    messageDump = util.inspect(message)
    console.log("error: #{messageDump}") if argv.debug
  )

  @client.addListener('registered', (message) =>
    messageDump = util.inspect message
    console.log("server said: #{messageDump}") if argv.debug
    @myNick = message.args[0]
    @say "My nickname on IRC is #{@myNick}" if argv.debug
  )

  @client.addListener("names#{@defaultChannel}", (nicks) =>
    nicksArray = for own nick, nickType of nicks
      if nick is @impersonatorNick
        @disambiguate()
  )

  @client.addListener("message#{@defaultChannel}", (nick, text, message) =>
    console.log "message#{@defaultChannel} listener fired" if argv.debug
    # Special triggers don't affect mood because they return early
    refListPattern = /reflist/i
    if refListPattern.test text
      @someoneSaidRefLists()
      return
    else if (/how you feeling/i).test text
      @respond "I'd say about a #{@currentMood}"
      return
    else if (/.*habit.*down.*/i).test text
      @checkHabitStatus()
      return
    else if (/async/i).test text
      @whoSaidAsync()
      return
    else if (/.*any.*issues.*/i).test text
      @countGitHubIssues()
      return
    else if (/backer gear/i).test text
      @ohYeahBackerGear()
      return
    else if (/(are you real|so real(|istic))/i).test text
      @mrConceptThinksIAm nick
      return
    else if (/mage/i).test text
      @mage()
      return
    else
      console.log "No messages matched" if argv.debug

    console.log "moodNick is: #{@moodNick}" if argv.debug
    if (nick is @moodNick)
      messageScore = understand.analyze text
      messageScoreDump = util.inspect messageScore
      @say "#{@moodNick} said \"#{text}\", and I scored it like this: #{messageScoreDump}"
      # We do the opposite of sentiment's score because 0 is the best mood, 30 the worst
      @moodFactors.sentiment -= (messageScore.score * @speechScoreNormalizer)
      @updateMood()
  )

  @client.addListener('nick', (oldnick, newnick) =>
    if oldnick is @impersonatorNick # We're in the clear!
      @ambiguate()
    if newnick is @impersonatorNick
      @disambiguate()
    if oldnick is @myNick
      @myNick = newnick
  )

  @client.addListener('join', (channel, nick, message) =>
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
          @bounce("", true)
        , 3000) unless argv.irc and not argv.troll # Trolling wins.
    if (nick is @impersonatorNick) # if he joined
      @disambiguate()
  )

  @client.addListener("part#{@defaultChannel}", (nick, reason, message) =>
    if nick is @impersonatorNick
      @ambiguate()
  )

  @client.addListener("quit", (nick, reason, channels, message) =>
    if nick is @impersonatorNick
      @ambiguate()
  )

  console.log "Connecting to IRC..." if argv.debug
  @client.connect()

module.exports = lefnire
