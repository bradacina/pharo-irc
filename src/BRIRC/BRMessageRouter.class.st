Class {
	#name : #BRMessageRouter,
	#superclass : #Object,
	#instVars : [
		'connHandler',
		'window'
	],
	#category : #'BRIRC-App'
}

{ #category : #'as yet unclassified' }
BRMessageRouter class >> withConnHandler: aConnHandler withWindow: aWindow [

	^ self new
		  connHandler: aConnHandler;
		  window: aWindow;
		  yourself
]

{ #category : #accessing }
BRMessageRouter >> connHandler [

	^ connHandler
]

{ #category : #accessing }
BRMessageRouter >> connHandler: anObject [

	connHandler := anObject.
	connHandler registerListener: [ :line | self route: line ].
]

{ #category : #'as yet unclassified' }
BRMessageRouter >> route: aString [

	|stream|	

	stream := WriteStream with: window text.
	stream
		nextPutAll: aString;
		cr.

	window text: stream contents.

	Processor yield.

	^ true
]

{ #category : #accessing }
BRMessageRouter >> window [

	^ window
]

{ #category : #accessing }
BRMessageRouter >> window: anObject [

	window := anObject
]
