Class {
	#name : #BRRouter,
	#superclass : #Object,
	#instVars : [
		'channels',
		'chanView',
		'connHandler',
		'messageParser',
		'shouldLogMessages',
		'log'
	],
	#category : #'BRIRC-App'
}

{ #category : #accessing }
BRRouter >> chanView [

	^ chanView
]

{ #category : #accessing }
BRRouter >> chanView: aBRChanelView [

	chanView := aBRChanelView
]

{ #category : #'as yet unclassified' }
BRRouter >> channelUsersList: aBRChannelUsersListMessage [

	| chan |
	channels ifNil: [ ^ self ].

	chan := channels
		        detect: [ :c | c name = aBRChannelUsersListMessage channel ]
		        ifNone: [ 
			        | newChan |
			        newChan := BRChannel new.
			        channels add: newChan.
			        newChan name: aBRChannelUsersListMessage channel.
			        chanView channel: newChan.
			        newChan ].

	chan addAllUsers: aBRChannelUsersListMessage users.

	chanView ifNil: [ ^ self ].

	chanView channel name = chan name ifTrue: [ 
		chanView addUsers: chan users forChannel: chan name ]
]

{ #category : #accessing }
BRRouter >> channels [

	^ channels
]

{ #category : #accessing }
BRRouter >> channels: anObject [

	channels := anObject
]

{ #category : #accessing }
BRRouter >> connHandler [

	^ connHandler
]

{ #category : #accessing }
BRRouter >> connHandler: aBRConnectionHandler [

	connHandler := aBRConnectionHandler.

	connHandler registerListener: [ :line | 
		self routeMessage: (messageParser parseMessage: line) ]
]

{ #category : #initialization }
BRRouter >> initialize [

	messageParser := BRMessageParser new.
	shouldLogMessages  := false.
	log := OrderedCollection new.
]

{ #category : #accessing }
BRRouter >> log [

	^ log
]

{ #category : #'as yet unclassified' }
BRRouter >> privChannelMessage: aBRPrivChannelMessage [

	| chan |
	channels ifNil: [ ^ self ].

	chan := channels detect: [ :c | 
		        c name = aBRPrivChannelMessage channel ].
	chan ifNil: [ ^ self ].

	chan addMessage: aBRPrivChannelMessage message.

	chanView ifNil: [ ^ self ].

	chanView channel name = chan name ifTrue: [ 
		chanView addMessage: '[' , aBRPrivChannelMessage shortFrom , ']:'
			, aBRPrivChannelMessage message ]
]

{ #category : #options }
BRRouter >> routeMessage: aBRMessage [

	shouldLogMessages ifTrue: [ log add: aBRMessage ].

	aBRMessage isChannelUsersListMessage ifTrue: [ 
		^ self channelUsersList: aBRMessage ].
	aBRMessage isChannelPrivMessage ifTrue: [ 
		^ self privChannelMessage: aBRMessage ].

	
]

{ #category : #accessing }
BRRouter >> shouldLogMessages: anObject [

	shouldLogMessages := anObject
]
