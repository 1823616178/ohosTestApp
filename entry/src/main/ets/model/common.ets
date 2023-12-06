export class resultType<T> {
  code: number
  data: T
  msg: string

  constructor() {

  }
}

/***
 * 公共参数返回值
 */
export class commonResultRows<T> {
  rows: T
  total: number

  constructor() {
  }
}

export interface commonQueryType {
  advancedRetrievalParams: advancedRetrievalParamsInf
  component: string
  label: string
  order: string
  page: number
  rows: number
  type: number
  value: string
}

export interface advancedRetrievalParamsInf {
  field: string
  keyword: string
  match: string
  relation: string
}

