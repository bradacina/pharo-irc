Class {
	#name : #BRUser,
	#superclass : #Object,
	#instVars : [
		'nick',
		'nickWithHostmask',
		'isOp',
		'isHalfOp',
		'isVoice'
	],
	#category : #'BRIRC-Domain'
}

{ #category : #accessing }
BRUser >> changeNick: aString [

	| indexOfExclamation |
	indexOfExclamation := nickWithHostmask indexOf: $!.
	nick := aString.

	nickWithHostmask := indexOfExclamation = 0
		ifTrue: [ aString ]
		ifFalse: [ 
			aString
			                    ,
			                    (nickWithHostmask allButFirst:
				                     indexOfExclamation - 1) ]
]

{ #category : #accessing }
BRUser >> initialize [ 
	isOp := false.
	isHalfOp := false.
	isVoice := false.
]

{ #category : #accessing }
BRUser >> isHalfOp [

	^ isHalfOp
]

{ #category : #accessing }
BRUser >> isHalfOp: anObject [

	isHalfOp := anObject
]

{ #category : #accessing }
BRUser >> isOp [

	^ isOp
]

{ #category : #accessing }
BRUser >> isOp: anObject [

	isOp := anObject
]

{ #category : #accessing }
BRUser >> isVoice [

	^ isVoice
]

{ #category : #accessing }
BRUser >> isVoice: anObject [

	isVoice := anObject
]

{ #category : #accessing }
BRUser >> nick [

	^ nick
]

{ #category : #accessing }
BRUser >> nick: anObject [

	nick := anObject
]

{ #category : #accessing }
BRUser >> nickWithHostmask [

	^ nickWithHostmask
]

{ #category : #accessing }
BRUser >> nickWithHostmask: anObject [

	nickWithHostmask := anObject
]

{ #category : #accessing }
BRUser >> printOn: stream [

isOp ifTrue:[stream nextPut:$@].
isHalfOp ifTrue:[stream nextPut:$&].
isVoice ifTrue:[stream nextPut:$+].
stream nextPutAll: nick.
]
