Class {
	#name : #DeprecationVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor'
	],
	#category : #'DeprecationVisitor-Tests'
}

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecated [

	self deprecated: 'Use something else'.
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecatedOnIn [

	self
		deprecated: 'Use something else'
		on: '2 July 2021' asDate
		in: 'Pharo9'.
		
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecatedOnInTransformWith [

	self
		deprecated: 'Use something else'
		on: '2 July 2021' asDate
		in: 'Pharo9'
		transformWith: '`@rec mockDeprecatedOnInTransformWith' -> '`@rec somethingElse'.
		
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecatedOnInTransformWithWhen [

	self
		deprecated: 'Use something else'
		on: '2 July 2021' asDate
		in: 'Pharo9'
		transformWith: '`@rec mockDeprecatedOnInTransformWithWhen' -> '`@rec somethingElse'
		when: [ true ].
		
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecatedTransformWith [

	self
		deprecated: 'Use something else'
		transformWith: '`@rec mockDeprecatedTransformWith' -> '`@rec somethingElse'.
		
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockDeprecatedTransformWithWhen [

	self
		deprecated: 'Use something else'
		transformWith: '`@rec mockDeprecatedTransformWithWhen' -> '`@rec somethingElse'
		when: [ true ].
		
	^ 2 + 2
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> mockNonDeprecatedMethod [
		
	^ 2 + 2
]

{ #category : #initialization }
DeprecationVisitorTest >> setUp [ 

	super setUp.
	visitor := DeprecationVisitor new.
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecated [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		yourself.
		
	method := self class >> #mockDeprecated.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecatedOnIn [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		date: '2 July 2021' asDate;
		version: 'Pharo9';
		yourself.
		
	method := self class >> #mockDeprecatedOnIn.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecatedOnInTransformWith [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		date: '2 July 2021' asDate;
		version: 'Pharo9';
		transformationRule: (TransformationRule
			antecedent: '`@rec mockDeprecatedOnInTransformWith'
			consequent: '`@rec somethingElse');
		yourself.
		
	method := self class >> #mockDeprecatedOnInTransformWith.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecatedOnInTransformWithWhen [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		date: '2 July 2021' asDate;
		version: 'Pharo9';
		transformationRule: (TransformationRule
			antecedent: '`@rec mockDeprecatedOnInTransformWithWhen'
			consequent: '`@rec somethingElse');
		condition: '[ true ]';
		yourself.
		
	method := self class >> #mockDeprecatedOnInTransformWithWhen.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecatedTransformWith [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		transformationRule: (TransformationRule
			antecedent: '`@rec mockDeprecatedTransformWith'
			consequent: '`@rec somethingElse');
		yourself.
		
	method := self class >> #mockDeprecatedTransformWith.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitDeprecatedTransformWithWhen [
	| deprecation method |
	
	deprecation := DeprecationModel new
		message: 'Use something else';
		transformationRule: (TransformationRule
			antecedent: '`@rec mockDeprecatedTransformWithWhen'
			consequent: '`@rec somethingElse');
		condition: '[ true ]';
		yourself.
		
	method := self class >> #mockDeprecatedTransformWithWhen.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: (OrderedCollection with: deprecation).
]

{ #category : #'as yet unclassified' }
DeprecationVisitorTest >> testVisitNonDeprecatedMethod [
	| method |
		
	method := self class >> #mockNonDeprecatedMethod.
	method ast acceptVisitor: visitor.
	
	self assert: visitor deprecations equals: OrderedCollection new.
]
