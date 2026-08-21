-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_guild.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGuildAttribute = (BeanManager.GetTableByName)("guild.cguildattribute")
local SLightPartyRedpointProtocol = require("protocols.def.protocol.party.slightpartyredpoint")
local DM_Guild = class("DM_Guild")
DM_Guild.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._guild = (NekoData.Data).guild
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildInfo = {}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildChatData = {}
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).donateData = {}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossData = {}
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossRed = {}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossBattleResult = {}
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).redpointType = {}
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).unReadMessageCount = 0
end

DM_Guild.Clear = function(self)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self._guild).guildInfo = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildChatData = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).donateData = {}
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossData = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossRed = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).guildBossBattleResult = {}
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).redpointType = {}
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).playerJob = nil
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).hesitationPeriod = nil
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._guild).unReadMessageCount = 0
end

DM_Guild.OnSOpenGuild = function(self, protocol)
  -- function num : 0_2 , upvalues : CGuildAttribute
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self._guild).guildInfo).partyId = (protocol.partyInfo).partyId
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).partyName = (protocol.partyInfo).partyName
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).autoAcceptApply = (protocol.partyInfo).autoAcceptApply
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).avatarId = (protocol.partyInfo).avatarId
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).enterNum = (protocol.partyInfo).enterNum
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).totalNum = (protocol.partyInfo).totalNum
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).partyDeclaration = protocol.partyDeclaration
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).partyLv = (protocol.partyInfo).partyLv
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).partyExp = (protocol.partyInfo).partyExp
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).partyExpMax = (CGuildAttribute:GetRecorder(((self._guild).guildInfo).partyLv)).GuildLeveexp
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self._guild).guildInfo).levelUpTime = protocol.crossdayInterval
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._guild).playerJob = protocol.position
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._guild).hesitationPeriod = protocol.hesitationPeriod
end

DM_Guild.OnSNotifyPosition = function(self, position)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._guild).playerJob = position
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if (self._guild).playerJob == -1 then
    (self._guild).guildInfo = {}
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._guild).guildChatData = {}
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._guild).playerJob = nil
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._guild).hesitationPeriod = nil
  end
end

DM_Guild.OnSModifyAutoAccept = function(self, protocol)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._guild).guildInfo).autoAcceptApply = protocol.autoAcceptApply
end

DM_Guild.OnSModifyPartyDeclaration = function(self, protocol)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._guild).guildInfo).partyDeclaration = protocol.partyDeclaration
end

DM_Guild.OnSDismissParty = function(self, protocol)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._guild).hesitationPeriod = protocol.result
end

DM_Guild.OnSSendHistoryChatMsg = function(self, protocol)
  -- function num : 0_7 , upvalues : _ENV
  local data = protocol.msgInfo
  local temp = {}
  for i,v in ipairs(data) do
    temp = {}
    if data[i - 1] then
      if v.sendTime - (data[i - 1]).sendTime > 120000 then
        temp.data = v
        temp.showTime = true
        ;
        (table.insert)((self._guild).guildChatData, temp)
      else
        local j = 1
        while ((self._guild).guildChatData)[i - j] and not (((self._guild).guildChatData)[i - j]).showTime and v.sendTime - ((((self._guild).guildChatData)[i - j]).data).sendTime <= 300000 do
          j = j + 1
        end
        if ((self._guild).guildChatData)[i - (j)] and (((self._guild).guildChatData)[i - (j)]).showTime then
          temp.showTime = false
        else
          temp.showTime = true
        end
        temp.data = v
        ;
        (table.insert)((self._guild).guildChatData, temp)
      end
    else
      do
        do
          temp.data = v
          temp.showTime = true
          ;
          (table.insert)((self._guild).guildChatData, temp)
          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DM_Guild.OnSSendPartyMsg = function(self, protocol)
  -- function num : 0_8 , upvalues : _ENV
  local data = protocol.msgInfo
  local lenth = #(self._guild).guildChatData
  local temp = {}
  if ((self._guild).guildChatData)[lenth] then
    if data.sendTime - ((((self._guild).guildChatData)[lenth]).data).sendTime > 120000 then
      temp.data = data
      temp.showTime = true
      ;
      (table.insert)((self._guild).guildChatData, temp)
    else
      local j = 0
      while ((self._guild).guildChatData)[lenth - j] and not (((self._guild).guildChatData)[lenth - j]).showTime and data.sendTime - ((((self._guild).guildChatData)[lenth - j]).data).sendTime <= 300000 do
        j = j + 1
      end
      if ((self._guild).guildChatData)[lenth - (j)] and (((self._guild).guildChatData)[lenth - (j)]).showTime then
        temp.showTime = false
      else
        temp.showTime = true
      end
      temp.data = data
      ;
      (table.insert)((self._guild).guildChatData, temp)
    end
  else
    do
      temp.data = data
      temp.showTime = true
      ;
      (table.insert)((self._guild).guildChatData, temp)
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

      if not (DialogManager.GetDialog)("guild.guilddetaildialog") then
        (self._guild).unReadMessageCount = (self._guild).unReadMessageCount + 1
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_OnAddNewMsg, nil, temp)
    end
  end
end

DM_Guild.ClearUnReadMessageCount = function(self)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._guild).unReadMessageCount = 0
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ClientSetGuildRedpoint, nil, nil)
end

DM_Guild.ClientCancelRedpoint = function(self)
  -- function num : 0_10 , upvalues : _ENV, SLightPartyRedpointProtocol
  (table.removebyvalue)((self._guild).redpointType, SLightPartyRedpointProtocol.PARTY)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ClientSetGuildRedpoint, nil, nil)
end

DM_Guild.ClientCancelApplyRedpoint = function(self)
  -- function num : 0_11 , upvalues : _ENV, SLightPartyRedpointProtocol
  (table.removebyvalue)((self._guild).redpointType, SLightPartyRedpointProtocol.PARTY_APPLY)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ClientSetGuildRedpoint, nil, nil)
end

DM_Guild.OnSLightPartyRedpoint = function(self, redpointType)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._guild).redpointType = redpointType
end

DM_Guild.OnSLightPartyCancelRedpoint = function(self, type)
  -- function num : 0_13 , upvalues : _ENV
  (table.removebyvalue)((self._guild).redpointType, type)
end

DM_Guild.OnSShowPartyDonateProcess = function(self, protocol)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.partyId == ((self._guild).guildInfo).partyId then
    ((self._guild).donateData).process = protocol.process
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._guild).donateData).receiveAwards = protocol.receiveAwards
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._guild).donateData).partyCoin = protocol.partyCoin
  end
end

DM_Guild.OnPartyBossPanelInfoProcess = function(self, protocol)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._guild).guildBossData = protocol
end

DM_Guild.OnPartyBossRedProcess = function(self, protocol)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self._guild).guildBossRed).flag = protocol.flag
end

DM_Guild.OnPartyBossBattleResultProcess = function(self, protocol)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._guild).guildBossBattleResult = protocol
end

DM_Guild.OnSPartyDonate = function(self, protocol)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if protocol.partyId == ((self._guild).guildInfo).partyId then
    ((self._guild).donateData).process = protocol.process
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._guild).donateData).partyCoin = protocol.partyCoin
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self._guild).guildInfo).partyExp = protocol.partyExp
  end
end

DM_Guild.OnSReceiveDonateAward = function(self, protocol)
  -- function num : 0_19 , upvalues : _ENV
  if protocol.partyId == ((self._guild).guildInfo).partyId then
    if ((self._guild).donateData).receiveAwards then
      (table.insert)(((self._guild).donateData).receiveAwards, protocol.awardId)
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self._guild).donateData).receiveAwards = {protocol.awardId}
    end
  end
end

return DM_Guild

