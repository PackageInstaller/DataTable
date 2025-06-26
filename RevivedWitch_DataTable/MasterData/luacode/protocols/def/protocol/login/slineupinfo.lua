-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/slineupinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLineupInfo = dataclass("SLineupInfo", require("framework.net.protocol"))
SLineupInfo.ProtocolType = 1040
SLineupInfo.MaxSize = 65535
SLineupInfo.commonLinupId = 0
SLineupInfo.towerLineupId = 0
SLineupInfo.bossRushLineupId = 0
SLineupInfo.autoExploreLineupId = 0
SLineupInfo.guardRestoreLineupId = 0
SLineupInfo.damageStabLineupId = 0
SLineupInfo.magicImpairLineupId = 0
SLineupInfo.undecidedRoadLineupId = 0
SLineupInfo.springFestivalLineupId = 0
SLineupInfo.srChallengeLineupId = 0
SLineupInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLineupInfo, _ENV
  ((SLineupInfo.super).Ctor)(self, client)
  self.lineupList = {}
  self.supportRole = ((require("protocols.bean.protocol.chat.supportrole")).Create)()
end

SLineupInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.commonLinupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.towerLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bossRushLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.autoExploreLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.guardRestoreLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.damageStabLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.magicImpairLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.undecidedRoadLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.springFestivalLineupId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.srChallengeLineupId) then
    return false
  end
  local length = (table.slen)(self.lineupList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.lineupList)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.supportRole):Marshal(buffer) then
    return false
  end
  return true
end

SLineupInfo.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

    (self.lineupList)[i] = ((require("protocols.bean.protocol.login.lineup")).Create)()
    if not ((self.lineupList)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.supportRole):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SLineupInfo

