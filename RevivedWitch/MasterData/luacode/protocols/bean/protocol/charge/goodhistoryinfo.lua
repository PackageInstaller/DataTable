-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/charge/goodhistoryinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local GoodHistoryInfo = dataclass("GoodHistoryInfo")
GoodHistoryInfo.sn = 0
GoodHistoryInfo.status = 0
GoodHistoryInfo.price = 0
GoodHistoryInfo.obtainedDiamond = 0
GoodHistoryInfo.bonusDiamond = 0
GoodHistoryInfo.createtime = 0
GoodHistoryInfo.Ctor = function(self)
  -- function num : 0_0
end

GoodHistoryInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.sn) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.price) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.obtainedDiamond) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bonusDiamond) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.createtime) then
    return false
  end
  return true
end

GoodHistoryInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodHistoryInfo

