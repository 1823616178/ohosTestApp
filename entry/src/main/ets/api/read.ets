import { requestUtils } from '../utils/request'

const http = new requestUtils()
/**
 * 获取图书导航栏目录
 */
export const getBookNavList = (data) => {
  return http.request({
    url: "/bookApi/selectBookPartListAndIsExist",
    method: "POST",
    params: data
  })
}
/***
 * 获取图书内容
 */
export const selectBookContentFileInfo = (data) => {
  return http.request({
    url: "/bookApi/selectBookContentFileInfo",
    method: "POST",
    params: data
  })
}