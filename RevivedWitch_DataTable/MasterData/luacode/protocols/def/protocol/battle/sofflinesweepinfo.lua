-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sofflinesweepinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOfflineSweepInfo = dataclass("SOfflineSweepInfo", require("framework.net.protocol"))
SOfflineSweepInfo.ProtocolType = 4135
SOfflineSweepInfo.MaxSize = 65535
SOfflineSweepInfo.status = 0
SOfflineSweepInfo.battleType = 0
SOfflineSweepInfo.id = 0
SOfflineSweepInfo.leftTime = 0
SOfflineSweepInfo.totalNum = 0
SOfflineSweepInfo.leftNum = 0
SOfflineSweepInfo.receivedNum = 0
SOfflineSweepInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOfflineSweepInfo
  ((SOfflineSweepInfo.super).Ctor)(self, client)
end

SOfflineSweepInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.battleType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.receivedNum) then
    return false
  end
  return true
end

SOfflineSweepInfo.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOfflineSweepInfo

