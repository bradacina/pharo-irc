Class {
	#name : #BRServerMessage,
	#superclass : #BRMessage,
	#instVars : [
		'message'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRServerMessage >> message [

	^ message
]

{ #category : #accessing }
BRServerMessage >> message: anObject [

	message := anObject
]
