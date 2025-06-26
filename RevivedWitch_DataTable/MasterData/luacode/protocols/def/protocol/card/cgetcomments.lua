-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/cgetcomments.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetComments = dataclass("CGetComments", require("framework.net.protocol"))
CGetComments.ProtocolType = 1512
CGetComments.MaxSize = 65535
CGetComments.roleId = 0
CGetComments.commentType = 0
CGetComments.lastIndex = 0
CGetComments.POPULAR_COMMENT = 1
CGetComments.LATEST_COMMENT = 2
CGetComments.COMMENTS_PRE_PAGE = 30
CGetComments.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetComments
  ((CGetComments.super).Ctor)(self, client)
end

CGetComments.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.commentType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lastIndex) then
    return false
  end
  return true
end

CGetComments.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetComments

