export interface HomeNavData {
  knowledgeCount: number;
  libraryCount: number;
  propertiesCount: number;
}

export interface resultType {
  code: number
  data: selectBookResult
  msg: string
}

export interface selectBookQuery {
  advancedRetrievalParams?: string[],
  order: string,
  page: number,
  rows: number,
  sort: string
}

export interface selectBookResult {
  rows: selectBookDbo[]
}

export interface selectBookDbo {
  sourceId?: string;
  publishDate?: string;
  titleIndex?: string;
  rid?: string;
  title?: string;
  delFlag?: string;
  tableName?: string;
  isRelease?: string;
  constructionUnits?: string;
  collectionPlace?: string;
  languageType?: string;
  filePath?: string;
  publishPlace?: string;
  categoryType?: string;
  classificationCode?: string;
  isTop?: string;
  publisher?: string;
  isHot?: string;
  bookType?: string;
  status?: string;
}

export interface swiperModel {
  url: Resource,
  title?: string,
  index?: number
}