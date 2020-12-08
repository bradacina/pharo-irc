Class {
	#name : #BRNickMessage,
	#superclass : #BRMessage,
	#instVars : [
		'newNick'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRNickMessage >> newNick [

	^ newNick
]

{ #category : #accessing }
BRNickMessage >> newNick: anObject [

	newNick := anObject
]
