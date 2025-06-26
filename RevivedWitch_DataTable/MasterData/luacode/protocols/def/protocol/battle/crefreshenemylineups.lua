-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/crefreshenemylineups.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshEnemyLineups = dataclass("CRefreshEnemyLineups", require("framework.net.protocol"))
CRefreshEnemyLineups.ProtocolType = 4112
CRefreshEnemyLineups.MaxSize = 65535
CRefreshEnemyLineups.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshEnemyLineups
  ((CRefreshEnemyLineups.super).Ctor)(self, client)
end

CRefreshEnemyLineups.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshEnemyLineups.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshEnemyLineups

