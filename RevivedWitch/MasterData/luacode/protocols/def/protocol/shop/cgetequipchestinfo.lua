-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cgetequipchestinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetEquipChestInfo = dataclass("CGetEquipChestInfo", require("framework.net.protocol"))
CGetEquipChestInfo.ProtocolType = 3635
CGetEquipChestInfo.MaxSize = 65535
CGetEquipChestInfo.chestID = 0
CGetEquipChestInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetEquipChestInfo
  ((CGetEquipChestInfo.super).Ctor)(self, client)
end

CGetEquipChestInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chestID) then
    return false
  end
  return true
end

CGetEquipChestInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetEquipChestInfo

