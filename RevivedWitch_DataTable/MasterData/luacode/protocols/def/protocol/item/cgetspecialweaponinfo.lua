-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cgetspecialweaponinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetSpecialWeaponInfo = dataclass("CGetSpecialWeaponInfo", require("framework.net.protocol"))
CGetSpecialWeaponInfo.ProtocolType = 1254
CGetSpecialWeaponInfo.MaxSize = 65535
CGetSpecialWeaponInfo.roleId = 0
CGetSpecialWeaponInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetSpecialWeaponInfo
  ((CGetSpecialWeaponInfo.super).Ctor)(self, client)
end

CGetSpecialWeaponInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  return true
end

CGetSpecialWeaponInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetSpecialWeaponInfo

