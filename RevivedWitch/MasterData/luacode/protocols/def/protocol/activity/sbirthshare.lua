-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbirthshare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBirthShare = dataclass("SBirthShare", require("framework.net.protocol"))
SBirthShare.ProtocolType = 2548
SBirthShare.MaxSize = 65535
SBirthShare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBirthShare
  ((SBirthShare.super).Ctor)(self, client)
end

SBirthShare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SBirthShare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SBirthShare

