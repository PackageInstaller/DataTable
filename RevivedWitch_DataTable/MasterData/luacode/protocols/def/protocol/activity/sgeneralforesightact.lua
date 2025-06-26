-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgeneralforesightact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGeneralForesightAct = dataclass("SGeneralForesightAct", require("framework.net.protocol"))
SGeneralForesightAct.ProtocolType = 2656
SGeneralForesightAct.MaxSize = 65535
SGeneralForesightAct.activityId = 0
SGeneralForesightAct.curLeftTime = 0
SGeneralForesightAct.actLeftTime = 0
SGeneralForesightAct.unlockedTimes = 0
SGeneralForesightAct.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGeneralForesightAct, _ENV
  ((SGeneralForesightAct.super).Ctor)(self, client)
  self.receiveAward = {}
  self.foresightGoodInfo = ((require("protocols.bean.protocol.shop.foresightgoodinfo")).Create)()
end

SGeneralForesightAct.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.curLeftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.actLeftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlockedTimes) then
    return false
  end
  local length = (table.slen)(self.receiveAward)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.receiveAward)[i]) then
      return false
    end
  end
  if not (self.foresightGoodInfo):Marshal(buffer) then
    return false
  end
  return true
end

SGeneralForesightAct.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
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
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  if not (self.foresightGoodInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SGeneralForesightAct

