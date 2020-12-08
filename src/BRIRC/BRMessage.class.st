Class {
	#name : #BRMessage,
	#superclass : #Object,
	#instVars : [
		'from',
		'shortFrom',
		'messageType'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRMessage >> from [

	^ from
]

{ #category : #accessing }
BRMessage >> from: anObject [

	from := anObject
]

{ #category : #accessing }
BRMessage >> messageType [

	^ messageType
]

{ #category : #accessing }
BRMessage >> messageType: anObject [

	messageType := anObject
]

{ #category : #accessing }
BRMessage >> shortFrom [

	^ shortFrom
]

{ #category : #accessing }
BRMessage >> shortFrom: anObject [

	shortFrom := anObject
]
