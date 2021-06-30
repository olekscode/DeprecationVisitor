Class {
	#name : #BaselineOfDeprecationVisitor,
	#superclass : #BaselineOf,
	#category : #BaselineOfDeprecationVisitor
}

{ #category : #baselines }
BaselineOfDeprecationVisitor >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'TransformationRule'
			with: [ spec repository: 'github://olekscode/TransformationRule/src' ].
			
		"Packages"
		spec 
			package: 'DeprecationVisitor' with: [ spec requires: #(TransformationRule) ];
			package: 'DeprecationVisitor-Tests' with: [ spec requires: #(#DeprecationVisitor) ] ]
]
