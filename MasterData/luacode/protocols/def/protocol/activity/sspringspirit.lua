-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sspringspirit.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSpringSpirit = dataclass("SSpringSpirit", require("framework.net.protocol"))
SSpringSpirit.ProtocolType = 2582
SSpringSpirit.MaxSize = 65535
SSpringSpirit.spirit = 0
SSpringSpirit.lefttime = 0
SSpringSpirit.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSpringSpirit
  ((SSpringSpirit.super).Ctor)(self, client)
end

SSpringSpirit.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spirit) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lefttime) then
    return false
  end
  return true
end

SSpringSpirit.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringSpirit

