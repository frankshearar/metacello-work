project lookup
lookupProjectSpecFor: aProjectSpec
    | registration loadedSpec |
    registration := MetacelloProjectRegistration
        registrationForProjectSpec: aProjectSpec
        ifAbsent: [ :new | new ]
        ifPresent: [ :existing :new | 
            (existing hasLoadConflicts: new)
                ifTrue: [ 
                    ((existing canUpgradeTo: new)
                        ifTrue: [ MetacelloAllowProjectUpgrade new ]
                        ifFalse: [ 
                            (existing canDowngradeTo: new)
                                ifTrue: [ MetacelloAllowProjectDowngrade new ]
                                ifFalse: [ MetacelloAllowConflictingProjectUpgrade new ] ])
                        existingProjectRegistration: existing;
                        newProjectRegistration: new;
                        signal ]
                ifFalse: [ new ] ].
    ^ registration lookupSpec: aProjectSpec