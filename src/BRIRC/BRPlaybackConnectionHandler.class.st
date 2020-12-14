Class {
	#name : #BRPlaybackConnectionHandler,
	#superclass : #Object,
	#instVars : [
		'messages',
		'listeners'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRPlaybackConnectionHandler >> messages: anObject [

	messages := anObject
]

{ #category : #'as yet unclassified' }
BRPlaybackConnectionHandler >> registerListener: aBlock [

	listeners ifNil: [ listeners := OrderedCollection new ].

	listeners add: aBlock
]

{ #category : #accessing }
BRPlaybackConnectionHandler >> replayMessageAt: aNumber [

	listeners ifNil: [ ^ self ].

	messages ifNil: [ ^ self ].

	listeners do: [ :listener | listener cull: (messages at: aNumber) ]
]

{ #category : #accessing }
BRPlaybackConnectionHandler >> start [

	| delay |
	listeners ifNil: [ ^ self ].

	messages ifNil: [ ^ self ].

	delay := Delay forMilliseconds: 1000.

	[ 
		messages doWithIndex: [ :line :idx | 
			listeners do: [ :listener | listener cull: line ].
			(idx > 20) & (idx < 30) ifTrue: [ delay wait ].
		] 
	] forkAt: Processor userBackgroundPriority
]
