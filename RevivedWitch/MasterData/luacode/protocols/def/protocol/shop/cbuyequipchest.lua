-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cbuyequipchest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyEquipChest = dataclass("CBuyEquipChest", require("framework.net.protocol"))
CBuyEquipChest.ProtocolType = 3633
CBuyEquipChest.MaxSize = 65535
CBuyEquipChest.chestID = 0
CBuyEquipChest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyEquipChest
  ((CBuyEquipChest.super).Ctor)(self, client)
end

CBuyEquipChest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chestID) then
    return false
  end
  return true
end

CBuyEquipChest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyEquipChest

