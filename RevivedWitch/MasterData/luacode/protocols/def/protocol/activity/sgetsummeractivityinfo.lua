-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetsummeractivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetSummerActivityInfo = dataclass("SGetSummerActivityInfo", require("framework.net.protocol"))
SGetSummerActivityInfo.ProtocolType = 2470
SGetSummerActivityInfo.MaxSize = 65535
SGetSummerActivityInfo.firstEnter = 0
SGetSummerActivityInfo.sunlight = 0
SGetSummerActivityInfo.state = 0
SGetSummerActivityInfo.constructionRedpoint = 0
SGetSummerActivityInfo.snackRedpoint = 0
SGetSummerActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetSummerActivityInfo
  ((SGetSummerActivityInfo.super).Ctor)(self, client)
  self.missions = {}
  self.constructions = {}
end

SGetSummerActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.firstEnter) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sunlight) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  local length = (table.slen)(self.missions)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.missions)[i]):Marshal(buffer) then
      return false
    end
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
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.constructionRedpoint) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.snackRedpoint) then
    return false
  end
  return true
end

SGetSummerActivityInfo.Unmarshal = function(self, buffer)
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

    (self.missions)[i] = ((require("protocols.bean.protocol.activity.summermission")).Create)()
    if not ((self.missions)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

    (self.constructions)[i] = ((require("protocols.bean.protocol.activity.summerconstruction")).Create)()
    if not ((self.constructions)[i]):Unmarshal(buffer) then
      return false
    end
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

return SGetSummerActivityInfo

