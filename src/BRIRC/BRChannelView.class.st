Class {
	#name : #BRChannelView,
	#superclass : #SpPresenter,
	#instVars : [
		'users',
		'chat',
		'input'
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
				position:70 percent;
				   addFirst: #chat;
				   addSecond: #users;
				   yourself)
		  expand: true
		  fill: true
		  padding: 1;
		  add: #input height: 30;
		  yourself
]

{ #category : #adding }
BRChannelView >> addMessage: aString [

	chat  text: (chat text , aString)
]

{ #category : #adding }
BRChannelView >> addMessages: aCollection [
	|stream|
	stream := WriteStream new.
	aCollection do: [ :item| item printOn: stream ].
	chat text: stream contents.
]

{ #category : #adding }
BRChannelView >> addUser: aString [

	users items add: aString
	
]

{ #category : #adding }
BRChannelView >> addUsers: aCollection [

	users items: aCollection asSortedCollection 
]

{ #category : #adding }
BRChannelView >> changeUser: aUser to: anotherUser [

	users items remove: aUser ifAbsent: [ ^ self ].
	users items add: anotherUser.
]

{ #category : #initialization }
BRChannelView >> initializePresenters [

	users := self newList.
	users items: (OrderedCollection with: 'User1' with: 'User2').
	chat := self newText
		        beNotEditable;
		        yourself.
	chat text: 'Hello', String crlf, 'there'.
	input := self newTextInput
]

{ #category : #adding }
BRChannelView >> removeUser: aString [

	users items remove:aString.
]
