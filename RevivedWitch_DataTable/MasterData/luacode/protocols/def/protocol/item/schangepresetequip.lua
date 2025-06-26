-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/schangepresetequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangePreSetEquip = dataclass("SChangePreSetEquip", require("framework.net.protocol"))
SChangePreSetEquip.ProtocolType = 1263
SChangePreSetEquip.MaxSize = 65535
SChangePreSetEquip.roleId = 0
SChangePreSetEquip.equipType = 0
SChangePreSetEquip.equipKey = 0
SChangePreSetEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangePreSetEquip
  ((SChangePreSetEquip.super).Ctor)(self, client)
end

SChangePreSetEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  return true
end

SChangePreSetEquip.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangePreSetEquip

