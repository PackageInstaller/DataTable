-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/steamaddition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STeamAddition = dataclass("STeamAddition", require("framework.net.protocol"))
STeamAddition.ProtocolType = 4148
STeamAddition.MaxSize = 65535
STeamAddition.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STeamAddition
  ((STeamAddition.super).Ctor)(self, client)
end

STeamAddition.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

STeamAddition.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return STeamAddition

