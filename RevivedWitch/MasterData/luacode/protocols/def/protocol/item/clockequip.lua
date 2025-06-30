-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/clockequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLockEquip = dataclass("CLockEquip", require("framework.net.protocol"))
CLockEquip.ProtocolType = 1228
CLockEquip.MaxSize = 65535
CLockEquip.key = 0
CLockEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLockEquip
  ((CLockEquip.super).Ctor)(self, client)
end

CLockEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  return true
end

CLockEquip.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLockEquip

