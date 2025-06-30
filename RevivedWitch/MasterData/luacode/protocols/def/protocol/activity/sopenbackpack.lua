-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenbackpack.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenBackPack = dataclass("SOpenBackPack", require("framework.net.protocol"))
SOpenBackPack.ProtocolType = 2556
SOpenBackPack.MaxSize = 65535
SOpenBackPack.allSpirt = 0
SOpenBackPack.leftTime = 0
SOpenBackPack.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenBackPack
  ((SOpenBackPack.super).Ctor)(self, client)
  self.spirtLimit = {}
  self.goodInfo = {}
end

SOpenBackPack.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.allSpirt) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  local length = (table.slen)(self.spirtLimit)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.spirtLimit)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.goodInfo)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.goodInfo)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SOpenBackPack.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R9 in 'UnsetPending'

    (self.goodInfo)[i] = ((require("protocols.bean.protocol.activity.goodinfo")).Create)()
    if not ((self.goodInfo)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBackPack

