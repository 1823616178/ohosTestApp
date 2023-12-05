import { getBookList } from '../../../api/Index';
import { resultType, selectBookDbo, selectBookQuery } from '../../../model/Index';

/**
 * 上拉加载
 * @param model
 * @param query
 */
export async function loadMoreData(model: selectBookDbo[], query: selectBookQuery) {
  if (query.page) {
    query.page += 1
    await getBookList(query).then((res: resultType) => {
      if (model.length < res.data.total) {
        let list = res.data.rows
        model.push(...list)
      }
    })
  }
}
/**
 * 下拉刷新
 * @param model
 * @param query
 */
export async function pullTopData(model: selectBookDbo[], query: selectBookQuery) {
  if (query.page) {
    query.page = 1
    await getBookList(query).then((res: resultType) => {
      model = res.data.rows
    })
  }
}