-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/cbuydiamond.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyDiamond = dataclass("CBuyDiamond", require("framework.net.protocol"))
CBuyDiamond.ProtocolType = 3901
CBuyDiamond.MaxSize = 65535
CBuyDiamond.WaitProtocol = "protocol.notify.scancelloading"
CBuyDiamond.goodId = 0
CBuyDiamond.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyDiamond
  ((CBuyDiamond.super).Ctor)(self, client)
end

CBuyDiamond.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  return true
end

CBuyDiamond.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyDiamond

