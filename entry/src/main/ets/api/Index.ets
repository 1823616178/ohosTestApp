import { requestUtils } from '../utils/request'

const http = new requestUtils()
/***
 * 获取图书列表
 */
export const getBookList = (data) => {
  return http.request({
    url: "/bookApi/selectBookPropertiesList",
    method: "POST",
    data: data
  })
}