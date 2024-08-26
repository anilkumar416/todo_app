import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/migrated_mocks.dart';

void main() {
  test('Will test our todo entities fields', () async {
    expect(mockMemesEntities.id, '1');
    expect(mockMemesEntities.title, 'Hello');
    expect(mockMemesEntities.isCompleted, false);
  });
}
