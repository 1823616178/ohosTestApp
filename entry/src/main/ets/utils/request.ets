import axios, { Axios, AxiosInstance, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'

const token = "eyJUeXBlIjoiSnd0IiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VyY0lkIjoiMjIiLCJleHAiOjE3MDM3MzQ5NzEsImVtYWlsIjoiIiwidXNlcm5hbWUiOiJseDE4MjM2MTYxNzgifQ.kOhxkyEIxYS0D5fJRJpy4VupTRGCz6rzHQg-mOB9YAA"

const defaultConfig: AxiosRequestConfig = {
  // 请求超时时间
  timeout: 10000,
  baseURL: "http://123.161.179.32:59573/api2",
  headers: {
    Token: token,
    Accept: "application/json, text/plain, */*",
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest"
  },
};

export class requestUtils {
  private axiosInstance: AxiosInstance = axios.create(defaultConfig);

  constructor() {
    this.RequestUtils()
    this.ResponseUtils()
  }

  /** 通用请求工具函数 */
  public request<T>(options: {
    method: string,
    url: string,
    params?: Object,
    data?: Object
  }): Promise<T> {
    const config = {
      method: options.method,
      url: options.url,
      params: options.params,
      data: options.data
    }

    // 单独处理自定义请求/响应回调
    return new Promise((resolve, reject) => {
      this.axiosInstance.request(config)
        .then((response: AxiosResponse) => {
          resolve(response.data);
        })
        .catch(error => {
          reject(error);
        });
    });
  }


  private RequestUtils() {
    this.axiosInstance.interceptors.request.use((config: InternalAxiosRequestConfig): InternalAxiosRequestConfig => {

      return config
    }, (error) => {
      Promise.reject(error)
    })
  }

  private ResponseUtils() {
    this.axiosInstance.interceptors.response.use((service: AxiosResponse): AxiosResponse => {
      return service
    })
  }
}

