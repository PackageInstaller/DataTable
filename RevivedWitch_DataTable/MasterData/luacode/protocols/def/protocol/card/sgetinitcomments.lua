-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/sgetinitcomments.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetInitComments = dataclass("SGetInitComments", require("framework.net.protocol"))
SGetInitComments.ProtocolType = 1513
SGetInitComments.MaxSize = 65535
SGetInitComments.commentType = 0
SGetInitComments.roleId = 0
SGetInitComments.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetInitComments, _ENV
  ((SGetInitComments.super).Ctor)(self, client)
  self.userComment = ((require("protocols.bean.protocol.card.commentinfo")).Create)()
  self.comments = {}
end

SGetInitComments.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.commentType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (self.userComment):Marshal(buffer) then
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

SGetInitComments.Unmarshal = function(self, buffer)
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
  if not (self.userComment):Unmarshal(buffer) then
    return false
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

return SGetInitComments

