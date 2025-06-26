-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/beanmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Bean = class("Bean")
Bean.Ctor = function(self, data)
  -- function num : 0_0 , upvalues : _ENV
  self._data = readonly_table(data)
end

Bean.GetAllIds = function(self)
  -- function num : 0_1
  if self._data then
    return (self._data).AllIds
  end
end

Bean.GetRecorder = function(self, id)
  -- function num : 0_2
  if self._data and ((self._data).Data)[id] then
    return ((self._data).Data)[id]
  end
end

Bean.GetRawRecorder = function(self, id)
  -- function num : 0_3
  return ((self._data).Data)[id]
end

Bean.GetRecorderByValue = function(self, name, value)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs((self._data).AllIds) do
    if (((self._data).Data)[v])[name] == value then
      return ((self._data).Data)[v]
    end
  end
end

local BeanManager = {}
local _tableInstance = {}
local MakeTableValue = function(tablename)
  -- function num : 0_5 , upvalues : _ENV, Bean, _tableInstance
  local data = require("data.exceldata." .. tablename)
  local bean = (Bean.Create)(data)
  _tableInstance[tablename] = bean
end

BeanManager.GetTableByName = function(tablename)
  -- function num : 0_6 , upvalues : _tableInstance, MakeTableValue
  if not _tableInstance[tablename] then
    MakeTableValue(tablename)
  end
  return _tableInstance[tablename]
end

BeanManager.GetTableByNameWithLanguageImpl = nil
BeanManager.GetTableByNameWithLanguage = function(tablename)
  -- function num : 0_7 , upvalues : BeanManager, _ENV
  if BeanManager.GetTableByNameWithLanguageImpl == nil then
    if SdkManager.IsOverseas then
      local channelName = (SdkManager.GetChannelName)()
      if channelName == "en" then
        BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_0 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input .. "_overseas_en")
  end

      else
        if channelName == "kr" then
          BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_1 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input .. "_overseas_kr")
  end

        else
          if channelName == "jp" then
            BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_2 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input .. "_overseas_jp")
  end

          else
            if channelName == "none" then
              BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_3 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input)
  end

            else
              LogError("BeanManager.GetTableByNameWithLanguage", "The channelName is invalid value: " .. tostring(channelName))
              BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_4 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input)
  end

            end
          end
        end
      end
    else
      do
        BeanManager.GetTableByNameWithLanguageImpl = function(input)
    -- function num : 0_7_5 , upvalues : BeanManager
    return (BeanManager.GetTableByName)(input)
  end

        return (BeanManager.GetTableByNameWithLanguageImpl)(tablename)
      end
    end
  end
end

return BeanManager

