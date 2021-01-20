class Section {
  final List<TopicData> topics;
  final String sectionTitle;

  Section(this.topics, this.sectionTitle);
}

enum Filestype {
  Video,
  Pdf,
  Doc,
}

class TopicData {
  final Filestype data;
  final String title;
  final String metaData;

  TopicData(this.data, this.title, this.metaData);
}
