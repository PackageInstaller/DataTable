-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ccompletecomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCompleteComment = dataclass("CCompleteComment", require("framework.net.protocol"))
CCompleteComment.ProtocolType = 1150
CCompleteComment.MaxSize = 65535
CCompleteComment.logResult = 0
CCompleteComment.logType = 0
CCompleteComment.content = ""
CCompleteComment.ADVICE = 1
CCompleteComment.AWARD = 2
CCompleteComment.CANCEL = 3
CCompleteComment.SURE_DRAW = 1
CCompleteComment.ACTIVE = 2
CCompleteComment.MISSION = 3
CCompleteComment.FIRST_LUCK = 4
CCompleteComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCompleteComment
  ((CCompleteComment.super).Ctor)(self, client)
end

CCompleteComment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.logResult) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.logType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.content) then
    return false
  end
  return true
end

CCompleteComment.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteComment

