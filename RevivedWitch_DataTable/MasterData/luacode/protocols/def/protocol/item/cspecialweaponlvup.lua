-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cspecialweaponlvup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSpecialWeaponlvUp = dataclass("CSpecialWeaponlvUp", require("framework.net.protocol"))
CSpecialWeaponlvUp.ProtocolType = 1256
CSpecialWeaponlvUp.MaxSize = 65535
CSpecialWeaponlvUp.roleId = 0
CSpecialWeaponlvUp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSpecialWeaponlvUp
  ((CSpecialWeaponlvUp.super).Ctor)(self, client)
end

CSpecialWeaponlvUp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CSpecialWeaponlvUp.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSpecialWeaponlvUp

