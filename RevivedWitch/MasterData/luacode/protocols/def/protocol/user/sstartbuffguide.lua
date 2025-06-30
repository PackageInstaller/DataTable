-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/sstartbuffguide.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SStartBuffGuide = dataclass("SStartBuffGuide", require("framework.net.protocol"))
SStartBuffGuide.ProtocolType = 2269
SStartBuffGuide.MaxSize = 65535
SStartBuffGuide.buffType = 0
SStartBuffGuide.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SStartBuffGuide
  ((SStartBuffGuide.super).Ctor)(self, client)
end

SStartBuffGuide.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buffType) then
    return false
  end
  return true
end

SStartBuffGuide.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartBuffGuide

