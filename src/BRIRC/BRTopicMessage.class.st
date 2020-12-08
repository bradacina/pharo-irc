Class {
	#name : #BRTopicMessage,
	#superclass : #BRChannelMessage,
	#instVars : [
		'topic'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRTopicMessage >> topic [

	^ topic
]

{ #category : #accessing }
BRTopicMessage >> topic: anObject [

	topic := anObject
]
