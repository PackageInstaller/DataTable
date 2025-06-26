-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/luanotificationcenter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaNotificationCenter = {}
local _nameTable = {}
local _observerEventMap = {}
LuaNotificationCenter.AddObserver = function(observer, handleFunc, name, object)
  -- function num : 0_0 , upvalues : _ENV, _nameTable, _observerEventMap
  if not observer or not name or not handleFunc then
    LogError("LuaNotificationCenter", "Invaild argument in LuaNotificationCenter.AddObserver")
    return 
  end
  local record = {}
  record.observer = observer
  record.handleFunc = handleFunc
  record.name = name
  record.object = object
  record.valid = true
  if not _nameTable[name] then
    _nameTable[name] = {}
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_nameTable[name])[#_nameTable[name] + 1] = record
  if not _observerEventMap[observer] then
    _observerEventMap[observer] = {}
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (_observerEventMap[observer])[name] = true
end

local update_notification = {name = nil, object = nil, userInfo = nil}
LuaNotificationCenter.PostNotification = function(name, object, userInfo)
  -- function num : 0_1 , upvalues : _ENV, _nameTable, update_notification
  if not name then
    LogError("LuaNotificationCenter", "Invaild argument in LuaNotificationCenter.PostNotification")
    return 
  end
  if not _nameTable[name] then
    return 
  end
  if name == Common.n_Update or name == Common.n_LateUpdate then
    update_notification.name = name
    update_notification.object = object
    update_notification.userInfo = userInfo
    local tbl = _nameTable[name]
    for _,record in ipairs(tbl) do
      if (record.object == nil or record.object == object) and record.valid then
        (record.handleFunc)(record.observer, update_notification)
      end
    end
  else
    do
      local tbl = _nameTable[name]
      for _,record in ipairs(tbl) do
        if (record.object == nil or record.object == object) and record.valid then
          local notification = {}
          notification.name = name
          notification.object = object
          notification.userInfo = userInfo
          ;
          (record.handleFunc)(record.observer, notification)
        end
      end
    end
  end
end

LuaNotificationCenter.RemoveObserver = function(observer, name, object)
  -- function num : 0_2 , upvalues : _ENV, _observerEventMap, _nameTable
  if not observer then
    LogError("LuaNotificationCenter", "Invaild argument in LuaNotificationCenter.RemoveObserver")
    return 
  end
  if not _observerEventMap[observer] then
    return 
  end
  if not name then
    local eventMap = {}
    for eventName,_ in pairs(_observerEventMap[observer]) do
      local recordTable = _nameTable[eventName]
      local t = {}
      for _,record in ipairs(recordTable) do
        if observer == record.observer then
          if record.object == nil or record.object == object then
            record.valid = false
          else
            t[#t + 1] = record
            eventMap[eventName] = true
          end
        else
          t[#t + 1] = record
        end
      end
      _nameTable[eventName] = t
    end
    if (table.nums)(eventMap) == 0 then
      _observerEventMap[observer] = nil
    else
      _observerEventMap[observer] = eventMap
    end
  else
    do
      local recordTable = _nameTable[name]
      if recordTable then
        local t = {}
        local remObserver = true
        for _,record in ipairs(recordTable) do
          if observer == record.observer then
            if record.object == nil or record.object == object then
              record.valid = false
            else
              t[#t + 1] = record
              remObserver = false
            end
          else
            t[#t + 1] = record
          end
        end
        _nameTable[name] = t
      end
      do
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R4 in 'UnsetPending'

        if remObserver then
          (_observerEventMap[observer])[name] = nil
        end
      end
    end
  end
end

return LuaNotificationCenter

