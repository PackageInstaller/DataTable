-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetloveractivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetLoverActivityInfo = dataclass("SGetLoverActivityInfo", require("framework.net.protocol"))
SGetLoverActivityInfo.ProtocolType = 2589
SGetLoverActivityInfo.MaxSize = 65535
SGetLoverActivityInfo.firstEnter = 0
SGetLoverActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetLoverActivityInfo
  ((SGetLoverActivityInfo.super).Ctor)(self, client)
  self.constructions = {}
end

SGetLoverActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.firstEnter) then
    return false
  end
  local length = (table.slen)(self.constructions)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.constructions)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SGetLoverActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
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
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.constructions)[i] = ((require("protocols.bean.protocol.activity.loverconstruction")).Create)()
    if not ((self.constructions)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetLoverActivityInfo

