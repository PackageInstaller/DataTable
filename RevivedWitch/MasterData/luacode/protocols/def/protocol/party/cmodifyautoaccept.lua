-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cmodifyautoaccept.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CModifyAutoAccept = dataclass("CModifyAutoAccept", require("framework.net.protocol"))
CModifyAutoAccept.ProtocolType = 5013
CModifyAutoAccept.MaxSize = 65535
CModifyAutoAccept.partyId = 0
CModifyAutoAccept.autoAcceptApply = 0
CModifyAutoAccept.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CModifyAutoAccept
  ((CModifyAutoAccept.super).Ctor)(self, client)
end

CModifyAutoAccept.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

CModifyAutoAccept.Unmarshal = function(self, buffer)
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

return CModifyAutoAccept

