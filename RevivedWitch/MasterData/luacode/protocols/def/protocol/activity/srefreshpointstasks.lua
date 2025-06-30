-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshpointstasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshPointsTasks = dataclass("SRefreshPointsTasks", require("framework.net.protocol"))
SRefreshPointsTasks.ProtocolType = 2440
SRefreshPointsTasks.MaxSize = 65535
SRefreshPointsTasks.activityID = 0
SRefreshPointsTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshPointsTasks
  ((SRefreshPointsTasks.super).Ctor)(self, client)
  self.tasks = {}
end

SRefreshPointsTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  local length = (table.slen)(self.tasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.tasks)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SRefreshPointsTasks.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.tasks)[i] = ((require("protocols.bean.protocol.activity.collectiontask")).Create)()
    if not ((self.tasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshPointsTasks

