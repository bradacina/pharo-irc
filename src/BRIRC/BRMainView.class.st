Class {
	#name : #BRMainView,
	#superclass : #SpPresenter,
	#instVars : [
		'channelsList',
		'mainView',
		'contextMenu',
		'children',
		'connHandler'
	],
	#category : #'BRIRC-App'
}

{ #category : #initialization }
BRMainView class >> defaultSpec [

	| aLayout  |
	aLayout := SpBoxLayout newVertical
		           add: (SpPanedLayout newHorizontal
				            addFirst: #channelsList;
				            addSecond: #mainView;
				            yourself);
		           yourself.

	^ aLayout
]

{ #category : #initialization }
BRMainView >> addChannel: aString [

channelsList items add: aString.
children add: (BRChannel new topic: aString).
self update.
]

{ #category : #initialization }
BRMainView >> addMessage: message toChannel: aString [

	| found |
	found := children detect: [ :c | c topic = aString ].
	found ifNil: [ ^ self ].

	found messages add: message.

	self update
]

{ #category : #initialization }
BRMainView >> addUsers: aCollection toChannel: aString [
|found|
	found := children detect: [ :c| c topic = aString ].
	found ifNil:[^self].

	found users addAll: aCollection.

	self update
]

{ #category : #'as yet unclassified' }
BRMainView >> connectToServer: aString port: aNumber username: anotherString [

	| serverView |
	connHandler disconnect.
	connHandler := BRConnectionHandler new
		               server: aString;
		               port: aNumber;
		               username: anotherString;
		               yourself.

	channelsList list: (OrderedCollection with: aString).
	serverView := BRServerView new
		              title: aString;
		              application: self owner;
		              yourself.

	mainView layout removeAll.
	mainView layout add: serverView
]

{ #category : #initialization }
BRMainView >> initialize [
super initialize.

children := OrderedCollection new.
]

{ #category : #initialization }
BRMainView >> initializePresenters [

	channelsList := self newList display: [ :each | each ].
	mainView := BRChannelView new.

	channelsList whenSelectionChangedDo: [ :selected |
		|found|
		found := children detect:[:c| c title = selected].
		found ifNil: [ ^self ].
		mainView
		 ]
	
	
]

{ #category : #accessing }
BRMainView >> owner: aPresenter [

	owner := aPresenter.

]
