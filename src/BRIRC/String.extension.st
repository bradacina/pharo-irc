Extension { #name : #String }

{ #category : #'*BRIRC' }
String >> asBRUser [

	| user nick |
	user := BRUser new.
	nick := self.
	(self at: 1) = $@ ifTrue: [ 
		user isOp: true.
		nick := self allButFirst ].
	(self at: 1) = $& ifTrue: [ 
		user isHalfOp: true.
		nick := self allButFirst ].
	(self at: 1) = $+ ifTrue: [ 
		user isVoice: true.
		nick := self allButFirst ].
	
	user nick: nick.

	^ user
]
