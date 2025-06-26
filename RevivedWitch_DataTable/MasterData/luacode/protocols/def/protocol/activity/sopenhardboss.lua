-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenhardboss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenHardBoss = dataclass("SOpenHardBoss", require("framework.net.protocol"))
SOpenHardBoss.ProtocolType = 2541
SOpenHardBoss.MaxSize = 65535
SOpenHardBoss.leftNum = 0
SOpenHardBoss.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenHardBoss
  ((SOpenHardBoss.super).Ctor)(self, client)
end

SOpenHardBoss.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftNum) then
    return false
  end
  return true
end

SOpenHardBoss.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenHardBoss

