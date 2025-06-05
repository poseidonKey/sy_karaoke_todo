import 'package:go_router/go_router.dart';
import 'package:sy_karaoke_todo/sqlite/screens/category_screen.dart';
import 'package:sy_karaoke_todo/sqlite/screens/item_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const CategoryScreen()),
    GoRoute(
      path: '/items/:categoryId',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['categoryId']!);
        return ItemScreen(categoryId: id);
      },
    ),
  ],
);
