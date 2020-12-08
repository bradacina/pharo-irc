Class {
	#name : #BRMainView,
	#superclass : #SpPresenter,
	#instVars : [
		'channelsList',
		'mainView',
		'contextMenu',
		'childrenViews',
		'connHandler'
	],
	#category : #'BRIRC-App'
}

{ #category : #initialization }
BRMainView class >> defaultSpec [

	| aLayout  |
	aLayout := SpBoxLayout newVertical
		           add: (SpPanedLayout newHorizontal
				            addFirst: #channelsList;
				            addSecond: #mainView;
				            yourself);
		           yourself.

	^ aLayout
]

{ #category : #'as yet unclassified' }
BRMainView >> connectToServer: aString port: aNumber username: anotherString [

	| serverView |
	
	connHandler disconnect.
	connHandler := BRConnectionHandler new
		               server: aString;
		               port: aNumber;
		               username: anotherString;
		               yourself.

	channelsList list: (OrderedCollection with: aString).
	serverView := BRServerView new
		              title: aString;
		              application: self owner;
		              yourself.
		childrenViews removeAll.
	childrenViews add: serverView.

	mainView layout removeAll.
	mainView layout add: serverView
]

{ #category : #initialization }
BRMainView >> initializePresenters [

	contextMenu := self newMenu
		               addItem: [ :item | 
			               item
				               name: 'Connect To Server';
				               action: [ self application openConnectionView ] ];
		               addItem: [ :item | 
			               item
				               name: 'Test 2';
				               action: [ "Action" ] ];
		               yourself.

	channelsList := self newList display: [ :each | each ].
	mainView := BREmptyView new.

	channelsList
		items: #( 'No Connections' );
		contextMenu: contextMenu.

	
]

{ #category : #accessing }
BRMainView >> owner: aPresenter [

	owner := aPresenter.

	self owner announcer
		when: NewConnectionInfoAnnouncement
		do: [ :ann | 
			
			channelsList server = ann server ifTrue: [ ^ self ].
			self
				connectToServer: ann server
				port: ann port
				username: ann username ]
]
