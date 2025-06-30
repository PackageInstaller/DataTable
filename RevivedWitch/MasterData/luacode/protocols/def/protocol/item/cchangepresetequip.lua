-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cchangepresetequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangePreSetEquip = dataclass("CChangePreSetEquip", require("framework.net.protocol"))
CChangePreSetEquip.ProtocolType = 1262
CChangePreSetEquip.MaxSize = 65535
CChangePreSetEquip.roleId = 0
CChangePreSetEquip.equipType = 0
CChangePreSetEquip.equipKey = 0
CChangePreSetEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangePreSetEquip
  ((CChangePreSetEquip.super).Ctor)(self, client)
end

CChangePreSetEquip.Marshal = function(self, buffer)
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

CChangePreSetEquip.Unmarshal = function(self, buffer)
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

return CChangePreSetEquip

