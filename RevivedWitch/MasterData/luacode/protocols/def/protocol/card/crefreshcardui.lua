-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/crefreshcardui.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshCardUI = dataclass("CRefreshCardUI", require("framework.net.protocol"))
CRefreshCardUI.ProtocolType = 1501
CRefreshCardUI.MaxSize = 65535
CRefreshCardUI.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshCardUI
  ((CRefreshCardUI.super).Ctor)(self, client)
end

CRefreshCardUI.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshCardUI.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshCardUI

