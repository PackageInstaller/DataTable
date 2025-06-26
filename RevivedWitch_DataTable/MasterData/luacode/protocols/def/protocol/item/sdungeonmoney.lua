-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sdungeonmoney.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDungeonMoney = dataclass("SDungeonMoney", require("framework.net.protocol"))
SDungeonMoney.ProtocolType = 1236
SDungeonMoney.MaxSize = 65535
SDungeonMoney.gold = 0
SDungeonMoney.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDungeonMoney
  ((SDungeonMoney.super).Ctor)(self, client)
end

SDungeonMoney.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.gold) then
    return false
  end
  return true
end

SDungeonMoney.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDungeonMoney

