Class {
	#name : #BRChannel,
	#superclass : #Object,
	#instVars : [
		'users',
		'messages',
		'title'
	],
	#category : #'BRIRC-App'
}

{ #category : #initialization }
BRChannel >> initialize [ 
	messages := OrderedCollection new.
	title := ''.
	users := OrderedCollection  new.
]

{ #category : #accessing }
BRChannel >> messages [

	^ messages
]

{ #category : #accessing }
BRChannel >> messages: anObject [

	messages := anObject
]

{ #category : #accessing }
BRChannel >> title [

	^ title
]

{ #category : #accessing }
BRChannel >> title: anObject [

	title := anObject
]

{ #category : #accessing }
BRChannel >> users [

	^ users
]

{ #category : #accessing }
BRChannel >> users: anObject [

	users := anObject
]
