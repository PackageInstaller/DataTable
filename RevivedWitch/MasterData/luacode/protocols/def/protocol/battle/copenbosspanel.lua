-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copenbosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenBossPanel = dataclass("COpenBossPanel", require("framework.net.protocol"))
COpenBossPanel.ProtocolType = 1950
COpenBossPanel.MaxSize = 65535
COpenBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenBossPanel
  ((COpenBossPanel.super).Ctor)(self, client)
end

COpenBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenBossPanel

