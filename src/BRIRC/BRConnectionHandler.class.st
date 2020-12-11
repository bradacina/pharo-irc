Class {
	#name : #BRConnectionHandler,
	#superclass : #Object,
	#instVars : [
		'conn',
		'isRegistered',
		'listeners',
		'config'
	],
	#category : #'BRIRC-Connection'
}

{ #category : #'as yet unclassified' }
BRConnectionHandler class >> sendNick: aString [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
BRConnectionHandler >> config [

	^ config
]

{ #category : #accessing }
BRConnectionHandler >> config: anObject [

	config := anObject
]

{ #category : #ssl }
BRConnectionHandler >> connect [

	config ifNil: [ self error: 'Config is required' ].
	config server ifNil: [ self error: 'Server is required' ].
	config port ifNil: [ self error: 'Port is required' ].
	config user ifNil: [ self error: 'Username is required' ].
	config nick ifNil: [ self error: 'Nick is required' ].

	conn := SocketStream
		        openConnectionToHostNamed: config server
		        port: config port.
	conn noTimeout.

	conn receiveData: 1.

	self
		sendRegistrationNick;
		sendRegistrationUsername.

	[ self readLoop ] forkAt: Processor userBackgroundPriority
]

{ #category : #'connection open/close' }
BRConnectionHandler >> disconnect [

	conn ifNotNil: [ conn close ]
]

{ #category : #parsing }
BRConnectionHandler >> handleLine: aString [

	| tokens currentToken source tokenIndex params |
	tokens := aString findTokens: ' '.

	tokens isEmpty ifTrue: [ ^ self ].

	tokenIndex := 1.
	currentToken := tokens at: tokenIndex.

	(currentToken beginsWith: '@') ifTrue: [ 
		tokenIndex := 2.
		currentToken := tokens at: tokenIndex ifAbsent: [ '' ] ].
	(currentToken beginsWith: ':') ifTrue: [ 
		source := currentToken.
		tokenIndex := 3.
		currentToken := tokens at: tokenIndex ifAbsent: [ '' ] ].

	params := tokenIndex + 1 <= tokens size
		          ifTrue: [ tokens copyFrom: tokenIndex + 1 to: tokens size ]
		          ifFalse: [ tokens copyEmpty ].

	(((currentToken = '001' or: [ currentToken = '002' ]) or: [ 
		  currentToken = '003' ]) or: [ currentToken = '004' ]) ifTrue: [ 
		isRegistered := true. ].

	currentToken = 'PING' ifTrue: [ ^ self handlePing: params ]
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> handlePing: aCollection [

	
	conn isConnected ifFalse: [ ^ self ].

	conn
		nextPutAll: 'PONG ';
		nextPutAll:
			((aCollection at: 1 ifAbsent: [ '' ]) trimLeft: [ :c | c = $: ]);
		crlf;
		flush
]

{ #category : #testing }
BRConnectionHandler >> isConnected [
	conn ifNil: [ ^ false ].
	
	^ conn isConnected.
]

{ #category : #accessing }
BRConnectionHandler >> isRegistered [

	self isConnected ifFalse:[isRegistered  := false].
	
^ isRegistered 
]

{ #category : #accessing }
BRConnectionHandler >> nextLine [

	| line |
	line := conn nextLineCrLf.

	self handleLine: line.

	listeners ifNotNil: [ listeners do: [ :each | [each cull: line] onErrorDo:['ERROR'] ] ].

	^ line
]

{ #category : #parsing }
BRConnectionHandler >> parseMessage: aString [
^ nil
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> readLoop [

	[ conn isOtherEndConnected & conn isConnected ] whileTrue: [ 
		self nextLine ]
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> registerListener: aBlock [

	listeners ifNil: [ listeners := OrderedCollection new ].
	
	listeners add: aBlock.
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> removeAllListeners [
	listeners ifNil: [ listeners := OrderedCollection new. ^ self ].

	listeners removeAll.
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> removeListenerAt: index [

	listeners ifNil: [ 
		listeners := OrderedCollection new.
		^ self ].

	listeners removeAt: index
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendJoin: aString [

	conn isConnected ifFalse: [ ^ false ].

	conn
		nextPutAll: 'JOIN ';
		nextPutAll: aString;
		crlf;
		flush
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendJoin: aString key: aKey [

	conn isConnected ifFalse: [ ^ false ].

	conn
		nextPutAll: 'JOIN ';
		nextPutAll: aString;
		nextPut: ' ';
		nextPutAll: aKey;
		flush
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendNick: aString [

	conn isConnected ifFalse: [ ^ self ].
	conn
		nextPutAll: 'NICK ';
		nextPutAll: aString;
		crlf; flush.
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendPart: aString [

	conn isConnected ifFalse: [ ^ false ].

	conn
		nextPutAll: 'PART ';
		nextPutAll: aString;
		crlf;
		flush
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendRaw: aString [
conn isConnected ifFalse:[^ false].

conn nextPutAll: aString; crlf;flush.
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendRegistrationNick [

	self sendNick: config nick
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendRegistrationUsername [

	self sendUsername: config user
]

{ #category : #'as yet unclassified' }
BRConnectionHandler >> sendUsername: aString [

	conn isConnected ifFalse: [ ^ self ].
	conn
		nextPutAll: 'USER ';
		nextPutAll: aString;
		nextPutAll: ' 0 * ';
		nextPutAll: aString;
		crlf;
		flush
]
