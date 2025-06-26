-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/spartybossreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPartyBossRedDot = dataclass("SPartyBossRedDot", require("framework.net.protocol"))
SPartyBossRedDot.ProtocolType = 5042
SPartyBossRedDot.MaxSize = 65535
SPartyBossRedDot.flag = 0
SPartyBossRedDot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPartyBossRedDot
  ((SPartyBossRedDot.super).Ctor)(self, client)
end

SPartyBossRedDot.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.flag) then
    return false
  end
  return true
end

SPartyBossRedDot.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPartyBossRedDot

