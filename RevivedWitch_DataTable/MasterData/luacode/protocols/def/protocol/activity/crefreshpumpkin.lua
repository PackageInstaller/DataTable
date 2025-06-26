-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crefreshpumpkin.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshPumpkin = dataclass("CRefreshPumpkin", require("framework.net.protocol"))
CRefreshPumpkin.ProtocolType = 2518
CRefreshPumpkin.MaxSize = 65535
CRefreshPumpkin.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshPumpkin
  ((CRefreshPumpkin.super).Ctor)(self, client)
end

CRefreshPumpkin.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRefreshPumpkin.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRefreshPumpkin

