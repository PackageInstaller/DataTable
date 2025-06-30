-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/sgetmorecomments.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetMoreComments = dataclass("SGetMoreComments", require("framework.net.protocol"))
SGetMoreComments.ProtocolType = 1514
SGetMoreComments.MaxSize = 65535
SGetMoreComments.commentType = 0
SGetMoreComments.roleId = 0
SGetMoreComments.firstIndex = 0
SGetMoreComments.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetMoreComments
  ((SGetMoreComments.super).Ctor)(self, client)
  self.comments = {}
end

SGetMoreComments.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.commentType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.firstIndex) then
    return false
  end
  local length = (table.slen)(self.comments)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.comments)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SGetMoreComments.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.comments)[i] = ((require("protocols.bean.protocol.card.commentinfo")).Create)()
    if not ((self.comments)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetMoreComments

