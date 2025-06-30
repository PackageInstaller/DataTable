-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copensidequestpanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenSideQuestPanel = dataclass("COpenSideQuestPanel", require("framework.net.protocol"))
COpenSideQuestPanel.ProtocolType = 2421
COpenSideQuestPanel.MaxSize = 65536
COpenSideQuestPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenSideQuestPanel
  ((COpenSideQuestPanel.super).Ctor)(self, client)
end

COpenSideQuestPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenSideQuestPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenSideQuestPanel

