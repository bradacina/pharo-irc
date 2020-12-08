Class {
	#name : #BRConnectionManager,
	#superclass : #Object,
	#instVars : [
		'channels',
		'privMessages'
	],
	#category : #BRIRC
}

{ #category : #initialization }
BRConnectionManager >> initialize [
 channels := OrderedCollection new.
 privMessages  := OrderedCollection new.
]
