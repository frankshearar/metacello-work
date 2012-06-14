operations
performCurrentVersionTestAgainst: vrsn operator: anOperator targetVersionStatus: targetVersionStatus using: anMCLoader
    "answer true if the current state of image is to be left as is"

    | currentVersion existing new |
    vrsn ifNil: [ ^ false ].
    self useDetermineVersionForLoad
        ifTrue: [ 
            | prjct cv |
            self hasOverride
                ifTrue: [ self error: 'unexpected logic combination: useDeterminVersionForLoad & hasOverride' ].
            prjct := self projectSpec projectClassProject.
            prjct loader: anMCLoader.
            (cv := prjct currentVersion) == nil
                ifTrue: [ ^ false ].
            (targetVersionStatus includes: cv versionStatus)
                ifTrue: [ ^ cv perform: anOperator with: vrsn ].
            ^ false ].
    self hasOverride
        ifFalse: [ ^ false ].
    (currentVersion := self overrideProjectSpec versionOrNil) ifNil: [ ^ false ].
    currentVersion = vrsn
        ifTrue: [ ^ true ].
    existing := self overrideProjectSpec asProjectRegistration.
    new := self projectSpec asProjectRegistration.
    currentVersion > vrsn
        ifTrue: [ 
            "answer false if downgrade allowd"
            (MetacelloAllowProjectDowngrade new
                existingProjectRegistration: existing;
                newProjectRegistration: new;
                signal) == existing ]
        ifFalse: [ 
            "answer false if upgrade allowed"
            (MetacelloAllowConflictingProjectUpgrade new
                existingProjectRegistration: existing;
                newProjectRegistration: new;
                signal) == existing ]