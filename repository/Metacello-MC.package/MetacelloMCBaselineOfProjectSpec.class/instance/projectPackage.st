accessing
projectPackage
    projectPackage
        ifNil: [ 
            | cName |
            cName := self className.
            cName ifNil: [ ^ nil ].
            projectPackage := self project packageSpec.
            projectPackage name: cName.
            self getFile ifNotNil: [ projectPackage file: self file ].
            self getRepositories
                do: [ :repoSpec | 
                    versionString isEmptyOrNil
                        ifTrue: [ projectPackage repositories: self getRepositories ]
                        ifFalse: [ 
                            projectPackage
                                repository:
                                    ((repoSpec createRepository projectVersion: self versionString) asRepositorySpecFor: self project) ] ] ].
    ^ projectPackage