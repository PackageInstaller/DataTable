-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copenweekbosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenWeekBossPanel = dataclass("COpenWeekBossPanel", require("framework.net.protocol"))
COpenWeekBossPanel.ProtocolType = 4140
COpenWeekBossPanel.MaxSize = 65535
COpenWeekBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenWeekBossPanel
  ((COpenWeekBossPanel.super).Ctor)(self, client)
end

COpenWeekBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenWeekBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenWeekBossPanel

