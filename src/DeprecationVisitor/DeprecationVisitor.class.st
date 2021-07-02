Class {
	#name : #DeprecationVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'deprecations'
	],
	#category : #DeprecationVisitor
}

{ #category : #accessing }
DeprecationVisitor >> deprecations [
	^ deprecations
]

{ #category : #accessing }
DeprecationVisitor >> extractTransformationRuleFrom: aNode [
	| antecedent consequent |
	(aNode isMessage and: [ aNode selector = #-> ])
		ifFalse: [ ^ nil ].
		
	antecedent := aNode receiver value.
	consequent := aNode arguments first value.
	
	(antecedent isString and: [ consequent isString ])
		ifFalse: [ ^ nil ].
	
	^ TransformationRule
		antecedent: 	antecedent
		consequent: consequent.
]

{ #category : #accessing }
DeprecationVisitor >> initialize [
	super initialize.
	deprecations := OrderedCollection new.
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecated: aMessageNode [
	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecatedOnIn: aMessageNode [
	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		date: aMessageNode arguments second evaluate;
		version: aMessageNode arguments third value;
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecatedOnInTransformWith: aMessageNode [
	| ruleNode |
	ruleNode := aMessageNode arguments fourth.

	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		date: aMessageNode arguments second evaluate;
		version: aMessageNode arguments third value;
		transformationRule: (self extractTransformationRuleFrom: ruleNode);
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecatedOnInTransformWithWhen: aMessageNode [
	| ruleNode |
	ruleNode := aMessageNode arguments fourth.

	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		date: aMessageNode arguments second evaluate;
		version: aMessageNode arguments third value;
		transformationRule: (self extractTransformationRuleFrom: ruleNode);
		condition: aMessageNode arguments fifth evaluate;
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecatedTransformWith: aMessageNode [
	| ruleNode |
	ruleNode := aMessageNode arguments second.

	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		transformationRule: (self extractTransformationRuleFrom: ruleNode);
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitDeprecatedTransformWithWhen: aMessageNode [
	| ruleNode |
	ruleNode := aMessageNode arguments second.

	deprecations add: (DeprecationModel new
		message: aMessageNode arguments first value;
		transformationRule: (self extractTransformationRuleFrom: ruleNode);
		condition: aMessageNode arguments third evaluate;
		yourself).
]

{ #category : #accessing }
DeprecationVisitor >> visitMessageNode: aMessageNode [
	| options |
	
	options := { 
		#deprecated: -> [ self visitDeprecated: aMessageNode ] .
		#deprecated:on:in: -> [ self visitDeprecatedOnIn: aMessageNode ] .
		#deprecated:on:in:transformWith: -> [ self visitDeprecatedOnInTransformWith: aMessageNode ] .
		#deprecated:on:in:transformWith:when: -> [ self visitDeprecatedOnInTransformWithWhen: aMessageNode ] .
		#deprecated:transformWith: -> [ self visitDeprecatedTransformWith: aMessageNode ] .
		#deprecated:transformWith:when: -> [ self visitDeprecatedTransformWithWhen: aMessageNode ]
	} asDictionary.
	
	options at: aMessageNode selector
		ifPresent: [ :aBlock | aBlock value ].
		
	super visitMessageNode: aMessageNode.
]
