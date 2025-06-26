-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/ccommitquest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCommitQuest = dataclass("CCommitQuest", require("framework.net.protocol"))
CCommitQuest.ProtocolType = 1414
CCommitQuest.MaxSize = 65535
CCommitQuest.uniqueId = 0
CCommitQuest.answer = ""
CCommitQuest.validate = 0
CCommitQuest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCommitQuest
  ((CCommitQuest.super).Ctor)(self, client)
end

CCommitQuest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.answer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.validate) then
    return false
  end
  return true
end

CCommitQuest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCommitQuest

