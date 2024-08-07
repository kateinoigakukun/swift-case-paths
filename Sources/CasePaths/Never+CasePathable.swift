extension Never: CasePathable, CasePathIterable {
  public struct AllCasePaths: CasePathReflectable, Sendable {
    public subscript(root: Never) -> PartialOptionalKeyPath<Never> {
      \.never
    }
  }

  public static var allCasePaths: AllCasePaths {
    AllCasePaths()
  }
}

extension Case where Value: CasePathable {
  /// A case path that can never embed or extract a value.
  ///
  /// This property can chain any case path into a `Never` value, which, as an uninhabited type,
  /// cannot be embedded nor extracted from an enum.
  public var never: Case<Never> {
    get {
      @Sendable func absurd<T>(_: Never) -> T {}
      return Case<Never>(embed: absurd, extract: { (_: Value) in nil })
    }
    set {}
  }
}

extension Case {
  @available(*, deprecated, message: "This enum must be '@CasePathable' to enable key path syntax")
  public var never: Case<Never> {
    get {
      @Sendable func absurd<T>(_: Never) -> T {}
      return Case<Never>(embed: absurd, extract: { (_: Value) in nil })
    }
    set {}
  }
}

extension Never.AllCasePaths: Sequence {
  public func makeIterator() -> some IteratorProtocol<PartialOptionalKeyPath<Never>> {
    [].makeIterator()
  }
}
