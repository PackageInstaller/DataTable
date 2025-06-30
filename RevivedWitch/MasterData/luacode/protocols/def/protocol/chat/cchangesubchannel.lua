-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/cchangesubchannel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeSubChannel = dataclass("CChangeSubChannel", require("framework.net.protocol"))
CChangeSubChannel.ProtocolType = 1104
CChangeSubChannel.MaxSize = 65535
CChangeSubChannel.num = 0
CChangeSubChannel.FLAG_CHANNEL_INEXISTENT = -1
CChangeSubChannel.FLAG_CHANNEL_FULL = -2
CChangeSubChannel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeSubChannel
  ((CChangeSubChannel.super).Ctor)(self, client)
end

CChangeSubChannel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  return true
end

CChangeSubChannel.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeSubChannel

