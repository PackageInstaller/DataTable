-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/reducecost/sreducecostactinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReduceCostActInfo = dataclass("SReduceCostActInfo", require("framework.net.protocol"))
SReduceCostActInfo.ProtocolType = 2401
SReduceCostActInfo.MaxSize = 65535
SReduceCostActInfo.endTime = 0
SReduceCostActInfo.floorList = ""
SReduceCostActInfo.discount = 0
SReduceCostActInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReduceCostActInfo
  ((SReduceCostActInfo.super).Ctor)(self, client)
end

SReduceCostActInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.floorList) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolFloat)(buffer, self.discount) then
    return false
  end
  return true
end

SReduceCostActInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadFloat)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReduceCostActInfo

