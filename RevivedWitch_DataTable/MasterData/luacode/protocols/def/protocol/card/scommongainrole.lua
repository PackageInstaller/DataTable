-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/scommongainrole.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCommonGainRole = dataclass("SCommonGainRole", require("framework.net.protocol"))
SCommonGainRole.ProtocolType = 1528
SCommonGainRole.MaxSize = 65535
SCommonGainRole.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCommonGainRole
  ((SCommonGainRole.super).Ctor)(self, client)
  self.roles = {}
  self.crystals = {}
  self.items = {}
end

SCommonGainRole.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.roles)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.roles)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.crystals)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.crystals)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.items)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.items)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SCommonGainRole.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.roles)[i] = ((require("protocols.bean.protocol.card.cardinfo")).Create)()
    if not ((self.roles)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.crystals)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.crystals)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

    (self.items)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.items)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCommonGainRole

