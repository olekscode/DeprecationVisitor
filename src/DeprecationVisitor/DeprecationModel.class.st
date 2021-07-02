Class {
	#name : #DeprecationModel,
	#superclass : #Object,
	#instVars : [
		'message',
		'date',
		'version',
		'condition',
		'transformationRule'
	],
	#category : #DeprecationVisitor
}

{ #category : #comparing }
DeprecationModel >> = anObject [

	self class = anObject class
		ifFalse: [ ^ false ].
		
	^ message = anObject message and: [ 
		date = anObject date and: [ 
			version = anObject version and: [ 
				transformationRule = anObject transformationRule and: [ 
					condition asString = anObject condition asString ] ] ] ]
]

{ #category : #accessing }
DeprecationModel >> condition [

	^ condition
]

{ #category : #accessing }
DeprecationModel >> condition: anObject [

	condition := anObject
]

{ #category : #accessing }
DeprecationModel >> date [

	^ date
]

{ #category : #accessing }
DeprecationModel >> date: anObject [

	date := anObject
]

{ #category : #comparing }
DeprecationModel >> hash [

	^ (((message hash
		bitXor: date hash)
			bitXor: version hash)
				bitXor: transformationRule hash)
					bitXor: condition asString hash
]

{ #category : #testing }
DeprecationModel >> isTransforming [

	^ transformationRule isNotNil
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

{ #category : #accessing }
DeprecationModel >> version [

	^ version
]

{ #category : #accessing }
DeprecationModel >> version: anObject [

	version := anObject
]
