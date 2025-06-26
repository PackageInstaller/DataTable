-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/utils/timeutils.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local timeutils = {}
timeutils.MillisecondToDay = 86400000
timeutils.SecToDay = 86400
timeutils.SecToHour = 3600
timeutils.SecToMin = 60
timeutils.getLeftTimeStr = function(lefttime)
  -- function num : 0_0 , upvalues : _ENV
  local strId = 1158
  local par = 0
  lefttime = lefttime // 1000
  if lefttime < 60 then
    strId = 1159
    par = lefttime
  else
    if lefttime < 3600 then
      strId = 1160
      par = lefttime // 60
    else
      if lefttime < 86400 then
        strId = 1159
        par = lefttime // 3600
      else
        strId = 1158
        par = lefttime // 3600
      end
    end
  end
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(strId)).msgTextID
  str = (TextManager.GetText)(str)
  if strId == 1158 then
    local day = par // 24
    local h = par % 24
    str = (string.gsub)(str, "%$parameter1%$", day)
    str = (string.gsub)(str, "%$parameter2%$", h)
  else
    do
      str = (string.gsub)(str, "%$parameter1%$", par)
      return str
    end
  end
end

timeutils.GetConfigFormatTimeStamp = function(strDate)
  -- function num : 0_1 , upvalues : _ENV
  local _, _, y, m, d, _hour, _min, _sec = (string.find)(strDate, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
  local timestamp = (os.time)({year = y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
  return timestamp * 1000
end

return timeutils

