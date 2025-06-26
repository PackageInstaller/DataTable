-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/sdismissparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDismissParty = dataclass("SDismissParty", require("framework.net.protocol"))
SDismissParty.ProtocolType = 5029
SDismissParty.MaxSize = 65535
SDismissParty.result = 0
SDismissParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDismissParty
  ((SDismissParty.super).Ctor)(self, client)
end

SDismissParty.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SDismissParty.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDismissParty

