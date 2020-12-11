Class {
	#name : #BRChannelView,
	#superclass : #SpPresenter,
	#instVars : [
		'users',
		'input',
		'userInputAction',
		'channel',
		'messages'
	],
	#category : #'BRIRC-App'
}

{ #category : #specs }
BRChannelView class >> defaultSpec [

	^ SpBoxLayout new
		  beVertical;
		  beNotHomogeneous;
		  add: (SpPanedLayout new
				   beHorizontal;
				   position: 70 percent;
				   addFirst: #messages;
				   addSecond: #users;
				   yourself)
		  expand: true
		  fill: true
		  padding: 2;
		  add: #input height: 30;
		  yourself
]

{ #category : #adding }
BRChannelView >> addMessage: aString [
	<TODO: 'add mutex here'>
	messages text: messages text , String crlf , aString.
	self update
]

{ #category : #adding }
BRChannelView >> addMessages: aCollection [

	<TODO: 'add mutex here'>
	messages text: (String crlf join: aCollection).
	self update
]

{ #category : #adding }
BRChannelView >> addUsers: aCollection forChannel: aString [

	<TODO: 'add mutex here'>
	| newCollection |
	channel name= aString ifFalse: [ ^ self ].

	newCollection := SortedCollection new
		                 sortBlock: [ :a :b | self sortUserA: a userB: b ];
		                 yourself.
	newCollection addAll: aCollection.
	users items: newCollection.

	self update
]

{ #category : #accessing }
BRChannelView >> channel [

	^ channel
]

{ #category : #accessing }
BRChannelView >> channel: anObject [

	<TODO: 'add mutex here'>
	channel == anObject ifTrue: [ ^ self ].

	channel := anObject.
	messages text: (String crlf join: channel messages).
	users items removeAll.
	self addUsers: channel users forChannel: channel name.
	input clearContent.
	self update
]

{ #category : #initialization }
BRChannelView >> initializePresenters [

	users := self newList.
	users items: (SortedCollection new
			 sortBlock: [ :a :b | self sortUserA: a userB: b ];
			 yourself).
	users display: [ :u | 
		| result |
		result := u nick.
		u isVoice ifTrue: [ result := '+' , u nick ].
		u isHalfOp ifTrue: [ result := '&' , u nick ].
		u isOp ifTrue: [ result := '@' , u nick ].
		result ].

	messages := self newText
		            beNotEditable;
		            yourself.
	messages text: 'Hello' , String crlf , 'there'.

	input := self newTextInput.
	input whenSubmitDo: [ 
		userInputAction ifNotNil: [ 
			[ userInputAction cull: input text cull: channel ] onErrorDo: [ "do nothing"
				 ] ].
		input clearContent ]
]

{ #category : #sorting }
BRChannelView >> sortUserA: userA userB: userB [

	| defaultSort |
	defaultSort := [ ^ userA nick < userB nick ].
	userA isOp & userB isOp not ifTrue: [ ^ true ].
	userB isOp & userA isOp not ifTrue: [ ^ false ].
	userA isOp & userB isOp ifTrue: defaultSort.

	userA isHalfOp & userB isHalfOp not ifTrue: [ ^ true ].
	userB isHalfOp & userA isHalfOp not ifTrue: [ ^ false ].
	userA isHalfOp & userB isHalfOp ifTrue: defaultSort.

	userA isVoice & userB isVoice not ifTrue: [ ^ true ].
	userB isVoice & userA isVoice not ifTrue: [ ^ false ].
	userA isVoice & userB isVoice ifTrue: defaultSort.

	^ userA nick < userB nick
]

{ #category : #accessing }
BRChannelView >> userInputAction [

	^ userInputAction
]

{ #category : #accessing }
BRChannelView >> userInputAction: anObject [

	userInputAction := anObject
]
