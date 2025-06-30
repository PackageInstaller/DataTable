-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cfantasyconflictopenpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFantasyConflictOpenPanel = dataclass("CFantasyConflictOpenPanel", require("framework.net.protocol"))
CFantasyConflictOpenPanel.ProtocolType = 4149
CFantasyConflictOpenPanel.MaxSize = 65535
CFantasyConflictOpenPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFantasyConflictOpenPanel
  ((CFantasyConflictOpenPanel.super).Ctor)(self, client)
end

CFantasyConflictOpenPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CFantasyConflictOpenPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CFantasyConflictOpenPanel

