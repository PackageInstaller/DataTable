-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/smodifyautoaccept.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SModifyAutoAccept = dataclass("SModifyAutoAccept", require("framework.net.protocol"))
SModifyAutoAccept.ProtocolType = 5014
SModifyAutoAccept.MaxSize = 65535
SModifyAutoAccept.partyId = 0
SModifyAutoAccept.autoAcceptApply = 0
SModifyAutoAccept.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SModifyAutoAccept
  ((SModifyAutoAccept.super).Ctor)(self, client)
end

SModifyAutoAccept.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

SModifyAutoAccept.Unmarshal = function(self, buffer)
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

return SModifyAutoAccept

