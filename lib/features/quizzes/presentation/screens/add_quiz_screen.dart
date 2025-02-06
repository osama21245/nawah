import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/add_quizzes/add_quiz_cubit.dart';
import '../cubits/add_quiz_state.dart';
import '../../data/model/quiz_model.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<QuestionModel> _questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Quiz'),
      ),
      body: BlocListener<AddQuizCubit, AddQuizCubitState>(
        listener: (context, state) {
          if (state.isSuccess()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Quiz added successfully!')),
            );
            Navigator.pop(context);
          } else if (state.isFailure()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to add quiz'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Quiz Title'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Quiz Description'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ..._buildQuestionsList(),
              ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<AddQuizCubit, AddQuizCubitState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isLoading() ? null : _submitQuiz,
                    child: state.isLoading()
                        ? const CircularProgressIndicator()
                        : const Text('Submit Quiz'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildQuestionsList() {
    return _questions.asMap().entries.map((entry) {
      final index = entry.key;
      final question = entry.value;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Question ${index + 1}: ${question.questionText}'),
              const SizedBox(height: 8),
              ...question.answers.map((answer) => Text(
                    '${answer.isCorrect ? '✓' : '✗'} ${answer.answerText}',
                  )),
              TextButton(
                onPressed: () => _editQuestion(index),
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void _addQuestion() async {
    final result = await showDialog<QuestionModel>(
      context: context,
      builder: (context) => const AddQuestionDialog(),
    );
    if (result != null) {
      setState(() {
        _questions.add(result);
      });
    }
  }

  void _editQuestion(int index) async {
    final result = await showDialog<QuestionModel>(
      context: context,
      builder: (context) => AddQuestionDialog(
        initialQuestion: _questions[index],
      ),
    );
    if (result != null) {
      setState(() {
        _questions[index] = result;
      });
    }
  }

  void _submitQuiz() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_questions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one question')),
        );
        return;
      }

      final quiz = QuizModel(
        title: _titleController.text,
        description: _descriptionController.text,
        teacherId: '1', // Get this from your auth system
        questions: _questions,
      );

      context.read<AddQuizCubit>().addQuiz(quiz);
    }
  }
}

class AddQuestionDialog extends StatefulWidget {
  final QuestionModel? initialQuestion;

  const AddQuestionDialog({super.key, this.initialQuestion});

  @override
  State<AddQuestionDialog> createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final _questionController = TextEditingController();
  final List<AnswerModel> _answers = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialQuestion != null) {
      _questionController.text = widget.initialQuestion!.questionText;
      _answers.addAll(widget.initialQuestion!.answers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.initialQuestion == null ? 'Add Question' : 'Edit Question'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 16),
            ..._answers.asMap().entries.map((entry) {
              final index = entry.key;
              final answer = entry.value;
              return ListTile(
                title: Text(answer.answerText),
                leading: Checkbox(
                  value: answer.isCorrect,
                  onChanged: (value) => _updateAnswer(index, isCorrect: value!),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeAnswer(index),
                ),
              );
            }),
            TextButton(
              onPressed: _addAnswer,
              child: const Text('Add Answer'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _addAnswer() async {
    final result = await showDialog<AnswerModel>(
      context: context,
      builder: (context) => const AddAnswerDialog(),
    );
    if (result != null) {
      setState(() {
        _answers.add(result);
      });
    }
  }

  void _updateAnswer(int index, {required bool isCorrect}) {
    setState(() {
      _answers[index] = AnswerModel(
        answerText: _answers[index].answerText,
        isCorrect: isCorrect,
      );
    });
  }

  void _removeAnswer(int index) {
    setState(() {
      _answers.removeAt(index);
    });
  }

  void _submit() {
    if (_questionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a question')),
      );
      return;
    }

    if (_answers.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least 2 answers')),
      );
      return;
    }

    if (!_answers.any((answer) => answer.isCorrect)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please mark at least one correct answer')),
      );
      return;
    }

    Navigator.pop(
      context,
      QuestionModel(
        questionText: _questionController.text,
        answers: _answers,
      ),
    );
  }
}

class AddAnswerDialog extends StatefulWidget {
  const AddAnswerDialog({super.key});

  @override
  State<AddAnswerDialog> createState() => _AddAnswerDialogState();
}

class _AddAnswerDialogState extends State<AddAnswerDialog> {
  final _answerController = TextEditingController();
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Answer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(labelText: 'Answer'),
          ),
          CheckboxListTile(
            title: const Text('Correct Answer'),
            value: _isCorrect,
            onChanged: (value) => setState(() => _isCorrect = value!),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_answerController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter an answer')),
              );
              return;
            }
            Navigator.pop(
              context,
              AnswerModel(
                answerText: _answerController.text,
                isCorrect: _isCorrect,
              ),
            );
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
