-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cdismissparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDismissParty = dataclass("CDismissParty", require("framework.net.protocol"))
CDismissParty.ProtocolType = 5016
CDismissParty.MaxSize = 65535
CDismissParty.partyId = 0
CDismissParty.operate = 0
CDismissParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDismissParty
  ((CDismissParty.super).Ctor)(self, client)
end

CDismissParty.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.operate) then
    return false
  end
  return true
end

CDismissParty.Unmarshal = function(self, buffer)
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

return CDismissParty

