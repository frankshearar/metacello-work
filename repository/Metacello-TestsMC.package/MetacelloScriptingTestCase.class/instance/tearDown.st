running
tearDown
    super tearDown.
    self tearDownPackages.
    self tearDownRepositories.
    MetacelloProjectRegistration registry: projectRegistry.
    MetacelloProjectRegistration projectSpecRegistry: projectSpecRegistry