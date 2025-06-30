-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceiveaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveAward = dataclass("SReceiveAward", require("framework.net.protocol"))
SReceiveAward.ProtocolType = 2408
SReceiveAward.MaxSize = 65535
SReceiveAward.actId = 0
SReceiveAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveAward
  ((SReceiveAward.super).Ctor)(self, client)
  self.index = {}
  self.itemInfo = {}
end

SReceiveAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.actId) then
    return false
  end
  local length = (table.slen)(self.index)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.index)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.itemInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.itemInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SReceiveAward.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

    (self.itemInfo)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.itemInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SReceiveAward

