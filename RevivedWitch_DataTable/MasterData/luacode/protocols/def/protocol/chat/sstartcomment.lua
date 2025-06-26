-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/sstartcomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SStartComment = dataclass("SStartComment", require("framework.net.protocol"))
SStartComment.ProtocolType = 1149
SStartComment.MaxSize = 65535
SStartComment.logType = 0
SStartComment.awardId = 0
SStartComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SStartComment
  ((SStartComment.super).Ctor)(self, client)
end

SStartComment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.logType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardId) then
    return false
  end
  return true
end

SStartComment.Unmarshal = function(self, buffer)
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
  return ret
end

return SStartComment

