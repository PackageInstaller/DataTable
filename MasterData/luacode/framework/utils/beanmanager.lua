local Bean = class("Bean")

function Bean:Ctor(data)
  self._data = readonly_table(data)
end

function Bean:GetAllIds()
  if self._data then
    return self._data.AllIds
  end
end

function Bean:GetRecorder(id)
  if self._data and self._data.Data[id] then
    return self._data.Data[id]
  end
end

function Bean:GetRawRecorder(id)
  return self._data.Data[id]
end

function Bean:GetRecorderByValue(name, value)
  for i, v in ipairs(self._data.AllIds) do
    if self._data.Data[v][name] == value then
      return self._data.Data[v]
    end
  end
end

local BeanManager = {}
local _tableInstance = {}

local function MakeTableValue(tablename)
  local data = require("data.exceldata." .. tablename)
  local bean = Bean.Create(data)
  _tableInstance[tablename] = bean
end

function BeanManager.GetTableByName(tablename)
  if not _tableInstance[tablename] then
    MakeTableValue(tablename)
  end
  return _tableInstance[tablename]
end

BeanManager.GetTableByNameWithLanguageImpl = nil

function BeanManager.GetTableByNameWithLanguage(tablename)
  if BeanManager.GetTableByNameWithLanguageImpl == nil then
    if SdkManager.IsOverseas then
      local channelName = SdkManager.GetChannelName()
      if channelName == "en" then
        function BeanManager.GetTableByNameWithLanguageImpl(input)
          return BeanManager.GetTableByName(input .. "_overseas_en")
        end
      elseif channelName == "kr" then
        function BeanManager.GetTableByNameWithLanguageImpl(input)
          return BeanManager.GetTableByName(input .. "_overseas_kr")
        end
      elseif channelName == "jp" then
        function BeanManager.GetTableByNameWithLanguageImpl(input)
          return BeanManager.GetTableByName(input .. "_overseas_jp")
        end
      elseif channelName == "none" then
        function BeanManager.GetTableByNameWithLanguageImpl(input)
          return BeanManager.GetTableByName(input)
        end
      else
        LogError("BeanManager.GetTableByNameWithLanguage", "The channelName is invalid value: " .. tostring(channelName))
        
        function BeanManager.GetTableByNameWithLanguageImpl(input)
          return BeanManager.GetTableByName(input)
        end
      end
    else
      function BeanManager.GetTableByNameWithLanguageImpl(input)
        return BeanManager.GetTableByName(input)
      end
    end
  end
  return BeanManager.GetTableByNameWithLanguageImpl(tablename)
end

return BeanManager
