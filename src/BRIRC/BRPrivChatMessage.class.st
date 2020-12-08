Class {
	#name : #BRPrivChatMessage,
	#superclass : #BRMessage,
	#instVars : [
		'message'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRPrivChatMessage >> message [

	^ message
]

{ #category : #accessing }
BRPrivChatMessage >> message: anObject [

	message := anObject
]
