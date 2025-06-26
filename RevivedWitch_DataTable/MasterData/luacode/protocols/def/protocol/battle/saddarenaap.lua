-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/saddarenaap.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddArenaAP = dataclass("SAddArenaAP", require("framework.net.protocol"))
SAddArenaAP.ProtocolType = 4119
SAddArenaAP.MaxSize = 65535
SAddArenaAP.apAddTimes = 0
SAddArenaAP.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddArenaAP
  ((SAddArenaAP.super).Ctor)(self, client)
end

SAddArenaAP.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.apAddTimes) then
    return false
  end
  return true
end

SAddArenaAP.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddArenaAP

