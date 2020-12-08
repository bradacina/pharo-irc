Class {
	#name : #BRChannelMessage,
	#superclass : #BRMessage,
	#instVars : [
		'channel'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRChannelMessage >> channel [

	^ channel
]

{ #category : #accessing }
BRChannelMessage >> channel: anObject [

	channel := anObject
]
