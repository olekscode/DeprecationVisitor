Class {
	#name : #DeprecationModel,
	#superclass : #Object,
	#instVars : [
		'message',
		'transformationRule'
	],
	#category : #DeprecationVisitor
}

{ #category : #'instance creation' }
DeprecationModel class >> fromDictionary: aDictionary [

	| deprecation transformationRule |
	
	deprecation := self new
		message: (aDictionary at: 'message');
		yourself.
		
	transformationRule := aDictionary at: 'transformationRule'.
	
	transformationRule ifNotNil: [ 
		deprecation transformationRule: (TransformationRule fromString: transformationRule) ].
	
	^ deprecation
]

{ #category : #converting }
DeprecationModel >> asDictionary [
	
	^ { 
		'message' -> message asString .
		'transformationRule' -> (transformationRule
			ifNotNil: [ transformationRule asString ])
	} asDictionary.
]

{ #category : #accessing }
DeprecationModel >> message [

	^ message
]

{ #category : #accessing }
DeprecationModel >> message: anObject [

	message := anObject
]

{ #category : #accessing }
DeprecationModel >> transformationRule [

	^ transformationRule
]

{ #category : #accessing }
DeprecationModel >> transformationRule: anObject [

	transformationRule := anObject
]
