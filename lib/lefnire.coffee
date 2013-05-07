# Because obviously lefnire is a class. And he will not be subject to class-naming conventions!
irc = require("irc")
util = require('util')
argv = require('optimist')

lefnire = ->
  @textPrefix = "lefnire says: "
  @asciiImage = "$$ZZZZZZZZZOZZZZOO8DDND8DDD888$ZO$?OOZ77?7Z$$$$$$$$$$$$ZZZZZ$$ZZZ8==IIII????????\r\n$$$$ZZZZZZZZZZZZ8DDDDDDDDDDOZMO$Z$$$N88OO$7$$$$7$$$$$$$$$$$$$$Z$87:?I???????????\r\n$$$$ZZZZZZOOZZOOO8DDNNNNND8NZODDOO88DNDDO$77ZZOZ77$$$$$$$$$$$$$$O+=IIII?III?????\r\n$$$$ZZZZOZZOOZOO88DDNNNND88888O8OOOODDDN8OZ$Z8D8$$$$$$$$$$$$$$$$7~?II???????????\r\n$$$$ZZZZZZOOOOOZOODNNNNDD8Z$77I?+===?7ZODOZZ8$$8OI7$$$$$$$$$$$$$==II????????????\r\n$$$ZZZZZZZZZOOOO8DNNNDDDOZZ$77I?+====++IDD7IOZI7O?=$$$$$$$$$$$$O=?II??????????II\r\nZZZZZZZZZZZZOOOO8NNNDDD8OOZZ$7I+=~==:~==7ON?~=$7$?~I7$$$$$$$$$7Z=I??????????IIII\r\nO8OZZZZZZZZZZZOOONNDDD88OOOZ$7I++===::::77$D:~IZ7~,I7$$$$$$7$$O7?II???III????III\r\nOZO88OZZZZZZZZZOODDODD88OOOO$7??+==~:::,++?7~?I?I:,I$$$77777I7Z=I?????????????II\r\nOZZ8888OOOOOOOOO8D88D888OOOO$II?++++::,,,:=7Z+=I7=,I$777777II$I~??????+????II???\r\n$$$OOOO8OOOOOOOODDO8D88OO88O$7777$$7=:,,..,+$7??=+,?77IIIIIII7==+???+++++????III\r\n8OZ$OOOOOOOOOOOO8D8DDDD8888O8DDDD88O7+:,,,,+Z$+?+?:=I7III???II=++=++====7$$$$$$Z\r\nOOOO8ZZOOOOOOOOZODNNNNND88OOOOOOZZ$7?+=:,,,~7$I?~?~~II7II77$7I77777777$$OOOZ$777\r\nOOOOOO8OOOOO8O88O8NNDDNND8$+7ZO8D8O7?~,,,,:?O$II$I=~77IIIII7??+++++++?$8+:,=~===\r\nDDD888888888OOOOOO8DNNNNDO+:$88D8M87I7?~,,,:ZOZ$~~++77II???I++==~~~::~$7,:,,,,,,\r\nDNDOOZO8888888888OZDNNNN8$=~?$8D8Z7++=~:,,.,?7+:=~$~?++++=:.,,,,,,....,,..=+I:..\r\n?=+?NDDDZO8888ZOI?Z8DDNNO7=~~~+7$$77?==:,...~~,+I=+~==+=:,...............,+?D$I7\r\n=+?I.+DNZZ8DD88DO$O8DDD8O7=~~=+I7II?==~:....=~,+8?,.,....................,?$88DD\r\nI+~~..:NDDN87Z888OOO8DDDO7+=~=?ZO$7?=~:,,..,?~:=~:.......................,I$ODDN\r\n7II?=:=MD8D8ZZZZDOZODDN8O7+~~~~$88O$=~:,,..:++~:,........................:I$8+ZM\r\nZ$Z$7DMNNNNOZ$Z$I7$8DDND8O?=+I$$$ODDI~::,,,:+~=+=I?++=+=?=,::,,,........,+?+O,=M\r\nNNNMNNNDNNDDNNOZ7$7ZDNNNNND888OZ$ZO887~,~,,=?~:?:::,,,,..,................~ZZ.:M\r\nZOMNDNDN8OZZDM8ODZ$$NNNNDDD8OOZZ7$O88O+:=~:~~:,~.........................:=,:.?N\r\n...~8DDDOZO$DN87$$$7DDNNNDDDZI+=?8D8DO?:?+~=+,...........................:7Z8++I\r\n7??7888DOZ7$8NZ7III$8DNNNNDDOZZZ7??$88?=7II?=.:7I+~==~~?.................~?IZ,~,\r\nMMMMDNMMOZ$$8DO77III8DDDDDD8D8OZ+=?$88I?$II7:.=MMZ~......................:I7$,:,\r\nO8ZDM+.,7OZZ8DOO$7II$NNDDDDD8OZ7++I$8Z77$$7I,.~M8NN8$D=:.................~$$I.:,\r\nO$78I....7OZ8MZZ~OZ7I$DNDDDD88O$I$$ZZZ$$$$I~,.:DZOMD7II:.................=Z$?.,.\r\nZZ=~$?+?,....,8NO:$M=?$NDDDD8O$I7$ZOOOZZ7+~:,,:8$OMN$77Z:.........,......+$7I~:.\r\n$$7$~.,?,....?N8~ODZMD77DDDDD8Z77$ZZZ$$$==~:,~ZM$NMM8ZZODD$:,,,,..~$+:...=?$,=+.\r\n?==7I77~...,.~7~8D8ZIMDMNDDDD8OZ7OOOOZZ$7I?+~:,,.........+MD8ZOMMMNZDNM8$$$7I+=:\r\n:,.:.,:~~:,.+I~=DDZOMNMNNNNNDDDD7OOOOOZZ$7I?=~:,.........7M$ZZI~IZDNDMMMNND8+=+=\r\n:7?I=+?=:,~,IM$88OZDNMNMNNNMNNDD$ZOOOOZZ$77?=~:,........,ZMOZOO$+:,,+=+?II+:,,::\r\n~::.,......,ZD7$8NMNMNNNNNNMNNNDZZ8OOOZZZZI?=~:,........~=++I$Z$?+===+????II,..,\r\n,:,........,ZN8MNNNNNMNDNNMMNNNDOZ8OOOOZ887?=~:,.......:77ZZ$Z7?==~~~~=+++++=:..\r\n...,:,,::,.+MNNNNNNNMMNMDNMMNNND8ZOOOOOONN8I=~:,....,,=IO8ZZZ$?=~~~~=~=+++++=~::\r\n,,,.~:~.:OMDNNNNMMNNNNMMDDNNNNNNDZOOOOO8NDNO=~::,,.,~?$ZD88OO$I=====~I$$?II7=:,,\r\n~:::,...+MNNNNNNMMMNNNNNMMNNNNNNDZ8NNDDDNND8I?7+=+:,IZO7N888OZI???I?I7777777+~,,\r\n........MDNNNNNNMMMNNNNNNMNNNNNNDZO8MNNNDNNNDD8D?,,:I$O$8OOOZZ7I++?+??II7777I+~:\r\n:,.....=NNNMNNNNMMMMNNNNNMNNNNNNDOO88DNNNNNNNN$=,,:=IZZ888OO$Z$$77II+I77$ZZZZ$?+\r\n,,,:,,,$NNNNNNNNMMMMNNNNNNMNNNNNDO88O8NNMNNDO~::,,:=$ZO888O8Z$$$7II???I7ZZZOODI~\r\n,..,:.~NNNNNNNNNNMMMMMNNNNMNNNNNDOOOODNNDDNNM?::,,:~7$Z788OOZ$$$ZZOOOO8OOO88$I?~\r\n:,....7MMNMNNNNNNNMMMMMMNNMMDO8N8O888NDN$7$M8N=,..,,~+I$8OOODDDD88Z$OZOOOOOOI+::\r\n,,,,:?MMNMNNNNNNNNNMMMMMNNMMNNNN8O8ODNOZ$7I?$MI,....,~?7ZZO88888OZZZZZOOOOOO$I=~\r\n==+??8NNNNNMNMNNNNNMMMMMMMNMMNNNOO8OOOOZ$7I?~:=:....,:+$$ODDO88OZZZ$ZZZZOOOO$I?+\r\nI?+~ZMNNMMMNNMMMMMMMMMMMMMMMMMNNOO88OOOZ$7I?=~::......=INNDN8OOOZ$$$ODND888OIII7\r\n~:::IMNMNMMNNMMMMMMMMMMMMMMMNMMNO888OOOZ$7I?=~:,......,~NNNNND888D8888888OO$????\r\n:~=~MNNNNNNNNMMMMMMMMMMMMMMMMMMMND88OOOZ$7I?=::,,......=NNNNNND888OOOOOO8OOZ$7II\r\n?++7NNNNNNNNNNMMNMMMMMMMMMMMMMMMNNNMNDD8OZZ7?++==++?OMMNNNNNNNNNDDDDDDDDD88OOZZ$\r\nI+IMNNNNMMMMNMMMMMMMMMMNMMMMMMMMMNNNNNNNNNNNNNNNDDNDNNNNNNNNNNNNNNNNNNNNNNNNNDD8\r\n?+$MMNNMMMMNNMMMMMMMMMMMMMMMMMMMNNNNNNMNNNNNNDNNDNNNMNNNNNNNNNNNNNNNNNNNNNNNNNNN"
  @defaultIrcServer = 'chat.freenode.org'
  @defaultNick = 'lefnire-js'
  @defaultChannel = '#habitrpg'

lefnire::say = (text) ->
  console.log @textPrefix + text

lefnire::introduce = ->
  console.log @asciiImage + "\n"

lefnire::memoryleaks = ->
  console.log "I hate derby so much right now"

lefnire::buildnewfeature = ->
  console.log "Thank god for Derby"

module.exports = lefnire

lefnire::trollIrc = ->
  client = new irc.Client(@defaultIrcServer, @defaultNick, {
    port: 6665,
    channels: [@defaultChannel]
  })

  client.addListener('error', (message) ->
    console.log("error: #{message}") if argv.debug
  )

  client.addListener('registered', (message) ->
    messageDump = util.inspect message
    console.log("server said: #{messageDump}") if argv.debug
  )

  client.addListener('join', (channel, nick, message) =>
    messageDump = util.inspect message
    console.log("#{nick} joined #{channel}. message: #{messageDump}") if argv.debug
    if (nick is @defaultNick and channel is @defaultChannel)
      disconnect = =>
        @say "Whoa, something came up! Gotta bail. Shoot me a G+ invite."
        client.disconnect()
        process.exit()

      setTimeout(disconnect, 3000)
    else
      @say "...my channel-exiting code isn't working!"
  )

  client.connect()

module.exports = lefnire
