"
I am a replacement tool for """"class"""" comments. 
"
Class {
	#name : #ClyRichTextClassCommentEditorToolMorph,
	#superclass : #ClyClassCommentEditorToolMorph,
	#instVars : [
		'isRendering'
	],
	#category : #'Pillar-TextPresenter'
}

{ #category : #activation }
ClyRichTextClassCommentEditorToolMorph class >> classCommentTabActivation [ 
	"Do nothing - part of a hack for overriding the class comment tool in Calypso"
]

{ #category : #activation }
ClyRichTextClassCommentEditorToolMorph class >> classTabActivation [  
	"Do nothing - part of a hack for overriding the class comment tool in Calypso"
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: editingClass comment)
]

{ #category : #building }
ClyRichTextClassCommentEditorToolMorph >> buildTextMorph [
	super buildTextMorph.
	self setBackgroundColor: self renderColor.
	self bindKeyCombination: $r command toAction: [ self toggleMode ].
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> changesAccepted [
	| res |
	res := super changesAccepted.
	self switchToRenderMode.
	^res
]

{ #category : #initialization }
ClyRichTextClassCommentEditorToolMorph >> defaultColor [
	isRendering ifNil: [ ^ self renderColor  ].
	isRendering 
		ifTrue: [ ^self renderColor  ]
		ifFalse: [ ^ super defaultColor  ].
	
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> disable [
	textMorph enabled: false
]

{ #category : #rendering }
ClyRichTextClassCommentEditorToolMorph >> editColor [
	"super defaultColor lightness < 0.5
		ifTrue: [ ^super defaultColor lighter lighter ]
		ifFalse: [ ^super defaultColor darker ]"
		^Color white
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> editingText [
	isRendering 
		ifTrue: [ ^ self asRenderedText  ]
		ifFalse: [ ^ super editingText ]
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> enable [
	textMorph enabled: true
]

{ #category : #rendering }
ClyRichTextClassCommentEditorToolMorph >> renderColor [
	"super defaultColor lightness < 0.5
		ifTrue: [ ^super defaultColor lighter lighter ]
		ifFalse: [ ^super defaultColor darker ]"
		^Color veryLightGray lighter lighter 
]

{ #category : #initialization }
ClyRichTextClassCommentEditorToolMorph >> setBackgroundColor: aColor [
	"Convenience method to set my background color"
	textMorph color: aColor
	
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> setUpModelFromContext [
	"I am being used as a kind of late initialization method"
	isRendering := true.
	"self color: self renderColor.
	self bindKeyCombination: $r command toAction: [ self toggleMode ]."
	super setUpModelFromContext
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> switchToEditMode [
	isRendering := false.
	self enable.
	self setBackgroundColor: (self editColor ).
	self triggerUpdate
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> switchToRenderMode [
	self hasUnacceptedEdits
		ifTrue: [ ^ self ].
	isRendering := true.
	self setBackgroundColor: (self renderColor ).
	self disable.
	self triggerUpdate
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> toggleMode [
	isRendering
		ifTrue: [ self switchToEditMode ]
		ifFalse: [ self switchToRenderMode ].
]