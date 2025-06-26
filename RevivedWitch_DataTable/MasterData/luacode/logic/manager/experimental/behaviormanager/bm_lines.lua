-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_lines.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Lines = class("BM_Lines")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CSountLines_Skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundlines_skin")
BM_Lines.Ctor = function(self)
  -- function num : 0_0
end

BM_Lines.GetLines = function(self, roleID, tableKey, index)
  -- function num : 0_1 , upvalues : _ENV
  LogError("BM_Lines", "没写")
  return ""
end

BM_Lines.GetLines2 = function(self, roleID, fashionID, tableKey, index)
  -- function num : 0_2 , upvalues : CSountLines_Skin, CSoundLines, _ENV
  if not roleID then
    roleID = -1
  end
  if not fashionID then
    fashionID = -1
  end
  local recordFashion = CSountLines_Skin:GetRecorder(fashionID)
  local recordRole = CSoundLines:GetRecorder(roleID)
  local record = recordFashion or recordRole
  if record == nil then
    return nil
  end
  if tableKey == nil then
    LogError("BM_Voice", "The Play2() func arg tableKey is nil.")
    return nil
  end
  local linesValue = record[tableKey]
  if type(linesValue) == "table" then
    if #linesValue == 0 then
      LogError("BM_Lines", "The character id " .. record.id .. " " .. tableKey .. " index error.")
      return nil
    end
    if index == nil or index < 0 then
      index = (math.random)(#linesValue)
    end
    if #linesValue < index then
      LogError("BM_Lines", "character id " .. record.id .. " " .. tableKey .. " has no lines id.")
      return nil
    end
    linesValue = linesValue[index]
  end
  LogInfo("BM_Lines", "Get lines " .. tableKey .. " index " .. (index or ""))
  return (TextManager.GetText)(linesValue)
end

return BM_Lines

