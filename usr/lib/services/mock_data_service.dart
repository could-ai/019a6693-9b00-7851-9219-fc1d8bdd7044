import '../models/poet.dart';
import '../models/diwan.dart';
import '../models/poem.dart';

class MockDataService {
  // Mock poets data
  static List<Poet> getMockPoets() {
    return [
      Poet(
        id: '1',
        name: 'أحمد شوقي',
        bio: 'أمير الشعراء، شاعر مصري عظيم',
        joinedDate: DateTime(2023, 1, 15),
        isVerified: true,
      ),
      Poet(
        id: '2',
        name: 'نزار قباني',
        bio: 'شاعر سوري معروف بشعر الحب والرومانسية',
        joinedDate: DateTime(2023, 2, 20),
        isVerified: true,
      ),
      Poet(
        id: '3',
        name: 'محمود درويش',
        bio: 'شاعر فلسطيني ومن أهم شعراء المقاومة',
        joinedDate: DateTime(2023, 3, 10),
        isVerified: true,
      ),
    ];
  }

  // Mock diwans data
  static List<Diwan> getMockDiwans() {
    return [
      Diwan(
        id: '1',
        poetId: '1',
        poetName: 'أحمد شوقي',
        title: 'الشوقيات',
        description: 'ديوان يضم أجمل قصائد أمير الشعراء',
        createdAt: DateTime(2023, 1, 20),
        poemsCount: 5,
        isApproved: true,
      ),
      Diwan(
        id: '2',
        poetId: '2',
        poetName: 'نزار قباني',
        title: 'قصائد حب',
        description: 'ديوان من أجمل قصائد الحب والرومانسية',
        createdAt: DateTime(2023, 2, 25),
        poemsCount: 8,
        isApproved: true,
      ),
      Diwan(
        id: '3',
        poetId: '3',
        poetName: 'محمود درويش',
        title: 'أوراق الزيتون',
        description: 'ديوان يتحدث عن فلسطين والوطن',
        createdAt: DateTime(2023, 3, 15),
        poemsCount: 6,
        isApproved: true,
      ),
      Diwan(
        id: '4',
        poetId: '1',
        poetName: 'أحمد شوقي',
        title: 'دول العرب',
        description: 'قصائد عن العروبة والتاريخ',
        createdAt: DateTime(2023, 4, 5),
        poemsCount: 4,
        isApproved: true,
      ),
    ];
  }

  // Mock poems data
  static List<Poem> getMockPoems(String diwanId) {
    final allPoems = [
      // Poems for Diwan 1
      Poem(
        id: '1',
        diwanId: '1',
        poetId: '1',
        title: 'قم للمعلم',
        description: 'قصيدة عن العلم والمعلم',
        type: PoemType.pdf,
        contentUrl: 'https://example.com/poem1.pdf',
        createdAt: DateTime(2023, 1, 21),
        isApproved: true,
        views: 1500,
        likes: 245,
      ),
      Poem(
        id: '2',
        diwanId: '1',
        poetId: '1',
        title: 'ولد الهدى',
        description: 'قصيدة في مدح الرسول',
        type: PoemType.video,
        contentUrl: 'https://example.com/poem2.mp4',
        createdAt: DateTime(2023, 1, 22),
        isApproved: true,
        views: 2300,
        likes: 456,
      ),
      // Poems for Diwan 2
      Poem(
        id: '3',
        diwanId: '2',
        poetId: '2',
        title: 'قصيدة عن الحب',
        description: 'قصيدة رومانسية',
        type: PoemType.pdf,
        contentUrl: 'https://example.com/poem3.pdf',
        createdAt: DateTime(2023, 2, 26),
        isApproved: true,
        views: 1800,
        likes: 320,
      ),
      Poem(
        id: '4',
        diwanId: '2',
        poetId: '2',
        title: 'يا ست الحبايب',
        description: 'قصيدة غزل',
        type: PoemType.video,
        contentUrl: 'https://example.com/poem4.mp4',
        createdAt: DateTime(2023, 2, 27),
        isApproved: true,
        views: 3200,
        likes: 678,
      ),
      // Poems for Diwan 3
      Poem(
        id: '5',
        diwanId: '3',
        poetId: '3',
        title: 'على هذه الأرض',
        description: 'قصيدة وطنية',
        type: PoemType.pdf,
        contentUrl: 'https://example.com/poem5.pdf',
        createdAt: DateTime(2023, 3, 16),
        isApproved: true,
        views: 2700,
        likes: 534,
      ),
    ];

    return allPoems.where((poem) => poem.diwanId == diwanId).toList();
  }

  // Search functionality
  static List<Diwan> searchDiwans(String query) {
    final diwans = getMockDiwans();
    if (query.isEmpty) return diwans;
    
    return diwans.where((diwan) {
      return diwan.title.contains(query) ||
             diwan.poetName.contains(query) ||
             diwan.description.contains(query);
    }).toList();
  }

  static List<Poem> searchPoems(String query) {
    final allPoems = <Poem>[];
    for (var diwan in getMockDiwans()) {
      allPoems.addAll(getMockPoems(diwan.id));
    }
    
    if (query.isEmpty) return allPoems;
    
    return allPoems.where((poem) {
      return poem.title.contains(query) ||
             (poem.description?.contains(query) ?? false);
    }).toList();
  }
}