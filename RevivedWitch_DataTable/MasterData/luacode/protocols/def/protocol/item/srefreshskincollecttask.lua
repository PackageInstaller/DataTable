-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/srefreshskincollecttask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshSkinCollectTask = dataclass("SRefreshSkinCollectTask", require("framework.net.protocol"))
SRefreshSkinCollectTask.ProtocolType = 1270
SRefreshSkinCollectTask.MaxSize = 65535
SRefreshSkinCollectTask.TO_FINISH = 0
SRefreshSkinCollectTask.TO_FETCH = 1
SRefreshSkinCollectTask.FETCHED = 2
SRefreshSkinCollectTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshSkinCollectTask
  ((SRefreshSkinCollectTask.super).Ctor)(self, client)
  self.tasks = {}
end

SRefreshSkinCollectTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.tasks)) then
    return false
  end
  for key,value in pairs(self.tasks) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  return true
end

SRefreshSkinCollectTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.tasks)[key] = value
  end
  return ret
end

return SRefreshSkinCollectTask

