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

{ #category : #adding }
BRChannelView >> removeUser: aString [

	users items remove:aString.
]
