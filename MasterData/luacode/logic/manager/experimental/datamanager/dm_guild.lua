local CGuildAttribute = BeanManager.GetTableByName("guild.cguildattribute")
local SLightPartyRedpointProtocol = require("protocols.def.protocol.party.slightpartyredpoint")
local DM_Guild = class("DM_Guild")

function DM_Guild:Ctor()
  self._guild = NekoData.Data.guild
  self._guild.guildInfo = {}
  self._guild.guildChatData = {}
  self._guild.donateData = {}
  self._guild.guildBossData = {}
  self._guild.guildBossRed = {}
  self._guild.guildBossBattleResult = {}
  self._guild.redpointType = {}
  self._guild.unReadMessageCount = 0
  self._guild.guildacbossjump = 0
end

function DM_Guild:Clear()
  self._guild.guildInfo = {}
  self._guild.guildChatData = {}
  self._guild.donateData = {}
  self._guild.guildBossData = {}
  self._guild.guildBossRed = {}
  self._guild.guildBossBattleResult = {}
  self._guild.redpointType = {}
  self._guild.playerJob = nil
  self._guild.hesitationPeriod = nil
  self._guild.unReadMessageCount = 0
  self._guild.guildacbossjump = 0
end

function DM_Guild:SetPartyName(partyName)
  self._guild.guildInfo.partyName = partyName
end

function DM_Guild:OnSOpenGuild(protocol)
  self._guild.guildInfo.partyId = protocol.partyInfo.partyId
  self._guild.guildInfo.partyName = protocol.partyInfo.partyName
  self._guild.guildInfo.autoAcceptApply = protocol.partyInfo.autoAcceptApply
  self._guild.guildInfo.avatarId = protocol.partyInfo.avatarId
  self._guild.guildInfo.enterNum = protocol.partyInfo.enterNum
  self._guild.guildInfo.totalNum = protocol.partyInfo.totalNum
  self._guild.guildInfo.partyDeclaration = protocol.partyDeclaration
  self._guild.guildInfo.partyLv = protocol.partyInfo.partyLv
  self._guild.guildInfo.partyExp = protocol.partyInfo.partyExp
  self._guild.guildInfo.partyExpMax = CGuildAttribute:GetRecorder(self._guild.guildInfo.partyLv).GuildLeveexp
  self._guild.guildInfo.levelUpTime = protocol.crossdayInterval
  self._guild.playerJob = protocol.position
  self._guild.hesitationPeriod = protocol.hesitationPeriod
end

function DM_Guild:OnSNotifyPosition(position)
  self._guild.playerJob = position
  if self._guild.playerJob == -1 then
    self._guild.guildInfo = {}
    self._guild.guildChatData = {}
    self._guild.playerJob = nil
    self._guild.hesitationPeriod = nil
  end
end

function DM_Guild:OnSModifyAutoAccept(protocol)
  self._guild.guildInfo.autoAcceptApply = protocol.autoAcceptApply
end

function DM_Guild:OnSModifyPartyDeclaration(protocol)
  self._guild.guildInfo.partyDeclaration = protocol.partyDeclaration
end

function DM_Guild:OnSDismissParty(protocol)
  self._guild.hesitationPeriod = protocol.result
end

function DM_Guild:OnSSendHistoryChatMsg(protocol)
  local data = protocol.msgInfo
  local temp = {}
  for i, v in ipairs(data) do
    temp = {}
    if data[i - 1] then
      if v.sendTime - data[i - 1].sendTime > 120000 then
        temp.data = v
        temp.showTime = true
        table.insert(self._guild.guildChatData, temp)
      else
        local j = 1
        while self._guild.guildChatData[i - j] and not self._guild.guildChatData[i - j].showTime and not (v.sendTime - self._guild.guildChatData[i - j].data.sendTime > 300000) do
          j = j + 1
        end
        if self._guild.guildChatData[i - j] and self._guild.guildChatData[i - j].showTime then
          temp.showTime = false
        else
          temp.showTime = true
        end
        temp.data = v
        table.insert(self._guild.guildChatData, temp)
      end
    else
      temp.data = v
      temp.showTime = true
      table.insert(self._guild.guildChatData, temp)
    end
  end
end

function DM_Guild:OnSSendPartyMsg(protocol)
  local data = protocol.msgInfo
  local lenth = #self._guild.guildChatData
  local temp = {}
  if self._guild.guildChatData[lenth] then
    if data.sendTime - self._guild.guildChatData[lenth].data.sendTime > 120000 then
      temp.data = data
      temp.showTime = true
      table.insert(self._guild.guildChatData, temp)
    else
      local j = 0
      while self._guild.guildChatData[lenth - j] and not self._guild.guildChatData[lenth - j].showTime and not (data.sendTime - self._guild.guildChatData[lenth - j].data.sendTime > 300000) do
        j = j + 1
      end
      if self._guild.guildChatData[lenth - j] and self._guild.guildChatData[lenth - j].showTime then
        temp.showTime = false
      else
        temp.showTime = true
      end
      temp.data = data
      table.insert(self._guild.guildChatData, temp)
    end
  else
    temp.data = data
    temp.showTime = true
    table.insert(self._guild.guildChatData, temp)
  end
  if not DialogManager.GetDialog("guild.guilddetaildialog") then
    self._guild.unReadMessageCount = self._guild.unReadMessageCount + 1
  end
  LuaNotificationCenter.PostNotification(Common.n_OnAddNewMsg, nil, temp)
end

function DM_Guild:ClearUnReadMessageCount()
  self._guild.unReadMessageCount = 0
  LuaNotificationCenter.PostNotification(Common.n_ClientSetGuildRedpoint, nil, nil)
end

function DM_Guild:ClientCancelRedpoint()
  table.removebyvalue(self._guild.redpointType, SLightPartyRedpointProtocol.PARTY)
  LuaNotificationCenter.PostNotification(Common.n_ClientSetGuildRedpoint, nil, nil)
end

function DM_Guild:ClientCancelApplyRedpoint()
  table.removebyvalue(self._guild.redpointType, SLightPartyRedpointProtocol.PARTY_APPLY)
  LuaNotificationCenter.PostNotification(Common.n_ClientSetGuildRedpoint, nil, nil)
end

function DM_Guild:OnSLightPartyRedpoint(redpointType)
  self._guild.redpointType = redpointType
end

function DM_Guild:OnSLightPartyCancelRedpoint(type)
  table.removebyvalue(self._guild.redpointType, type)
end

function DM_Guild:OnSShowPartyDonateProcess(protocol)
  if protocol.partyId == self._guild.guildInfo.partyId then
    self._guild.donateData.process = protocol.process
    self._guild.donateData.receiveAwards = protocol.receiveAwards
    self._guild.donateData.partyCoin = protocol.partyCoin
  end
end

function DM_Guild:OnPartyBossPanelInfoProcess(protocol)
  self._guild.guildBossData = protocol
end

function DM_Guild:OnPartyBossRedProcess(protocol)
  self._guild.guildBossRed.flag = protocol.flag
end

function DM_Guild:OnPartyBossBattleResultProcess(protocol)
  self._guild.guildBossBattleResult = protocol
end

function DM_Guild:OnSPartyDonate(protocol)
  if protocol.partyId == self._guild.guildInfo.partyId then
    self._guild.donateData.process = protocol.process
    self._guild.donateData.partyCoin = protocol.partyCoin
    self._guild.guildInfo.partyExp = protocol.partyExp
  end
end

function DM_Guild:OnSReceiveDonateAward(protocol)
  if protocol.partyId == self._guild.guildInfo.partyId then
    if self._guild.donateData.receiveAwards then
      table.insert(self._guild.donateData.receiveAwards, protocol.awardId)
    else
      self._guild.donateData.receiveAwards = {
        protocol.awardId
      }
    end
  end
end

function DM_Guild:IsGotoGuildBossJump()
  return self._guild.guildacbossjump == 1
end

function DM_Guild:ClearGotoGuildBossJump()
  self._guild.guildacbossjump = 0
end

function DM_Guild:GotoGuildBossJump()
  local dialog = DialogManager.GetDialog("guild.guildmaindetail")
  if dialog then
    dialog:OnGotoGuildBossJump()
  else
    local csend = LuaNetManager.CreateProtocol("protocol.party.copenparty")
    if csend then
      csend:Send()
    end
    self._guild.guildacbossjump = 1
  end
end

return DM_Guild
