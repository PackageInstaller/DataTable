local System = require("System.System")
local GameplayBase = require("Battle.DbgEngine.GameplayBase")
local BattleConst = require("Battle.BattleConst")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleBoutMgrServerPVP = require("Battle.DbgEngine.Bout.BattleBoutMgrServerPVP")
local BattleCardMgrServerPVP = require("Battle.DbgEngine.Card.BattleCardMgrServerPVP")
local BattleAIMgrServerPVP = require("Battle.DbgEngine.AI.BattleAIMgrServerPVP")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local PvpUtil = require("Battle.Util.PvpUtil")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local PVPGameplay, _ = System.NewClass("PVPGameplay", GameplayBase)

function PVPGameplay:OnInit()
  local battleEngine = self.battleEngine
  battleEngine.boutMgr = battleEngine:AddBattleComponent(BattleBoutMgrServerPVP)
  battleEngine.cardMgr = battleEngine:AddBattleComponent(BattleCardMgrServerPVP)
  battleEngine.aiMgr = battleEngine:AddBattleComponent(BattleAIMgrServerPVP)
  battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutBegin, self.OnBeforeBoutBegin, self)
  battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutEnd, self.OnAfterBoutEnd, self)
  self.campSelectInitCard = {}
  self.campClickInitCard = {}
  self.readyPlayers = {}
  self.maxPlayerCount = 2
  self.timeoutPlayer = {}
  self:InitPlayerCount()
  self.targetModel = bc.PVPTargetModel.Client
end

function PVPGameplay:InitPlayerCount()
  local playerData = self.battleInitData[BattleConst.BattleCamp.Camp1]
  if playerData.isAI then
    self.maxPlayerCount = self.maxPlayerCount - 1
  end
  playerData = self.battleInitData[BattleConst.BattleCamp.Camp2]
  if playerData.isAI then
    self.maxPlayerCount = self.maxPlayerCount - 1
  end
end

function PVPGameplay:IsAllPlayerReady()
  return table.length(self.readyPlayers) == self.maxPlayerCount
end

function PVPGameplay:GetPlayerCamp(playerId)
  if playerId == self.battleInitData[BattleConst.BattleCamp.Camp1].playerId then
    return BattleConst.BattleCamp.Camp1
  else
    return BattleConst.BattleCamp.Camp2
  end
end

function PVPGameplay:StartBattle(playerId)
  local battleEngine = self.battleEngine
  if battleEngine:IsServerBattle() then
    if battleEngine:IsInit() then
      local camp = self:GetPlayerCamp(playerId)
      battleEngine:ReconnectBattle(camp)
    else
      self.readyPlayers[playerId] = true
      if self:IsAllPlayerReady() then
        battleEngine:__StartBattle()
      end
    end
  else
    battleEngine:__StartBattle()
  end
end

function PVPGameplay:OnInitBattle()
  self:InitCamp(BattleConst.BattleCamp.Camp1)
  self:InitCamp(BattleConst.BattleCamp.Camp2)
  if self.battleInitData.draftRelicTid then
    self.battleEngine:DebugS("OnInitBattle draftRelicTid {tid}", self.battleInitData.draftRelicTid)
    self.battleEngine.relicMgr:AddRelic(nil, self.battleInitData.draftRelicTid, nil, BattleConst.BattleCamp.Camp1)
    self.battleEngine.relicMgr:AddRelic(nil, self.battleInitData.draftRelicTid, nil, BattleConst.BattleCamp.Camp2)
  end
  self:AfterInitRole()
  self:ExeCmdAfterInitCamp()
end

function PVPGameplay:AfterInitRole()
  for _, role in ipairs(self.battleEngine.roleMgr:GetRoleList()) do
    role:AfterInit()
  end
end

function PVPGameplay:ExeCmdAfterInitCamp()
  local battleEngine = self.battleEngine
  local playerList = battleEngine.roleMgr:GetPlayerList()
  local battleBeginCmd = self:GetExeCmdAfterInitCamp()
  if battleBeginCmd and next(battleBeginCmd) and playerList and next(playerList) then
    for _, player in ipairs(playerList) do
      for _, cmd in ipairs(battleBeginCmd) do
        local cmdCtorData = {}
        cmdCtorData.cmdId = cmd
        cmdCtorData.castRoleUid = player.uid
        local cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData)
        local cardEffectConfig = {
          effectType = bc.BattleEffectType.BECreateSkillPhase,
          castRoleUid = player.uid,
          cmdServer = cmdServer
        }
        self.battleEngine.effectMgr:CreateEffect(cardEffectConfig)
      end
    end
  end
end

function PVPGameplay:GetExeCmdAfterInitCamp()
  return self.battleEngine.battleDT.GetOriginalConstant("PVPGenesisDirective") or {}
end

function PVPGameplay:StartTimeout()
  if self.battleEngine:GetSkipTimer() then
    return
  end
  local boutNumber = self.battleEngine.boutMgr:GetBoutNum()
  local timer = self.battleEngine:GetTimer()
  if timer and timer.HasTimer then
    if timer:HasTimer("PVPTurnCountdown") then
      self.battleEngine.instantRecordMgr:OnTurnCountDown(false)
    end
    local PVPTurnTime = self.battleEngine.battleDT.GetOriginalConstant("PVPTurnTime")
    local turnTime
    if boutNumber + 1 <= #PVPTurnTime then
      turnTime = PVPTurnTime[boutNumber + 1]
    else
      turnTime = PVPTurnTime[#PVPTurnTime]
    end
    local turnCountdown = self.battleEngine.battleDT.GetConstant("PVPTurnCountdown")
    timer:AddTimer("PVPTurnCountdown", turnTime - turnCountdown, function()
      self:OnTurnCountdown(turnCountdown)
    end)
    timer:AddTimer("handcardTimeout", turnTime, function()
      self:OnBoutTimeout()
    end)
    local timeoutTime = self.battleEngine.battleDT.GetConstant("PVPBattleTimeLimit") or BattleConst.PVP_FORCE_TIMEOUT
    timer:AddTimer("PVPFinishTimeout", timeoutTime, function()
      self:OnForceFinish()
    end)
    if self.battleEngine:IsServerBattle() then
      local Date = require("date")
      self.boutEndTs = Date.now() + turnTime
    end
  end
end

function PVPGameplay:GetBoutLeftTime()
  if not self.boutEndTs then
    return 0
  end
  if self.battleEngine:IsServerBattle() then
    local Date = require("date")
    return self.boutEndTs - Date.now()
  end
  return 0
end

function PVPGameplay:OnForceFinish()
  self.battleEngine:SetPassTime(0)
  self.battleEngine.effectMgr:GMStop()
  self.battleEngine.recordMgr.isRecording = false
  self.battleEngine:RunEffectOrder(function()
    self.battleEngine:ActiveBattleEnd(bc.BattleCamp.None, false, true)
  end, {}, nil)
end

function PVPGameplay:GetSelectInitCardRecord()
  if not self.campSelectInitCard[bc.BattleCamp.Camp1] and not self.campSelectInitCard[bc.BattleCamp.Camp2] then
    return
  end
  for _, camp in ipairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    if not self.campSelectInitCard[camp] then
      local player = self.battleEngine.roleMgr:GetPlayer(camp)
      local campCardData = self.battleEngine.cardMgr:GetCampCardData(camp)
      local cardUids = {}
      for _, cardUid in ipairs(campCardData[bc.CardDeck.SelectInitDeck]) do
        table.insert(cardUids, cardUid)
      end
      self.battleEngine.recordMgr:OnSelectInitCard(player.uid, cardUids)
    end
  end
end

function PVPGameplay:OnAfterBattleBegin()
  self:StartCardSelection()
end

function PVPGameplay:StartOpeningDialogue()
  local camp1Awakers = self:GetCampAwakerList(bc.BattleCamp.Camp1)
  local camp2Awakers = self:GetCampAwakerList(bc.BattleCamp.Camp2)
  local dialogueList = self:FilterOpeningDialogues(camp1Awakers, camp2Awakers)
  self._openingDialogue = {
    active = true,
    isRelation = #dialogueList > 0,
    skipped = {
      [bc.BattleCamp.Camp1] = false,
      [bc.BattleCamp.Camp2] = false
    }
  }
  if 0 == #dialogueList then
    local camp1Dialogues = self:GetNormalDialogues(camp1Awakers)
    local camp2Dialogues = self:GetNormalDialogues(camp2Awakers)
    if #camp1Dialogues > 0 or #camp2Dialogues > 0 then
      self:PlayNormalDialogues(camp1Dialogues, camp2Dialogues)
    else
      self:StartBattleBout()
    end
    return
  end
  local selectedDialogue = dialogueList[self.battleEngine.rand:random(1, #dialogueList)]
  self._openingDialogue.cur = selectedDialogue.ID
  self:PlayRelationDialogue(selectedDialogue)
end

function PVPGameplay:GetCampAwakerList(camp)
  local awakerList = {}
  local roleList = self.battleEngine.roleMgr:GetPVPRoleList("AliveOnly", camp)
  for _, role in ipairs(roleList or {}) do
    if role.roleType == bc.RoleType.Awaker then
      table.insert(awakerList, role.tid)
    end
  end
  return awakerList
end

function PVPGameplay:FilterOpeningDialogues(camp1Awakers, camp2Awakers)
  local relationDialogues = {}
  self.battleEngine.battleDT:LoopTable("PVPOpeningVoice", function(ID, dialogue)
    if 1 == dialogue.IllustrateType and 1 == dialogue.FollowUpVoice then
      local awakerID = dialogue.AwakerID
      local reletedAwaker = dialogue.ReletedAwaker
      local firstSpeakerCamp
      if table.contains(camp1Awakers, awakerID) and table.contains(camp2Awakers, reletedAwaker) then
        firstSpeakerCamp = bc.BattleCamp.Camp1
      elseif table.contains(camp2Awakers, awakerID) and table.contains(camp1Awakers, reletedAwaker) then
        firstSpeakerCamp = bc.BattleCamp.Camp2
      end
      if firstSpeakerCamp then
        local dialogueWithCamp = table.deepclone(dialogue)
        dialogueWithCamp.firstSpeakerCamp = firstSpeakerCamp
        table.insert(relationDialogues, dialogueWithCamp)
      end
    end
  end)
  return relationDialogues
end

function PVPGameplay:GetNormalDialogues(camp1Awakers)
  local normalDialogues = {}
  self.battleEngine.battleDT:LoopTable("PVPOpeningVoice", function(ID, dialogue)
    if 0 == dialogue.IllustrateType and dialogue.TriggerConditions and table.contains(dialogue.TriggerConditions, "PlayerEnter") then
      local awakerID = dialogue.AwakerID
      if table.contains(camp1Awakers, awakerID) then
        table.insert(normalDialogues, dialogue)
      end
    end
  end)
  return normalDialogues
end

function PVPGameplay:PlayNormalDialogues(camp1Dialogues, camp2Dialogues)
  local battleEngine = self.battleEngine
  local selectedCamp1Dialogue, selectedCamp2Dialogue
  if #camp1Dialogues > 0 then
    selectedCamp1Dialogue = camp1Dialogues[self.battleEngine.rand:random(1, #camp1Dialogues)]
  end
  if #camp2Dialogues > 0 then
    selectedCamp2Dialogue = camp2Dialogues[self.battleEngine.rand:random(1, #camp2Dialogues)]
  end
  local camp1VoiceID = selectedCamp1Dialogue and selectedCamp1Dialogue.ID or nil
  local camp2VoiceID = selectedCamp2Dialogue and selectedCamp2Dialogue.ID or nil
  if self._openingDialogue and self._openingDialogue.skipped[bc.BattleCamp.Camp1] then
    camp1VoiceID = nil
  end
  if self._openingDialogue and self._openingDialogue.skipped[bc.BattleCamp.Camp2] then
    camp2VoiceID = nil
  end
  battleEngine.recordMgr:OnPlayNormalDialogues(camp1VoiceID, camp2VoiceID)
  if self._openingDialogue then
    self._openingDialogue.active = false
  end
  self:StartBattleBout()
end

function PVPGameplay:PlayRelationDialogue(dialogue)
  local battleEngine = self.battleEngine
  local firstCamp = dialogue.firstSpeakerCamp or self:GetAwakerCamp(dialogue.AwakerID)
  if not (self._openingDialogue and self._openingDialogue.isRelation) or not self._openingDialogue.skipped[firstCamp] then
    battleEngine.recordMgr:OnPlayOpeningDialogue(firstCamp, dialogue.ID)
  end
  if self._openingDialogue then
    self._openingDialogue.active = false
  end
  self:StartBattleBout()
end

function PVPGameplay:StartCardSelection()
  local battleEngine = self.battleEngine
  self:StartTimeout()
  
  local function preFunc()
    local camp1Player = battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local camp1CardUids = battleEngine.cardMgr:GetSelectInitCard(bc.BattleCamp.Camp1)
    self.battleEngine.recordMgr:OnSelectInitCard(camp1Player.uid, camp1CardUids)
    local camp2Player = battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp2)
    local camp2CardUids = battleEngine.cardMgr:GetSelectInitCard(bc.BattleCamp.Camp2)
    self.battleEngine.recordMgr:OnSelectInitCard(camp2Player.uid, camp2CardUids)
  end
  
  local finishCb = {}
  battleEngine:RunEffectOrder(preFunc, finishCb)
end

function PVPGameplay:OnAfterSelectInitCard()
  local battleEngine = self.battleEngine
  self:StartOpeningDialogue()
end

function PVPGameplay:StartBattleBout()
  local battleEngine = self.battleEngine
  battleEngine.boutMgr:BeginBout()
end

function PVPGameplay:OnBattleFinishPlayerData(comp, battleFinishData)
  local data = table.deepclone(self.battleInitData[comp])
  if not data or not battleFinishData then
    return
  end
  if comp == BattleConst.BattleCamp.Camp1 then
    data.playFirst = 1
  end
  data.cards = nil
  data.roleData = nil
  data.keeperSkillList = nil
  data.weaponList = nil
  if battleFinishData.playerList then
    table.insert(battleFinishData.playerList, data)
  end
  if data.teamData and battleFinishData.playerTeam then
    battleFinishData.playerTeam[data.playerId] = data.teamData
  end
end

function PVPGameplay:OnBattleFinish(winCamp, battleFinishData)
  local battleEngine = self.battleEngine
  local timer = battleEngine:GetTimer()
  if timer then
    timer:RemoveTimer("PVPTurnCountdown")
    timer:RemoveTimer("handcardTimeout")
  end
  battleFinishData.battleTid = self.battleEngine:GetBattleTid()
  battleFinishData.stateList = nil
  battleFinishData.actorAttrs = nil
  battleFinishData.syncAttrs = nil
  battleFinishData.dimensionCards = nil
  battleFinishData.destroyedCards = nil
  battleFinishData.enternalCards = nil
  battleFinishData.playerList = {}
  battleFinishData.playerTeam = {}
  battleFinishData.endType = self.battleEngine:GetFinishType()
  battleFinishData.isMoreGame = self.battleInitData.isMoreGame
  battleFinishData.isFriendGame = self.battleInitData.isFriendGame
  battleFinishData.draftRelicTid = self.battleInitData.draftRelicTid
  battleFinishData.draftChoices = self.battleInitData.draftChoices
  battleFinishData.pvpType = self.battleInitData.pvpType
  if self.battleEngine:GetSvrBattleEntity() then
    local Date = require("date")
    battleFinishData.battleDuration = Date.second() - self.battleEngine:GetStartTime()
  end
  self:OnBattleFinishPlayerData(BattleConst.BattleCamp.Camp1, battleFinishData)
  self:OnBattleFinishPlayerData(BattleConst.BattleCamp.Camp2, battleFinishData)
  local player = self.battleEngine.roleMgr:GetPlayer(winCamp)
  if player then
    battleFinishData.winUid = player.data.playerId
    self.battleEngine:Debug("-------------- win:", battleFinishData.winUid)
  end
  battleFinishData.pvpMatchData = self.battleInitData.pvpMatchData
  self:CalcScore(battleFinishData)
  battleEngine:PlayerRpc("BattleFlow", "OnBattleFinish", battleFinishData)
end

function PVPGameplay:CalcScore(battleFinishData)
  if battleFinishData.timeout then
    return
  end
  local pvpMatchData = battleFinishData.pvpMatchData
  if not pvpMatchData then
    return
  end
  local DT = self.battleEngine.battleDT
  local logger = self.battleEngine.logger
  local limitScore = PvpUtil.GetScoreLimit(self.battleEngine.battleDT)
  local result = {}
  for uid, playerInfo in pairs(pvpMatchData) do
    if uid == battleFinishData.winUid then
      local addScore = PvpUtil.CalcWinScore(DT, logger, uid, pvpMatchData)
      playerInfo.finalScore = math.min(limitScore, playerInfo.score + addScore)
    else
      local addScore = PvpUtil.CalcLoseScore(DT, logger, uid, pvpMatchData)
      if playerInfo.score > 0 then
        playerInfo.finalScore = math.max(1, playerInfo.score - addScore)
      else
        playerInfo.finalScore = 0
      end
    end
    result[uid] = playerInfo.finalScore
  end
  self.logger:InfoS("CalcPvpScore {result}", table.tostring(result))
end

function PVPGameplay:CalcInitProperty(awakerConfig, propertyName)
  if not awakerConfig then
    return
  end
  if propertyName == BP.hp then
    do return math.ceil end
    return math.ceil, awakerConfig.PVPHP
  end
  if awakerConfig[propertyName] then
    do return math.ceil end
    return math.ceil, awakerConfig[propertyName]
  end
end

function PVPGameplay:LoadAwakerConfigProperties(tid)
  local DT = self.battleEngine.battleDT
  local properties = {}
  local awakerConfig = DT.AwakerConfig[tid]
  properties[BP.hp] = math.ceil(awakerConfig.PVPHP)
  properties[BP.max_hp] = properties[BP.hp]
  properties[BP.ulti_energy_max] = bc.UltiEnergyPerSkill
  return properties
end

function PVPGameplay:InitCamp(camp)
  local DT = self.battleEngine.battleDT
  local roleMgr = self.battleEngine.roleMgr
  local playerData = self.battleInitData[camp]
  local player = {
    uid = self.battleEngine:GenUid(),
    lives = 1,
    camp = camp,
    properties = {
      [BP.max_energy] = 3,
      [BP.relic_num_limit] = 8
    },
    roleType = BattleConst.RoleType.Player,
    playerId = playerData.playerId,
    gender = playerData.gender,
    icon = playerData.icon,
    playerName = playerData.playerName,
    level = 1,
    respawnedNum = 0,
    isAI = playerData.isAI,
    schoolConfigId = playerData.schoolConfigId
  }
  roleMgr:SpawnPlayer(player)
  local cardDataList = {}
  for i, awaker in ipairs(playerData.roleData) do
    awaker.battleFieldPos = awaker.index or i
    local awakerCfg = DT.AwakerConfig[awaker.tid]
    awaker.slots = {}
    for _, skillID in ipairs(awakerCfg.PVPSkillList) do
      table.insert(awaker.slots, {tid = skillID, level = 1})
    end
    awaker.uid = self.battleEngine:GenUid()
    awaker.lives = awaker.lives or 1
    awaker.camp = camp
    awaker.roleType = BattleConst.RoleType.Awaker
    awaker.level = awaker.level or 1
    awaker.schoolConfigId = awakerCfg.School
    roleMgr:SpawnAwaker(awaker)
  end
  for _, keeperSkill in ipairs(playerData.keeperSkillList or {}) do
    local itemCfg = DT.Item[keeperSkill.tid]
    local skillId = itemCfg and itemCfg.PVPSkill and itemCfg.PVPSkill[1]
    local skillCfg = skillId and DT.Skill[skillId]
    if skillCfg then
      local cardData = self:__GenerateCard(skillCfg, camp, {
        level = keeperSkill.level
      })
      table.insert(cardDataList, cardData)
    end
  end
  for _, weaponSkill in ipairs(playerData.weaponList or {}) do
    local itemCfg = DT.Item[weaponSkill.tid]
    local skillId = itemCfg and itemCfg.PVPSkill and itemCfg.PVPSkill[1]
    local skillCfg = skillId and DT.Skill[skillId]
    if skillCfg then
      local cardData = self:__GenerateCard(skillCfg, camp, {
        level = weaponSkill.level
      })
      table.insert(cardDataList, cardData)
    end
  end
  for _, playerCard in ipairs(playerData.cards) do
    local data = DT.Skill[playerCard.tid]
    if data and not table.contains(data.Type, bc.SkillType.Ulti_Skill) then
      local cardData = self:__GenerateCard(data, camp, playerCard)
      table.insert(cardDataList, cardData)
    end
  end
  self.battleEngine.cardMgr:InitAllCards(cardDataList)
end

function PVPGameplay:__GenerateCard(data, camp, playerCard)
  local deck = bc.CardDeck.DrawDeck
  local cardData = {
    uid = self.battleEngine:GenUid(),
    tid = data.ID,
    level = playerCard.level or 1,
    deck = deck,
    slot = playerCard.slot,
    awaker = playerCard.awaker,
    ts = playerCard.ts,
    camp = camp
  }
  return cardData
end

function PVPGameplay:OnBeforeBoutBegin()
  local battleEngine = self.battleEngine
  local boutMgr = battleEngine.boutMgr
  local boutNumber = boutMgr:GetBoutNum()
  local camp = boutMgr:GetCurCamp()
  local player = battleEngine.roleMgr:GetPlayer(camp)
  local extraData = {
    castRoleUid = player.uid,
    reason = bc.PropertyChangeReason.AttrModify
  }
  if boutNumber > 1 and player:GetProperty(bc.BattleProperty.max_energy) < 10 then
    player:ChangeProperty(bc.BattleProperty.max_energy, 1, extraData)
  end
  local curMaxEnergy = player:GetProperty(BP.max_energy)
  player:ChangeProperty(bc.BattleProperty.energy, curMaxEnergy, extraData)
  player:SetBoutAct(false)
  self:StartTimeout()
end

function PVPGameplay:OnTurnCountdown(duration)
  self.battleEngine.instantRecordMgr:OnTurnCountDown(true, duration)
end

function PVPGameplay:OnHandcardTimeout()
  for _, camp in ipairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    self:OnSelectInitCard(camp, {
      selectUids = self.campClickInitCard[camp] or {}
    })
  end
end

function PVPGameplay:OnSelectInitCard(camp, msgData)
  if self.campSelectInitCard[camp] then
    return
  end
  local battleEngine = self.battleEngine
  self.campSelectInitCard[camp] = true
  
  local function preFunc()
    battleEngine.cardMgr:DiscardInitCard(camp, msgData.selectUids)
    battleEngine.cardMgr:MoveSelectInitCard(camp)
  end
  
  local finishCb = {}
  if self.campSelectInitCard[bc.BattleCamp.Camp1] and self.campSelectInitCard[bc.BattleCamp.Camp2] then
    finishCb = {
      func = self.OnAfterSelectInitCard,
      target = self,
      data = {}
    }
  end
  battleEngine:RunEffectOrder(preFunc, finishCb)
end

function PVPGameplay:OnClickInitCard(camp, msgData)
  if self.campSelectInitCard[camp] then
    return
  end
  self.campClickInitCard[camp] = msgData.selectUids
end

function PVPGameplay:OnBoutTimeout()
  local battleEngine = self.battleEngine
  local waitingCommand, yieldData = self.battleEngine.effectMgr:GetEffectOrderInterrupted()
  if waitingCommand then
    if waitingCommand == BattleCommand.lg_SelectTargets and yieldData.cancelable then
      battleEngine:OnReceiveCommand(BattleCommand.lg_CancelSelectTargets, yieldData)
    else
      battleEngine:SetTimeoutFlag(true)
      battleEngine.robotMgr:WaitingCommand(waitingCommand, yieldData)
      battleEngine:SetTimeoutFlag(false)
    end
  end
  local curCamp = battleEngine.boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.None then
    for _, camp in ipairs({
      bc.BattleCamp.Camp1,
      bc.BattleCamp.Camp2
    }) do
      self:OnSelectInitCard(camp, {
        selectUids = self.campClickInitCard[camp] or {}
      })
    end
    return
  end
  local playerId = battleEngine.boutMgr:GetBoutPlayerId()
  local player = battleEngine.roleMgr:GetRoleByPlayerId(playerId)
  player:AddTimeoutTimes()
  local camp = player:GetCamp()
  local timesLimit = self.battleEngine.battleDT.GetConstant("PVPProcrastinateBout") or bc.PVPTimeoutTimesLimit
  if timesLimit <= player:GetTimeoutTimes() then
    self.battleEngine:RunEffectOrder(function()
      self.battleEngine:ActiveBattleEnd(bc.BattleCamp:GetEnemyCamp(camp))
    end, {}, nil)
    return
  end
  self.battleEngine.boutMgr:EndBout()
end

function PVPGameplay:OnAfterBoutEnd()
  local battleEngine = self.battleEngine
  local boutMgr = battleEngine.boutMgr
  local camp = boutMgr:GetCurCamp()
  local player = battleEngine.roleMgr:GetPlayer(camp)
  local extraData = {
    reason = bc.PropertyChangeReason.AttrModify
  }
  player:SetProperty(bc.BattleProperty.energy, 0, extraData)
end

function PVPGameplay:GetAwakerCamp(awakerTid)
  local roleList1 = self.battleEngine.roleMgr:GetPVPRoleList("AliveOnly", bc.BattleCamp.Camp1) or {}
  for _, r in ipairs(roleList1) do
    if r.tid == awakerTid then
      return bc.BattleCamp.Camp1
    end
  end
  local roleList2 = self.battleEngine.roleMgr:GetPVPRoleList("AliveOnly", bc.BattleCamp.Camp2) or {}
  for _, r in ipairs(roleList2) do
    if r.tid == awakerTid then
      return bc.BattleCamp.Camp2
    end
  end
  return bc.BattleCamp.None
end

return PVPGameplay
