local BM_Lines = class("BM_Lines")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CSountLines_Skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlines_skin")

function BM_Lines:Ctor()
end

function BM_Lines:GetLines(roleID, tableKey, index)
  LogError("BM_Lines", "没写")
  return ""
end

function BM_Lines:GetLines2(roleID, fashionID, tableKey, index)
  roleID = roleID or -1
  fashionID = fashionID or -1
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
      index = math.random(#linesValue)
    end
    if index > #linesValue then
      LogError("BM_Lines", "character id " .. record.id .. " " .. tableKey .. " has no lines id.")
      return nil
    end
    linesValue = linesValue[index]
  end
  LogInfo("BM_Lines", "Get lines " .. tableKey .. " index " .. (index or ""))
  return TextManager.GetText(linesValue)
end

return BM_Lines
