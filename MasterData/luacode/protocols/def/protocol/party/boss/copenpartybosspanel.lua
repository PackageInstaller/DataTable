-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/copenpartybosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenPartyBossPanel = dataclass("COpenPartyBossPanel", require("framework.net.protocol"))
COpenPartyBossPanel.ProtocolType = 5040
COpenPartyBossPanel.MaxSize = 8
COpenPartyBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenPartyBossPanel
  ((COpenPartyBossPanel.super).Ctor)(self, client)
end

COpenPartyBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenPartyBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenPartyBossPanel

