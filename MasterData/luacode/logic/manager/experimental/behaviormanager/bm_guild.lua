local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CGuildPosition = BeanManager.GetTableByName("guild.cguildposition")
local CGuildAttribute = BeanManager.GetTableByName("guild.cguildattribute")
local SLightPartyRedpointProtocol = require("protocols.def.protocol.party.slightpartyredpoint")
local BM_Guild = class("BM_Guild")

function BM_Guild:Ctor()
  self._guild = NekoData.Data.guild
end

function BM_Guild:GetGuildInfo()
  return self._guild.guildInfo
end

function BM_Guild:GetGuildID()
  return self._guild.guildInfo.partyId
end

function BM_Guild:GetGuildCheckType()
  return self._guild.guildInfo.autoAcceptApply
end

function BM_Guild:GetJobStr(position)
  local recorder = CGuildPosition:GetRecorder(position)
  if recorder then
    return TextManager.GetText(recorder.WordItemID)
  end
end

function BM_Guild:GetPower_DissolveGuild()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.DissolveGuild == 1
  end
end

function BM_Guild:GetPower_ChangePresident()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.ChangePresident == 1
  end
end

function BM_Guild:GetPower_AppointVicePresident()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.AppointVicePresident == 1
  end
end

function BM_Guild:GetPower_AppointElite()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.AppointElite == 1
  end
end

function BM_Guild:GetPower_ChangeJoinType()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.ChangeJoinType == 1
  end
end

function BM_Guild:GetPower_RemoveMembers()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.RemoveMembers == 1
  end
end

function BM_Guild:GetPower_MembersReview()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.MembersReview == 1
  end
end

function BM_Guild:GetPower_ChangeDeclaration()
  local recorder = CGuildPosition:GetRecorder(self._guild.playerJob)
  if recorder then
    return recorder.ChangeDeclaration == 1
  end
end

function BM_Guild:GetVicePresidentLimitCount()
  local recorder = CGuildAttribute:GetRecorder(self._guild.guildInfo.partyLv)
  if recorder then
    return recorder.VicePresidentTotal
  end
end

function BM_Guild:GetEliteTLimitCount()
  local recorder = CGuildAttribute:GetRecorder(self._guild.guildInfo.partyLv)
  if recorder then
    return recorder.EliteTotal
  end
end

function BM_Guild:GetGuildTotalCount()
  local recorder = CGuildAttribute:GetRecorder(self._guild.guildInfo.partyLv)
  if recorder then
    return recorder.GuildTotal
  end
end

function BM_Guild:GetGuildMaxLevel()
  local allIDs = CGuildAttribute:GetAllIds()
  return allIDs[#allIDs]
end

function BM_Guild:GetPlayerJob()
  return self._guild.playerJob
end

function BM_Guild:IsCoolingOff()
  return self._guild.hesitationPeriod == 1
end

function BM_Guild:GetGuildChatData()
  return self._guild.guildChatData
end

function BM_Guild:IsRedPointOn()
  return #self._guild.redpointType > 0
end

function BM_Guild:GetPartyDonateData()
  return self._guild.donateData
end

function BM_Guild:GetGuildBossData()
  return self._guild.guildBossData
end

function BM_Guild:GetGuildBossRed()
  return self._guild.guildBossRed
end

function BM_Guild:GetGuildBossBattleResult()
  return self._guild.guildBossBattleResult
end

function BM_Guild:IsDonateAwardGain(index)
  if self._guild.donateData.receiveAwards then
    return table.isContain(self._guild.donateData.receiveAwards, index)
  end
  return false
end

function BM_Guild:GetUnReadMessageCount()
  return self._guild.unReadMessageCount
end

function BM_Guild:HasActivityRedDotOn()
  return table.isContain(self._guild.redpointType, SLightPartyRedpointProtocol.PARTY_DONATE)
end

function BM_Guild:IsActivityRedDotOnByType(type)
  return table.isContain(self._guild.redpointType, type)
end

return BM_Guild
