-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/snotifyposition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SNotifyPosition = dataclass("SNotifyPosition", require("framework.net.protocol"))
SNotifyPosition.ProtocolType = 5015
SNotifyPosition.MaxSize = 65535
SNotifyPosition.userId = 0
SNotifyPosition.position = 0
SNotifyPosition.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SNotifyPosition
  ((SNotifyPosition.super).Ctor)(self, client)
end

SNotifyPosition.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  return true
end

SNotifyPosition.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SNotifyPosition

