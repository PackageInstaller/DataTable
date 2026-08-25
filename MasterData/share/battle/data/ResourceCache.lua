local System = require("System.System")
local DT = require("System.DataTable")
local DTSpier = require("Battle.Data.DTSpier")
local LangList = {
  "CN",
  "TW",
  "ENAI"
}
local sformat = string.format
local ResourceCache = System.NewClass("ResourceCache")

function ResourceCache:ctor(owner, isPvp, isServerBattle)
  self.owner = owner
  self.records = {}
  self.visit = {}
  self.isPvp = isPvp
  self.isServerBattle = isServerBattle
  self:InitRecordLang()
end

function ResourceCache:InitRecordLang()
  self.records.langKeys = {}
  for _, langName in ipairs(LangList) do
    self.records.langKeys[langName] = {}
  end
end

function ResourceCache:GetDataTable(cache)
  do return DTSpier.new, self end
  return DTSpier.new, self, cache
end

function ResourceCache:GetLine(fileName, key)
  if nil == fileName or nil == key then
    return
  end
  local fileRecords = self.records[fileName]
  if not fileRecords then
    fileRecords = {}
    self.records[fileName] = fileRecords
  end
  local cfgLine = fileRecords[key]
  if not cfgLine then
    local cfg = DT[fileName]
    cfgLine = table.deepclone(cfg[key])
    fileRecords[key] = cfgLine
  end
  if not self:IsVisited(fileName, key) then
    self:SetVisited(fileName, key)
    local owner = self.owner
    if owner and owner.OnVisitNewLine then
      owner:OnVisitNewLine(fileName, key, cfgLine)
    end
  end
  return cfgLine
end

function ResourceCache:SetVisited(fileName, key)
  local visitFile = self.visit[fileName]
  if not visitFile then
    visitFile = {
      [key] = true
    }
    self.visit[fileName] = visitFile
  else
    visitFile[key] = true
  end
end

function ResourceCache:IsVisited(fileName, key)
  local visitFile = self.visit[fileName]
  if not visitFile then
    return false
  end
  return visitFile[key]
end

function ResourceCache:RecordLangKeys(fileName, cfgLine)
  local savedTo = self.records.langKeys
  for _, langName in ipairs(LangList) do
    local langConfigName = sformat("Text.Text_%s_%s", fileName, langName)
    self:DeepRecordLang(cfgLine, langConfigName, savedTo[langName])
  end
end

function ResourceCache:DeepRecordLang(cfgLine, langConfigName, savedTo)
  if not cfgLine then
    return
  end
  local itemType, strArr
  for key, item in pairs(cfgLine) do
    itemType = type(item)
    if "string" == itemType then
      strArr = string.split(item, "|")
      local langKey = strArr[1]
      if #strArr >= 2 and self:IsValidLangKey(langKey) then
        local langConfig = DT[langConfigName]
        savedTo[langKey] = langConfig[langKey]
      end
    elseif "table" == itemType then
      self:DeepRecordLang(item, langConfigName, savedTo)
    end
  end
end

function ResourceCache:IsValidLangKey(key)
  local strArr = string.split(key, "_")
  return #strArr >= 3
end

return ResourceCache
