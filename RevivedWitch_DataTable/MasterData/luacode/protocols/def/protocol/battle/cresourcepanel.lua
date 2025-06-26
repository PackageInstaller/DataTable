-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cresourcepanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CResourcePanel = dataclass("CResourcePanel", require("framework.net.protocol"))
CResourcePanel.ProtocolType = 1934
CResourcePanel.MaxSize = 65535
CResourcePanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CResourcePanel
  ((CResourcePanel.super).Ctor)(self, client)
end

CResourcePanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CResourcePanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CResourcePanel

