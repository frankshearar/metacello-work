tests
testIssue47
    "load with no errors"

    Metacello new
        configuration: 'Issue32';
        version: '1.0.0';
        repository: 'dictionary://Metacello_Configuration_Test_Repository';
        silently;
        load.
    self assert: (Smalltalk at: #'Metacello_Configuration_Test_POST_DoIt_Result').
    self assert: (Smalltalk at: #'Metacello_Configuration_Test_DoIt_Result').
    self
        validateExpectedConfigurationClassName: 'ConfigurationOfIssue32'
        expectedConfigurationVersion: '1.0.0'
        expectedConfigurationRepository: 'dictionary://Metacello_Configuration_Test_Repository'
        expectedBaselineClassName: 'BaselineOfIssue32'
        expectedBaselineVersion: 'baseline'
        expectedBaselineRepository: 'dictionary://Metacello_External_Test_Repository'