Class {
	#name : #NewConnectionInfoAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'server',
		'port',
		'username'
	],
	#category : #'BRIRC-App'
}

{ #category : #accessing }
NewConnectionInfoAnnouncement >> port [

	^ port
]

{ #category : #accessing }
NewConnectionInfoAnnouncement >> port: anObject [

	port := anObject
]

{ #category : #accessing }
NewConnectionInfoAnnouncement >> server [

	^ server
]

{ #category : #accessing }
NewConnectionInfoAnnouncement >> server: anObject [

	server := anObject
]

{ #category : #accessing }
NewConnectionInfoAnnouncement >> username [

	^ username
]

{ #category : #accessing }
NewConnectionInfoAnnouncement >> username: anObject [

	username := anObject
]
