-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ccancelchallenge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCancelChallenge = dataclass("CCancelChallenge", require("framework.net.protocol"))
CCancelChallenge.ProtocolType = 1979
CCancelChallenge.MaxSize = 65535
CCancelChallenge.cancelTower = 0
CCancelChallenge.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCancelChallenge
  ((CCancelChallenge.super).Ctor)(self, client)
end

CCancelChallenge.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cancelTower) then
    return false
  end
  return true
end

CCancelChallenge.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCancelChallenge

