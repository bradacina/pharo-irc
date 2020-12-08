Class {
	#name : #BRConnectionConfig,
	#superclass : #Object,
	#instVars : [
		'server',
		'port',
		'user',
		'nick',
		'login',
		'password',
		'shouldPerformLogin'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #accessing }
BRConnectionConfig >> login [

	^ login
]

{ #category : #accessing }
BRConnectionConfig >> login: anObject [

	login := anObject
]

{ #category : #accessing }
BRConnectionConfig >> nick [

	^ nick
]

{ #category : #accessing }
BRConnectionConfig >> nick: anObject [

	nick := anObject
]

{ #category : #accessing }
BRConnectionConfig >> password [

	^ password
]

{ #category : #accessing }
BRConnectionConfig >> password: anObject [

	password := anObject
]

{ #category : #accessing }
BRConnectionConfig >> port [

	^ port
]

{ #category : #accessing }
BRConnectionConfig >> port: anObject [

	port := anObject
]

{ #category : #accessing }
BRConnectionConfig >> server [

	^ server
]

{ #category : #accessing }
BRConnectionConfig >> server: anObject [

	server := anObject
]

{ #category : #accessing }
BRConnectionConfig >> shouldPerformLogin [

	^ shouldPerformLogin
]

{ #category : #accessing }
BRConnectionConfig >> shouldPerformLogin: anObject [

	shouldPerformLogin := anObject
]

{ #category : #accessing }
BRConnectionConfig >> user [

	^ user
]

{ #category : #accessing }
BRConnectionConfig >> user: anObject [

	user := anObject
]
