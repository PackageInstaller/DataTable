-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sequipexpup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEquipExpUp = dataclass("SEquipExpUp", require("framework.net.protocol"))
SEquipExpUp.ProtocolType = 1223
SEquipExpUp.MaxSize = 65535
SEquipExpUp.equipKey = 0
SEquipExpUp.exp = 0
SEquipExpUp.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEquipExpUp
  ((SEquipExpUp.super).Ctor)(self, client)
end

SEquipExpUp.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.exp) then
    return false
  end
  return true
end

SEquipExpUp.Unmarshal = function(self, buffer)
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
  return ret
end

return SEquipExpUp

