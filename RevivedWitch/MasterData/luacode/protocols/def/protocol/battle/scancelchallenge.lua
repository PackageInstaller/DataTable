-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/scancelchallenge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCancelChallenge = dataclass("SCancelChallenge", require("framework.net.protocol"))
SCancelChallenge.ProtocolType = 1980
SCancelChallenge.MaxSize = 65535
SCancelChallenge.result = 0
SCancelChallenge.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCancelChallenge
  ((SCancelChallenge.super).Ctor)(self, client)
end

SCancelChallenge.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SCancelChallenge.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCancelChallenge

