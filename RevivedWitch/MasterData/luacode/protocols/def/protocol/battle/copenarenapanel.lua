-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/copenarenapanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenArenaPanel = dataclass("COpenArenaPanel", require("framework.net.protocol"))
COpenArenaPanel.ProtocolType = 4107
COpenArenaPanel.MaxSize = 65535
COpenArenaPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenArenaPanel
  ((COpenArenaPanel.super).Ctor)(self, client)
end

COpenArenaPanel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenArenaPanel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenArenaPanel

