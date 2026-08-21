-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlockhigholdplayerwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockHighOldPlayerWelfare = dataclass("CUnlockHighOldPlayerWelfare", require("framework.net.protocol"))
CUnlockHighOldPlayerWelfare.ProtocolType = 2737
CUnlockHighOldPlayerWelfare.MaxSize = 65535
CUnlockHighOldPlayerWelfare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockHighOldPlayerWelfare
  ((CUnlockHighOldPlayerWelfare.super).Ctor)(self, client)
end

CUnlockHighOldPlayerWelfare.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CUnlockHighOldPlayerWelfare.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CUnlockHighOldPlayerWelfare

