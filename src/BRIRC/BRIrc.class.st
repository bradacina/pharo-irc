Class {
	#name : #BRIrc,
	#superclass : #SpApplication,
	#category : #'BRIRC-App'
}

{ #category : #'as yet unclassified' }
BRIrc >> openConnectionView [

	| connInfo win |
	win := SpModalWindowPresenter new.
	win okAction: [  ].
	self
		open: (connInfo := BRConnectionInfo new
				             application: self;
				             yourself)
		withSpecLayout: BRConnectionInfo defaultSpec
		using: win
]

{ #category : #running }
BRIrc >> start [

	(self new: BRMainView) openWithSpec.
	self openConnectionView
]
