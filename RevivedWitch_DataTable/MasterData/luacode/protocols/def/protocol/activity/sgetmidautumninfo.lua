-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetmidautumninfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetMidAutumnInfo = dataclass("SGetMidAutumnInfo", require("framework.net.protocol"))
SGetMidAutumnInfo.ProtocolType = 2504
SGetMidAutumnInfo.MaxSize = 65535
SGetMidAutumnInfo.leftTime = 0
SGetMidAutumnInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetMidAutumnInfo
  ((SGetMidAutumnInfo.super).Ctor)(self, client)
end

SGetMidAutumnInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  return true
end

SGetMidAutumnInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetMidAutumnInfo

