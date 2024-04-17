export const FormatChineseDate = (date: Date): string => {
  const Y = date.getFullYear();
  const M = ("0" + (date.getMonth() + 1)).slice(-2);
  const D = ("0" + date.getDate()).slice(-2);
  const h = ("0" + date.getHours()).slice(-2);
  const m = ("0" + date.getMinutes()).slice(-2);
  const s = ("0" + date.getSeconds()).slice(-2);
  const formattedDate = Y + "年" + M + "月" + D + "日" + " " + h + "时" + m + "分" + s + "秒";
  return formattedDate;
};
