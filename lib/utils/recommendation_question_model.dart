class Question{
  final String question;
  final List choices;

  const Question({required this.question,required this.choices});

  static List<Question> data = [
    const Question(
      question: "What is your favorite cuisine?",
      choices: ['Italian', 'Mexican', 'Asian', 'Middle Eastern'],
    ),
    const Question(
      question: "Do you have any dietary restrictions or preferences?",
      choices: ['Vegetarian', 'Vegan', 'Gluten-free', 'No specific preferences'],
    ),
    const Question(
      question: "How do you feel about spicy food?",
      choices: ['Mild', 'Medium', 'Hot', 'Prefer non-spicy'],
    ),
    const Question(
      question: "What type of meal are you looking for?",
      choices: ['Breakfast', 'Lunch', 'Dinner', 'Snacks', 'Any'],
    ),
    const Question(
      question: "What is your budget range for a meal?",
      choices: ['Inexpensive', 'Moderate', 'Expensive', 'No specific budget'],
    ),
    const Question(
      question: "Are you aiming for healthy food options?",
      choices: [
        'Yes, I prefer healthy options',
        'No specific health preferences',
        'I prioritize taste over health'
      ],
    ),
  ];
  
}

