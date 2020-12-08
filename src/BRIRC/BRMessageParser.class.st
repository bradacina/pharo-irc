Class {
	#name : #BRMessageParser,
	#superclass : #Object,
	#instVars : [
		'parseDispatch'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #'as yet unclassified' }
BRMessageParser >> genericChannelMessage: tokens ofType: type [

	^ BRChannelMessage new
		  messageType: type;
		  channel: tokens second;
		  message: (' ' join: (tokens allButFirst: 2));
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> genericServerMessage: tokens ofType:  type [

	^ BRServerMessage  new
		  messageType: type;
		  message: (' ' join: tokens);
		  yourself
]

{ #category : #initialization }
BRMessageParser >> initialize [

	parseDispatch := Dictionary newFromPairs:
		                 { 'JOIN'. #join:. 'PART'. #part:. 'PRIVMSG'.
		                 #privMsg:. 'MODE'. #mode:. 'QUIT'. #quit:. 'NICK'.
		                 #nick:. 'KICK'. #kick:. 'NOTICE'. #notice:. '332'.
		                 #listTopic:. '353'. #listChannelUsers:.
		                 'TOPIC'. #topic:. '333'. #genericChanelMessage:ofType:.
		                 '366'. #genericChannelMessage:ofType:.
		                 'PING'. #genericServerMessage:ofType:.
		                 '001'. #genericServerMessage:ofType:.
		                 '002'. #genericServerMessage:ofType:.
		                 '003'. #genericServerMessage:ofType:.
		                 '004'. #genericServerMessage:ofType:.
		                 '005'. #genericServerMessage:ofType:.
		                 '251'. #genericServerMessage:ofType:.
		                 '252'. #genericServerMessage:ofType:.
		                 '253'. #genericServerMessage:ofType:.
		                 '254'. #genericServerMessage:ofType:.
		                 '255'. #genericServerMessage:ofType:.
		                 '422'. #genericServerMessage:ofType: }
]

{ #category : #splitjoin }
BRMessageParser >> join: tokens [

	^ BRChannelMessage new
		messageType: 'JOIN';
		  channel: tokens first;
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> kick: tokens [

	^ BRUnknownMessage new
	messageType:'KICK';
		  message: (' ' join: tokens);
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> listChannelUsers: tokens [

	tokens at: 4 put: (tokens at: 4) allButFirst.

	^ BRChannelUsersListMessage new
		  messageType: 'LIST_CHANNEL_USERS';
		  channel: tokens third;
		  users: (tokens allButFirst:3);
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> listTopic: tokens [

	tokens at: 3 put: (tokens at: 3) allButFirst.
	^ BRTopicMessage new
		  messageType: 'LIST_TOPIC';
		  channel: tokens second;
		  message: (' ' join: (tokens allButFirst:2) );yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> messageNotParsable: from rest: aCollection [

	| indexOfExclamation fromNotNil |
	from ifNil: [ fromNotNil := 'SERVER' ] ifNotNil: [ fromNotNil:= from ].
	indexOfExclamation := fromNotNil indexOf: $!.
	indexOfExclamation = 0 ifTrue: [ indexOfExclamation := fromNotNil size ].

	^ BRUnknownMessage new
		  from: fromNotNil;
		  shortFrom: (fromNotNil copyFrom: 1 to: indexOfExclamation);
		  messageType: aCollection first;
		  message: aCollection allButFirst;
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> mode: tokens [
	|chan|
	chan :=tokens at:1 ifAbsent: [ '' ].
	
(	chan size > 0 and:[chan at:1 = $#] )ifTrue:[
		^ BRModeMessage  new
			messageType: 'MODE';
			channel: chan;
			message: ('' join: tokens allButFirst );
			yourself
		]
	ifFalse:[

	^ BRModeMessage new
		  messageType: 'MODE';
		  message: (' ' join: tokens);
		  yourself]
]

{ #category : #'as yet unclassified' }
BRMessageParser >> nick: tokens [

	^ BRNickMessage new
	messageType: 'NICK';
		  newNick: tokens first;
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> notice: tokens [

	^ BRServerMessage  new
		  messageType: 'NOTICE';
		  message: (' ' join: tokens);
		  yourself
]

{ #category : #parsing }
BRMessageParser >> parseMessage: line [

	| tokens token from dispatch result indexOfExclamation shortFrom |
	Transcript
		show: 'will parse message:' , line;
		cr.

	tokens := line substrings.

	token := tokens at: 1 ifAbsent: [ '' ].

	(token at: 1 ifAbsent: [ '' ]) = $@ ifTrue: [ 
		tokens := tokens allButFirst.
		token := tokens at: 1 ifAbsent: [ '' ] ].

	(token at: 1 ifAbsent: [ '' ]) = $: ifTrue: [ 
		from := token allButFirst.
		tokens := tokens allButFirst.
		token := tokens at: 1 ifAbsent: [ '' ] ].

	dispatch := parseDispatch
		            at: token
		            ifAbsent: [ 
		            ^ self messageNotParsable: from rest: tokens ].

	from ifNil: [ from := 'SERVER' ].
	indexOfExclamation := from indexOf: $!.
	indexOfExclamation = 0
		ifTrue: [ indexOfExclamation := from size ]
		ifFalse: [ indexOfExclamation := indexOfExclamation - 1 ].
	shortFrom := from copyFrom: 1 to: indexOfExclamation.

	result := dispatch numArgs = 2
		ifTrue: [ 
			self
				          perform: dispatch
				          with: tokens allButFirst
				          with: token ]
		ifFalse: [ 
		self perform: dispatch with: tokens allButFirst ].

	result
		from: from;
		shortFrom: shortFrom.
	^ result
]

{ #category : #'as yet unclassified' }
BRMessageParser >> part: tokens [

	^ BRChannelMessage new
	messageType:'PART';
		  channel: tokens first;
		  yourself
]

{ #category : #'as yet unclassified' }
BRMessageParser >> privMsg: tokens [

	| target |
	target := tokens first.
	tokens at: 2 put: (tokens at: 2) allButFirst.

	((target at: 1) = $# or: [ (target at: 1) = $@ ])
		ifTrue: [ 
			^ BRPrivChannelMessage new
				  messageType: 'PRIVMSG';
				  channel: tokens first;
				  message: (' ' join: tokens allButFirst);
				  yourself ]
		ifFalse: [ 
			^ BRPrivChatMessage new
				  messageType: 'PRIVMSG';
				  message: (' ' join: tokens allButFirst);
				  yourself ]
]

{ #category : #'as yet unclassified' }
BRMessageParser >> quit: tokens [

	tokens at:1 put:(tokens at:1) allButFirst .

	^BRPrivChatMessage  new
	messageType:'QUIT';
	message:(' ' join: tokens);
	yourself 
	
		  
		  
		  
]

{ #category : #'as yet unclassified' }
BRMessageParser >> topic: tokens [

	tokens at: 2 put: (tokens at: 2) allButFirst.
	^ BRTopicMessage new
		  messageType: 'TOPIC';
		  channel: tokens first;
		  topic: (' ' join: tokens allButFirst);
		  yourself
]
