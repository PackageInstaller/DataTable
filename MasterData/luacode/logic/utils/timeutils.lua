local timeutils = {}
timeutils.MillisecondToDay = 86400000
timeutils.SecToDay = 86400
timeutils.SecToHour = 3600
timeutils.SecToMin = 60

function timeutils.getLeftTimeStr(lefttime)
  local strId = 1158
  local par = 0
  lefttime = lefttime // 1000
  if lefttime < 60 then
    strId = 1159
    par = lefttime
  elseif lefttime < 3600 then
    strId = 1160
    par = lefttime // 60
  elseif lefttime < 86400 then
    strId = 1159
    par = lefttime // 3600
  else
    strId = 1158
    par = lefttime // 3600
  end
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(strId).msgTextID
  str = TextManager.GetText(str)
  if strId == 1158 then
    local day = par // 24
    local h = par % 24
    str = string.gsub(str, "%$parameter1%$", day)
    str = string.gsub(str, "%$parameter2%$", h)
  else
    str = string.gsub(str, "%$parameter1%$", par)
  end
  return str
end

function timeutils.GetConfigFormatTimeStamp(strDate)
  local _, _, y, m, d, _hour, _min, _sec = string.find(strDate, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
  local timestamp = os.time({
    year = y,
    month = m,
    day = d,
    hour = _hour,
    min = _min,
    sec = _sec
  })
  return timestamp * 1000
end

return timeutils
