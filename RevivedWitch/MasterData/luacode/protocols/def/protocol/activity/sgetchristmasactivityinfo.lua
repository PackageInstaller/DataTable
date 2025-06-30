-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetchristmasactivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetChristmasActivityInfo = dataclass("SGetChristmasActivityInfo", require("framework.net.protocol"))
SGetChristmasActivityInfo.ProtocolType = 2526
SGetChristmasActivityInfo.MaxSize = 65535
SGetChristmasActivityInfo.firstEnter = 0
SGetChristmasActivityInfo.stage = 0
SGetChristmasActivityInfo.canEnterSecond = 0
SGetChristmasActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetChristmasActivityInfo
  ((SGetChristmasActivityInfo.super).Ctor)(self, client)
  self.constructions = {}
end

SGetChristmasActivityInfo.Marshal = function(self, buffer)
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
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.canEnterSecond) then
    return false
  end
  return true
end

SGetChristmasActivityInfo.Unmarshal = function(self, buffer)
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

    (self.constructions)[i] = ((require("protocols.bean.protocol.activity.christmasconstruction")).Create)()
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

return SGetChristmasActivityInfo

