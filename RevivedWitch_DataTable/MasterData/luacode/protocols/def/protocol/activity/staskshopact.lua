-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/staskshopact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STaskShopAct = dataclass("STaskShopAct", require("framework.net.protocol"))
STaskShopAct.ProtocolType = 2698
STaskShopAct.MaxSize = 65535
STaskShopAct.activityId = 0
STaskShopAct.leftTime = 0
STaskShopAct.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STaskShopAct
  ((STaskShopAct.super).Ctor)(self, client)
  self.award = {}
end

STaskShopAct.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.award)) then
    return false
  end
  for key,value in pairs(self.award) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
  end
  return true
end

STaskShopAct.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.award)[key] = value
  end
  return ret
end

return STaskShopAct

