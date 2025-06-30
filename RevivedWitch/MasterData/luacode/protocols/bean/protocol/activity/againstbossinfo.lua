-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/activity/againstbossinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local AgainstBossInfo = dataclass("AgainstBossInfo")
AgainstBossInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.weeklyAwardsList = {}
  self.witchInfo = ((require("protocols.bean.protocol.activity.witchinfo")).Create)()
  self.bossInfoList = {}
end

AgainstBossInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.weeklyAwardsList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.weeklyAwardsList)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.witchInfo):Marshal(buffer) then
    return false
  end
  local length = (table.slen)(self.bossInfoList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.bossInfoList)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

AgainstBossInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.weeklyAwardsList)[i] = ((require("protocols.bean.protocol.activity.weeklyawards")).Create)()
    if not ((self.weeklyAwardsList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.witchInfo):Unmarshal(buffer) then
    return false
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

    (self.bossInfoList)[i] = ((require("protocols.bean.protocol.activity.bossinfo")).Create)()
    if not ((self.bossInfoList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return AgainstBossInfo

