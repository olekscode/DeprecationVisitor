# DeprecationVisitor

[![Build status](https://github.com/olekscode/DeprecationVisitor/workflows/CI/badge.svg)](https://github.com/olekscode/DeprecationVisitor/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/DeprecationVisitor/badge.svg?branch=master)](https://coveralls.io/github/olekscode/DeprecationVisitor?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/DeprecationVisitor/master/LICENSE)

A simple visitor that can collect deprecations from Pharo methods. Developed for research purposes, to analyse method deprecations in Pharo images. `DeprecationModel` is a static version of `Deprecation` which stores all the information about the deprecation such as message, date, version, etc., but does not require a dynamic execution context.

## How to install it?

To install `DeprecationVisitor`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'DeprecationVisitor';
  repository: 'github://olekscode/DeprecationVisitor/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `DeprecationVisitor` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'DeprecationVisitor'
  with: [ spec repository: 'github://olekscode/DeprecationVisitor/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

Consider that you have a deprecated method:

```Smalltalk
FFIStructure >> address
    self
        deprecated: 'Use #getHandle'
        on: '27 October 2015'
        in: 'Pharo5'
        transformWith: '`@rec address' -> '`@rec getHandle'.
	
    ^ self getHandle
```

`DeprecationVisitor` can be used to collect all deprecations from a given method:

```Smalltalk
visitor := DeprecationVisitor new.
method := FFIStructure >> #address.
method ast acceptVisitor: visitor.
visitor deprecations. "an OrderedCollection(a DeprecationModel)"
```

The collected deprecation will be equivalent to the following one:

```Smalltalk
DeprecationModel new
    message: 'Use #getHandle';
    date: '27 October 2015';
    version: 'Pharo5';
    transformationRule: (TransformationRule
        antecedent: '`@rec address'
	consequent: '`@rec getHandle').
```
