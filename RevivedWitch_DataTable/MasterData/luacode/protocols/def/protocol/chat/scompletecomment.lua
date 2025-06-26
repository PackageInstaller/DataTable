-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/scompletecomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCompleteComment = dataclass("SCompleteComment", require("framework.net.protocol"))
SCompleteComment.ProtocolType = 1151
SCompleteComment.MaxSize = 65535
SCompleteComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCompleteComment
  ((SCompleteComment.super).Ctor)(self, client)
end

SCompleteComment.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SCompleteComment.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SCompleteComment

