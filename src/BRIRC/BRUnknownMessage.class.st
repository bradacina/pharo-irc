Class {
	#name : #BRUnknownMessage,
	#superclass : #BRMessage,
	#instVars : [
		'message'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRUnknownMessage >> message [

	^ message
]

{ #category : #accessing }
BRUnknownMessage >> message: anObject [

	message := anObject
]
