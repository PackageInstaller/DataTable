-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cbirthshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBirthShare = dataclass("CBirthShare", require("framework.net.protocol"))
CBirthShare.ProtocolType = 2547
CBirthShare.MaxSize = 65535
CBirthShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBirthShare
  ((CBirthShare.super).Ctor)(self, client)
end

CBirthShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CBirthShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CBirthShare

