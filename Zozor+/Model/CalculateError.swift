
/// All possibles error of the calculate class
enum CalculateError: Error {
    case expressionIncorrect, expressionIncorrectStartNewOperation, cantAddOperator, cantDivideBy0, cantAddDecimalSeparator, numberIsTooBig, resultIsTooBig
}
