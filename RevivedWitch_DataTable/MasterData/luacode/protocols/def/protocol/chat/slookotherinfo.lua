-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/slookotherinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLookOtherInfo = dataclass("SLookOtherInfo", require("framework.net.protocol"))
SLookOtherInfo.ProtocolType = 1137
SLookOtherInfo.MaxSize = 65535
SLookOtherInfo.title = ""
SLookOtherInfo.introduce = ""
SLookOtherInfo.likedNum = 0
SLookOtherInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLookOtherInfo, _ENV
  ((SLookOtherInfo.super).Ctor)(self, client)
  self.baseUserData = ((require("protocols.bean.protocol.chat.baseuserdata")).Create)()
  self.support = ((require("protocols.bean.protocol.chat.roleinfo")).Create)()
  self.display = {}
end

SLookOtherInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (self.baseUserData):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.title) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.introduce) then
    return false
  end
  if not (self.support):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.display)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.display)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.likedNum) then
    return false
  end
  return true
end

SLookOtherInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  if not (self.baseUserData):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  if not (self.support):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    (self.display)[i] = ((require("protocols.bean.protocol.ranking.role")).Create)()
    if not ((self.display)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLookOtherInfo

