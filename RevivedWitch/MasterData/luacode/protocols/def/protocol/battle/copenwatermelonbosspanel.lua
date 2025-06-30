-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copenwatermelonbosspanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenWatermelonBossPanel = dataclass("COpenWatermelonBossPanel", require("framework.net.protocol"))
COpenWatermelonBossPanel.ProtocolType = 4130
COpenWatermelonBossPanel.MaxSize = 65535
COpenWatermelonBossPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenWatermelonBossPanel
  ((COpenWatermelonBossPanel.super).Ctor)(self, client)
end

COpenWatermelonBossPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenWatermelonBossPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenWatermelonBossPanel

