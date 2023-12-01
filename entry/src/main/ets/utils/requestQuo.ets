import http from '@ohos.net.http'

export class HttpUtils {
  private url: string
  private method: http.RequestMethod
  private header: Object

  constructor(option: {
    url: string,
    method: http.RequestMethod,
    header: Object
  }) {
    this.url = option.url
    this.method = option.method
    this.header = option.header
  }

  public static async Request(options: {
    url: string,
    method: http.RequestMethod,
    header: Object
  }) {
    const httpUtil = new HttpUtils(options);
    return await httpUtil.RequestUtils();
  }

  private RequestUtils() {
    return new Promise(async (resolve, reject) => {
      let service = http.createHttp()
      service.request(this.url, {
        header: this.header || {
          'Content-Type': 'application/json'
        },
        method: this.method || http.RequestMethod.POST,
        usingCache: true,
        priority: 1,
        readTimeout: 60000,
        expectDataType: http.HttpDataType.OBJECT,
        usingProtocol: http.HttpProtocol.HTTP2
      }).then(res => {
        resolve(res)
      }).catch(error => {
        reject(error)
      })
    })
  }

  private ResponseUtils() {
    return new Promise(async (resolve, reject) => {

    })
  }
}