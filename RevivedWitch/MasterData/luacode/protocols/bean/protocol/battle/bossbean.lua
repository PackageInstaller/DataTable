-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/bossbean.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BossBean = dataclass("BossBean")
BossBean.id = 0
BossBean.status = 0
BossBean.passTime = 0
BossBean.rank = 0
BossBean.awardTotalNum = 0
BossBean.times = 0
BossBean.victoryTimes = 0
BossBean.Ctor = function(self)
  -- function num : 0_0
  self.awardGot = {}
end

BossBean.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.passTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.awardTotalNum) then
    return false
  end
  local length = (table.slen)(self.awardGot)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.awardGot)[i]) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.times) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.victoryTimes) then
    return false
  end
  return true
end

BossBean.Unmarshal = function(self, buffer)
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
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
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

return BossBean

