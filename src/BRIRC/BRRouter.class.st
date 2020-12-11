Class {
	#name : #BRRouter,
	#superclass : #Object,
	#instVars : [
		'channels',
		'chanView',
		'connHandler',
		'messageParser'
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
]

{ #category : #options }
BRRouter >> routeMessage: aBRMessage [
	|msgClass|
	msgClass := aBRMessage class.
	
	msgClass = BRChannelUsersListMessage ifTrue:[^ self channelUsersList: aBRMessage].
	msgClass = BRPrivChannelMessage ifTrue:[].
	msgClass = BRTopicMessage ifTrue:[].
	msgClass = BRNickMessage ifTrue:[].
	msgClass = BRModeMessage ifTrue:[].
	channels ifNil:[^ self].
	

]
