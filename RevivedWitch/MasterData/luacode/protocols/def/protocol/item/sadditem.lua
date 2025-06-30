-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sadditem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddItem = dataclass("SAddItem", require("framework.net.protocol"))
SAddItem.ProtocolType = 1202
SAddItem.MaxSize = 65535
SAddItem.bagType = 0
SAddItem.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddItem
  ((SAddItem.super).Ctor)(self, client)
  self.data = {}
end

SAddItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bagType) then
    return false
  end
  local length = (table.slen)(self.data)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.data)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SAddItem.Unmarshal = function(self, buffer)
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

    (self.data)[i] = ((require("protocols.bean.protocol.item.beans.item")).Create)()
    if not ((self.data)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAddItem

