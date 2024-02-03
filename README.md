[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-bloc%2Fbloc%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swift-bloc/bloc)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-bloc%2Fbloc%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swift-bloc/bloc)
[![codecov](https://codecov.io/gh/swift-bloc/bloc/graph/badge.svg?token=QMDZU36A3C)](https://codecov.io/gh/swift-bloc/bloc)

# Bloc

Bloc is a Swift package designed to implement all the core concepts. It provides a set of tools, including the `BlocBase` class, which is implemented by `Cubit` and `Bloc` classes.

> [!IMPORTANT]
> This project is in alpha stage and subject to change as it evolves.

## [Documentation](https://swiftpackageindex.com/swift-bloc/bloc/main/documentation/bloc)

Check out our comprehensive documentation to get all the necessary information to start using Bloc in your project.

> [!WARNING]
> This section will be updated when there's more content available.

### Translations

We would be delighted to have your help in translating our documentation into your preferred language! Simply open a Pull Request on our repository with the link to your translated version. We are looking forward to receiving your contribution!

## Installation

Bloc can be installed using Swift Package Manager. To include it in your project, add the following dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/swift-bloc/bloc.git", from: "1.0.0")
]
```

<!--
## Usage

- TODO

This is just a simple example of what Bloc can do. Check out the documentation for more information on how to use it.
-->

## Versioning

We follow semantic versioning for this project. The version number is composed of three parts: MAJOR.MINOR.PATCH.

- MAJOR version: Increments when there are incompatible changes and breaking changes. These changes may require updates to existing code and could potentially break backward compatibility.

- MINOR version: Increments when new features or enhancements are added in a backward-compatible manner. It may include improvements, additions, or modifications to existing functionality.

- The PATCH version includes bug fixes, patches, and safe modifications that address issues, bugs, or vulnerabilities without disrupting existing functionality. It may also include new features, but they must be implemented carefully to avoid breaking changes or compatibility issues.

It is recommended to review the release notes for each version to understand the specific changes and updates made in that particular release.

## Contributing

If you find a bug or have an idea for a new feature, please open an issue or  submit a pull request. We welcome contributions from the community!