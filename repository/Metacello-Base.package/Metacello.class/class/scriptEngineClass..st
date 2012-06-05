private
scriptEngineClass: loadList
    | list |
    list := OrderedCollection new.
    loadList
        do: [ :assoc | 
            Smalltalk
                at: assoc key
                ifAbsent: [ :cl | 
                    | allPresent |
                    list add: assoc value ] ].
    list notEmpty
        ifTrue: [ ConfigurationOf ensureMetacello: list ].
    ^ Smalltalk at: #'MetacelloScriptEngine'