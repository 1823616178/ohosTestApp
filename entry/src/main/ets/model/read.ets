export interface bookNavList {
  extent?: string;
  sourceId?: string;
  partTypeCode?: string;
  startPageNumber?: string;
  orderNum?: number;
  remark?: string;
  delFlag?: string;
  rid?: string;
  content?: string;
  partName?: string;
  productName?: string;
  tableNumber?: string;
  startFileName?: string;
  usercReadHistoryList?: string;
  children?: bookNavList[];
  updateBy?: string;
  endFileNum?: number;
  parentPartName?: string;
  eventName?: string;
  geographicalName?: string;
  partType?: string;
  identifier?: string;
  organizationName?: string;
  parentRid?: string;
  endFileName?: string;
  filePath?: string;
  updateTime?: string;
  params?: any;
  startFileNum?: number;
  volume?: string;
  createBy?: string;
  contentTxt?: string;
  createTime?: string;
  personalName?: string;
  sourceName?: string;
  searchValue?: string;
  status?: string;
}


/*FilePathArray*/
export class filePathArray {
  fileName: string;
  pageNumber: number;
  orderNumber: number;
  filePath: string;
  type: string;
  content: string;
}

/**
 * 图书内容模型
 */
export class bookListModel {
  sourceId: string;
  extent: string;
  identifier: string;
  eventNumber: number;
  geographicalNumber: number;
  parentRid: string;
  orderNum: number;
  bookAbstract: string;
  personalNumber: number;
  productNumber: number;
  type: string;
  title: string;
  startFileNum: number;
  tableNumber: string;
  readModel: string;
  endFileNum: number;
  filePathArray: filePathArray[];
  orgNumber: number;
}
