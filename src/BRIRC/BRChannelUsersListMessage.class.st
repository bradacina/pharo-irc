Class {
	#name : #BRChannelUsersListMessage,
	#superclass : #BRChannelMessage,
	#instVars : [
		'users'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRChannelUsersListMessage >> users [

	^ users
]

{ #category : #accessing }
BRChannelUsersListMessage >> users: anObject [

	users := anObject
]
