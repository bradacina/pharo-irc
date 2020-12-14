Class {
	#name : #BRMessage,
	#superclass : #Object,
	#instVars : [
		'from',
		'shortFrom',
		'messageType',
		'channel',
		'users',
		'newNick',
		'serverMessages',
		'message',
		'topic'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRMessage >> channel [

	^ channel
]

{ #category : #accessing }
BRMessage >> channel: anObject [

	channel := anObject
]

{ #category : #accessing }
BRMessage >> from [

	^ from
]

{ #category : #accessing }
BRMessage >> from: anObject [

	from := anObject
]

{ #category : #initialization }
BRMessage >> initialize [

	serverMessages := OrderedCollection new.
	serverMessages
	add:'NOTICE';
		add: 'PING';
		add: '001';
		add: '002';
		add: '003';
		add: '004';
		add: '005';
		add: '251';
		add: '252';
		add: '253';
		add: '254';
		add: '422'
]

{ #category : #testing }
BRMessage >> isChannelModeMessage [

	"A channel MODE message stores the channel name in `channel` and  the mode in `message`"

	^ messageType = 'CHAN_MODE'
]

{ #category : #testing }
BRMessage >> isChannelPrivMessage [
"A channel PRIVMSG will have a channel name stored in `channel` and the message stored in `message`"
^ messageType = 'CHAN_PRIVMSG'
]

{ #category : #testing }
BRMessage >> isChannelUsersListMessage [

	"A channel UsersList message will have a channel name stored in `channel` and a list of users stored in `users`"

	^ messageType = 'LIST_CHANNEL_USERS'
]

{ #category : #testing }
BRMessage >> isJoinMessage [
^ messageType = 'JOIN'
]

{ #category : #testing }
BRMessage >> isKickMessage [
^ messageType = 'KICK'
]

{ #category : #testing }
BRMessage >> isNickMessage [

"A Nick message will have the new nickname stored in `newNick`"
^ messageType = 'NICK'
]

{ #category : #testing }
BRMessage >> isOtherChannelMessage [

	(messageType = '333' or: [ messageType = '366' ]) ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
BRMessage >> isPartMessage [
^ messageType  ='PART'
]

{ #category : #testing }
BRMessage >> isPrivDirectMessage [

	^ messageType = 'DIRECT_PRIVMSG'
]

{ #category : #testing }
BRMessage >> isQuitMessage [
^ messageType = 'QUIT'
]

{ #category : #testing }
BRMessage >> isServerMessage [

	(serverMessages includes: messageType) ifTrue: [ ^ true ] ifFalse:[^ false].

]

{ #category : #testing }
BRMessage >> isTopicMessage [

	"A channel Topic message will have a channel name stored in `channel` and the topic stored in `topic`"

	^ (messageType = 'TOPIC' or: [ messageType = 'LIST_TOPIC' ])
]

{ #category : #testing }
BRMessage >> isUnknownMessage [
^ messageType = 'UNKNOWN'
]

{ #category : #testing }
BRMessage >> isUserModeMessage [
"A user MODE message stores the mode in `message`"
	^ messageType = 'USER_MODE'
]

{ #category : #accessing }
BRMessage >> message [

	^ message
]

{ #category : #accessing }
BRMessage >> message: anObject [

	message := anObject
]

{ #category : #accessing }
BRMessage >> messageType [

	^ messageType
]

{ #category : #accessing }
BRMessage >> messageType: anObject [

	messageType := anObject
]

{ #category : #accessing }
BRMessage >> shortFrom [

	^ shortFrom
]

{ #category : #accessing }
BRMessage >> shortFrom: anObject [

	shortFrom := anObject
]

{ #category : #accessing }
BRMessage >> topic [

	^ topic
]

{ #category : #accessing }
BRMessage >> topic: anObject [

	topic := anObject
]

{ #category : #accessing }
BRMessage >> users [

	^ users
]

{ #category : #accessing }
BRMessage >> users: anObject [

	users := anObject
]
