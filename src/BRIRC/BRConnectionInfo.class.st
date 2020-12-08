Class {
	#name : #BRConnectionInfo,
	#superclass : #SpPresenter,
	#instVars : [
		'server',
		'port',
		'username',
		'serverLabel',
		'portLabel',
		'usernameLabel'
	],
	#category : #'BRIRC-App'
}

{ #category : #specs }
BRConnectionInfo class >> defaultSpec [

	^ SpBoxLayout new
		  add: #serverLabel
		  expand: false
		  fill: false
		  padding: 10;
		  add: #server
		  expand: false
		  fill: false
		  padding: 0;
		  add: #portLabel
		  expand: false
		  fill: false
		  padding: 10;
		  add: #port
		  expand: false
		  fill: false
		  padding: 0;
		  add: #usernameLabel
		  expand: false
		  fill: false
		  padding: 10;
		  add: #username
		  expand: false
		  fill: false
		  padding: 0;
		  yourself
]

{ #category : #initialization }
BRConnectionInfo >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter
		addButton: 'Connect' do: [ :presenter | presenter triggerOkAction ];
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		title: 'Connection Info';
		extent: 600 @ 400;
		centered;
		okAction: [ 
			| val |
			val := [ port number ] onErrorDo: [ 0 ].
			(val between: port minimum and: port maximum) ifTrue: [ 
					aDialogWindowPresenter close.
										self owner announcer announce:
							(NewConnectionInfoAnnouncement new
								 server: server text;
								 port: port number;
								 username: username text;
								 yourself) ] ]
]

{ #category : #initialization }
BRConnectionInfo >> initializePresenters [

	serverLabel := self newLabel label: 'Server'.
	portLabel := self newLabel label: 'Port'.
	usernameLabel := self newLabel label: 'Username'.
	server := SpTextInputFieldPresenter new.
	port := SpNumberInputFieldPresenter new
	beInteger;
		        minimum: 1;
		        maximum: 65535;
		        yourself.
	username := SpTextInputFieldPresenter new
]

{ #category : #'as yet unclassified' }
BRConnectionInfo >> port [

	^ port number
]

{ #category : #'as yet unclassified' }
BRConnectionInfo >> server [

	^ server text
]

{ #category : #'as yet unclassified' }
BRConnectionInfo >> username [

	^ username text
]
