-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_guild.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CGuildPosition = (BeanManager.GetTableByName)("guild.cguildposition")
local CGuildAttribute = (BeanManager.GetTableByName)("guild.cguildattribute")
local SLightPartyRedpointProtocol = require("protocols.def.protocol.party.slightpartyredpoint")
local BM_Guild = class("BM_Guild")
BM_Guild.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._guild = (NekoData.Data).guild
end

BM_Guild.GetGuildInfo = function(self)
  -- function num : 0_1
  return (self._guild).guildInfo
end

BM_Guild.GetGuildID = function(self)
  -- function num : 0_2
  return ((self._guild).guildInfo).partyId
end

BM_Guild.GetGuildCheckType = function(self)
  -- function num : 0_3
  return ((self._guild).guildInfo).autoAcceptApply
end

BM_Guild.GetJobStr = function(self, position)
  -- function num : 0_4 , upvalues : CGuildPosition, _ENV
  local recorder = CGuildPosition:GetRecorder(position)
  if recorder then
    return (TextManager.GetText)(recorder.WordItemID)
  end
end

BM_Guild.GetPower_DissolveGuild = function(self)
  -- function num : 0_5 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.DissolveGuild ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_ChangePresident = function(self)
  -- function num : 0_6 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.ChangePresident ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_AppointVicePresident = function(self)
  -- function num : 0_7 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.AppointVicePresident ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_AppointElite = function(self)
  -- function num : 0_8 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.AppointElite ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_ChangeJoinType = function(self)
  -- function num : 0_9 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.ChangeJoinType ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_RemoveMembers = function(self)
  -- function num : 0_10 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.RemoveMembers ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_MembersReview = function(self)
  -- function num : 0_11 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.MembersReview ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetPower_ChangeDeclaration = function(self)
  -- function num : 0_12 , upvalues : CGuildPosition
  local recorder = CGuildPosition:GetRecorder((self._guild).playerJob)
  if recorder.ChangeDeclaration ~= 1 then
    do return not recorder end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

BM_Guild.GetVicePresidentLimitCount = function(self)
  -- function num : 0_13 , upvalues : CGuildAttribute
  local recorder = CGuildAttribute:GetRecorder(((self._guild).guildInfo).partyLv)
  if recorder then
    return recorder.VicePresidentTotal
  end
end

BM_Guild.GetEliteTLimitCount = function(self)
  -- function num : 0_14 , upvalues : CGuildAttribute
  local recorder = CGuildAttribute:GetRecorder(((self._guild).guildInfo).partyLv)
  if recorder then
    return recorder.EliteTotal
  end
end

BM_Guild.GetGuildTotalCount = function(self)
  -- function num : 0_15 , upvalues : CGuildAttribute
  local recorder = CGuildAttribute:GetRecorder(((self._guild).guildInfo).partyLv)
  if recorder then
    return recorder.GuildTotal
  end
end

BM_Guild.GetGuildMaxLevel = function(self)
  -- function num : 0_16 , upvalues : CGuildAttribute
  local allIDs = CGuildAttribute:GetAllIds()
  return allIDs[#allIDs]
end

BM_Guild.GetPlayerJob = function(self)
  -- function num : 0_17
  return (self._guild).playerJob
end

BM_Guild.IsCoolingOff = function(self)
  -- function num : 0_18
  do return (self._guild).hesitationPeriod == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Guild.GetGuildChatData = function(self)
  -- function num : 0_19
  return (self._guild).guildChatData
end

BM_Guild.IsRedPointOn = function(self)
  -- function num : 0_20
  do return #(self._guild).redpointType > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Guild.GetPartyDonateData = function(self)
  -- function num : 0_21
  return (self._guild).donateData
end

BM_Guild.GetGuildBossData = function(self)
  -- function num : 0_22
  return (self._guild).guildBossData
end

BM_Guild.GetGuildBossRed = function(self)
  -- function num : 0_23
  return (self._guild).guildBossRed
end

BM_Guild.GetGuildBossBattleResult = function(self)
  -- function num : 0_24
  return (self._guild).guildBossBattleResult
end

BM_Guild.IsDonateAwardGain = function(self, index)
  -- function num : 0_25 , upvalues : _ENV
  if ((self._guild).donateData).receiveAwards then
    return (table.isContain)(((self._guild).donateData).receiveAwards, index)
  end
  return false
end

BM_Guild.GetUnReadMessageCount = function(self)
  -- function num : 0_26
  return (self._guild).unReadMessageCount
end

BM_Guild.HasActivityRedDotOn = function(self)
  -- function num : 0_27 , upvalues : _ENV, SLightPartyRedpointProtocol
  return (table.isContain)((self._guild).redpointType, SLightPartyRedpointProtocol.PARTY_DONATE)
end

BM_Guild.IsActivityRedDotOnByType = function(self, type)
  -- function num : 0_28 , upvalues : _ENV
  return (table.isContain)((self._guild).redpointType, type)
end

return BM_Guild

