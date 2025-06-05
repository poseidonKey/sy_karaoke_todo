import 'package:go_router/go_router.dart';
import 'package:sy_karaoke_todo/sqlite_drift/screens/category_screen.dart';
import 'package:sy_karaoke_todo/sqlite_drift/screens/item_screen.dart';

import '../sqlite_general/screens/sqlite_category_screen.dart';
import '../sqlite_general/screens/sqlite_items_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/category', builder: (_, __) => const CategoryScreen()),
    GoRoute(
      path: '/items/:categoryId',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['categoryId']!);
        return ItemScreen(categoryId: id);
      },
    ),
    GoRoute(
      // path: '/sqlite_categories',
      path: '/',
      builder: (context, state) => const SqliteCategoryScreen(),
    ),
    GoRoute(
      path: '/sqlite_items/:categoryId',
      builder: (context, state) {
        final categoryId = int.parse(state.pathParameters['categoryId']!);
        return SqliteItemScreen(categoryId: categoryId);
      },
    ),
  ],
);
