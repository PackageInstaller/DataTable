-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/cbuyoptionalitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyOptionalItem = dataclass("CBuyOptionalItem", require("framework.net.protocol"))
CBuyOptionalItem.ProtocolType = 3912
CBuyOptionalItem.MaxSize = 65535
CBuyOptionalItem.WaitProtocol = "protocol.notify.scancelloading"
CBuyOptionalItem.goodId = 0
CBuyOptionalItem.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyOptionalItem
  ((CBuyOptionalItem.super).Ctor)(self, client)
  self.option = {}
end

CBuyOptionalItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  local length = (table.slen)(self.option)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.option)[i]) then
      return false
    end
  end
  return true
end

CBuyOptionalItem.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
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
  return ret
end

return CBuyOptionalItem

