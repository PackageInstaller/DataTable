-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/boss/spartybosspanelinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPartyBossPanelInfo = dataclass("SPartyBossPanelInfo", require("framework.net.protocol"))
SPartyBossPanelInfo.ProtocolType = 5041
SPartyBossPanelInfo.MaxSize = 65535
SPartyBossPanelInfo.startime = 0
SPartyBossPanelInfo.endtime = 0
SPartyBossPanelInfo.score = 0
SPartyBossPanelInfo.rank = 0
SPartyBossPanelInfo.chances = 0
SPartyBossPanelInfo.costspirit = 0
SPartyBossPanelInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPartyBossPanelInfo
  ((SPartyBossPanelInfo.super).Ctor)(self, client)
  self.damagerecords = {}
  self.bossstates = {}
end

SPartyBossPanelInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.startime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endtime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.score) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rank) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chances) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.costspirit) then
    return false
  end
  local length = (table.slen)(self.damagerecords)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.damagerecords)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.bossstates)) then
    return false
  end
  for key,value in pairs(self.bossstates) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC92) then
      return false
    end
    if not value:Marshal(R10_PC92) then
      return false
    end
  end
  return true
end

SPartyBossPanelInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

    (self.damagerecords)[i] = ((require("protocols.bean.protocol.party.boss.partybossdamagerecord")).Create)()
    if not ((self.damagerecords)[i]):Unmarshal(buffer) then
      return false
    end
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
    -- DECOMPILER ERROR at PC109: Overwrote pending register: R6 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.bossstates)[key] = value
  end
  return ret
end

return SPartyBossPanelInfo

