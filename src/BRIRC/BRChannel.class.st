Class {
	#name : #BRChannel,
	#superclass : #Object,
	#instVars : [
		'users',
		'messages',
		'topic',
		'name'
	],
	#category : #'BRIRC-Domain'
}

{ #category : #adding }
BRChannel >> addAllUsers: anOrderedCollectionOfString [

	"Adds multiple users to the channel. Normally when we join a channel the server sends us a list of users that are already present on the channel.
	This list could require multiple messages from the server."

	users addAll: (anOrderedCollectionOfString  collect:[:each| each asBRUser ])
]

{ #category : #adding }
BRChannel >> addMessage: aString [

	

	messages add: aString
]

{ #category : #adding }
BRChannel >> addUser: aString [

	"Add a single user to the channel. This happens when a new user JOINs a channel"

	users add: aString asBRUser.
]

{ #category : #initialization }
BRChannel >> initialize [

	messages := OrderedCollection new.
	topic := ''.
	users := PluggableSet new.
	users hashBlock:[:item| item nick hash].
	users equalBlock:[:a :b| a nick = b nick].
]

{ #category : #accessing }
BRChannel >> messages [

	^ messages
]

{ #category : #accessing }
BRChannel >> name [

	^ name
]

{ #category : #accessing }
BRChannel >> name: aString [

	name := aString
]

{ #category : #adding }
BRChannel >> removeUser: aString [

	

	users
		detect: [ :u | u nick = aString ]
		ifFound: [ :u | users remove: u ]
]

{ #category : #accessing }
BRChannel >> topic [

	^ topic
]

{ #category : #accessing }
BRChannel >> topic: aString [

	topic := aString
]

{ #category : #adding }
BRChannel >> user: aString setHalfOperator: aBool [

	

	users
		detect: [ :u | u nick = aString ]
		ifFound: [ :u | u isHalfOp: aBool ]
]

{ #category : #adding }
BRChannel >> user: aString setNick: nickString [

	users ifNil: [ ^ self ].

	users
		detect: [ :u | u nick = aString ]
		ifFound: [ :u | u changeNick: nickString ]
]

{ #category : #adding }
BRChannel >> user: aString setOperator: aBool [

	

	users
		detect: [ :u | u nick = aString ]
		ifFound: [ :u | u isOp: aBool ]
]

{ #category : #adding }
BRChannel >> user: aString setVoice: aBool [

	

	users
		detect: [ :u | u nick = aString ]
		ifFound: [ :u | u isVoice: aBool ]
]

{ #category : #accessing }
BRChannel >> users [

	^ users
]
