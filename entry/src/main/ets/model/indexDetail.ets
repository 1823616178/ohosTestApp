export interface bookDetailModel {
  searchValue?: any;
  createBy?: string;
  createTime?: string;
  updateBy?: string;
  updateTime?: string;
  remark?: any;
  rid?: string;
  sourceId?: string;
  categoryType?: string;
  classificationCode?: string;
  primaryClassificationCode?: any;
  secondaryClassificationCode?: any;
  title?: string;
  titleIndex?: string;
  otherTitle?: any;
  bookType?: string;
  author?: string;
  publisher?: string;
  publishDate?: string;
  publishPlace?: string;
  collectionPlace?: string;
  isbn?: any;
  filePath?: string;
  description?: string;
  topicWord?: any;
  languageType?: string;
  readType?: any;
  totalPages?: any;
  taskYear?: string;
  publishYear?: any;
  isTop?: string;
  isRelease?: string;
  isHot?: string;
  clickNum?: number;
  collectNum?: number;
  releaseDate?: any;
  orderNum?: number;
  defaultOrderNum?: number;
  dataSubmiCompany?: any;
  status?: string;
  delFlag?: string;
  editionType?: any;
  mediaType?: any;
  hotOrderNum?: number;
  constructionUnits?: string;
  volumeTotalNumber?: number;
  tableTotalNumber?: number;
  knowledgeTotalNumber?: number;
  chapterTotalNumber?: number;
  personalTotalNumber?: number;
  orgTotalNumber?: number;
  eventTotalNumber?: number;
  geographicalTotalNumber?: number;
  productTotalNumber?: number;
  ids?: any[];
  groundingType?: any;
  content?: any;
}

export class detailResultType<T> {
  code: number
  data: T
  msg: string

  constructor() {

  }
}

export interface infoDicModel {
  key: string,
  value: string,
  type?: number
}

export interface selectBookKnowledgeListBySourceIdRows {
  sourceId?: string;
  originPlace?: string;
  description?: string;
  rid?: string;
  type?: string;
  delFlag?: string;
  hasCount?: number;
  productName?: string;
  tableName?: string;
  originPlaceSourceType?: string;
  isRelease?: string;
  productNameIndex?: string;
  originPlaceIndex?: string;
  constructionUnits?: string;
  yield?: string;
  administrativeLevel?: string;
  sourceId_highlight?: string;
  identifier?: string;
  mergeType?: string;
  titleHas?: number;
  originPlaceIdentifier?: string;
  sourceType?: string;
  isTop?: string;
  sourceName?: string;
  isHot?: string;
}