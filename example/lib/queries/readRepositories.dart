String logIn = """
mutation LogInMutation(\$email: String!, \$password: String!) {
  login(email: \$email, password: \$password) {
    token
    user {
      id
      email
      firstName
      lastName
    }
  }
}
""".replaceAll('\n', ' ');
