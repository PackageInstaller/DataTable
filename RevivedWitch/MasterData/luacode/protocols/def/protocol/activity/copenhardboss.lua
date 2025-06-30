-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenhardboss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenHardBoss = dataclass("COpenHardBoss", require("framework.net.protocol"))
COpenHardBoss.ProtocolType = 2540
COpenHardBoss.MaxSize = 65536
COpenHardBoss.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenHardBoss
  ((COpenHardBoss.super).Ctor)(self, client)
end

COpenHardBoss.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenHardBoss.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenHardBoss

