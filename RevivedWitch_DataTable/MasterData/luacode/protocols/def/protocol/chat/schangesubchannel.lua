-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/schangesubchannel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChangeSubChannel = dataclass("SChangeSubChannel", require("framework.net.protocol"))
SChangeSubChannel.ProtocolType = 1105
SChangeSubChannel.MaxSize = 65535
SChangeSubChannel.num = 0
SChangeSubChannel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChangeSubChannel
  ((SChangeSubChannel.super).Ctor)(self, client)
end

SChangeSubChannel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

SChangeSubChannel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeSubChannel

