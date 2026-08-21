-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/srefreshalchemy.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshAlchemy = dataclass("SRefreshAlchemy", require("framework.net.protocol"))
SRefreshAlchemy.ProtocolType = 2354
SRefreshAlchemy.MaxSize = 65535
SRefreshAlchemy.effect = 0
SRefreshAlchemy.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshAlchemy, _ENV
  ((SRefreshAlchemy.super).Ctor)(self, client)
  self.alchemy = ((require("protocols.bean.protocol.yard.alchemy")).Create)()
  self.mainResult = {}
  self.secondResult = {}
end

SRefreshAlchemy.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  if not (self.alchemy):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.mainResult)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.mainResult)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.secondResult)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.secondResult)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.effect) then
    return false
  end
  return true
end

SRefreshAlchemy.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.alchemy):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.mainResult)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.mainResult)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

    (self.secondResult)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.secondResult)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshAlchemy

