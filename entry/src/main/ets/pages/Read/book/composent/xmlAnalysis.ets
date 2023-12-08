import sax from '@ohos/sax'
/**
 * 解析HTML
 */
export const HtmlToObj = async (html: string) => {
  let strict = true;
  let parser = sax.parser(strict);
}