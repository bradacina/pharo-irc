Class {
	#name : #BRPrivChannelMessage,
	#superclass : #BRChannelMessage,
	#instVars : [
		'message'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRPrivChannelMessage >> message [

	^ message
]

{ #category : #accessing }
BRPrivChannelMessage >> message: anObject [

	message := anObject
]
