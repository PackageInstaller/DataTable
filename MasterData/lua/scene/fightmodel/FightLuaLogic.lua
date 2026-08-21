local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local FH = require("Logic/HelpLogic")
local DEFINE = require("Logic/Define")
local DoFirstPoseAction = 1000
local FightLuaLogic, FightRoundBase, FightConfig, ActorManager, ResourceManager, m_selfTeam, m_runBackTick, m_effectData, m_dungeonType, m_isRecordFight

function InitGlobalSingleton()
  FightLuaLogic = CS.FightLuaLogic.Instance
  FightConfig = CS.FightConfig.Instance
  FightRoundBase = CS.FightRoundBase.Instance
  ActorManager = CS.ActorManager.Instance
  ResourceManager = CS.ResourceManager.Instance
end

function InitGameLogic()
  InitGlobalSingleton()
  if __EditorMode and FightConfig.m_GameMode == CS.GAME_MODE.GM_RECORD then
    if FightConfig.m_recordJSON:IsNull() then
      error("GM_RECORD", "\229\164\141\231\155\152\230\149\176\230\141\174\233\133\141\231\189\174\230\150\135\228\187\182\228\184\186\231\169\186\239\188\129")
      return
    else
      local recordJSON = JsonD(FightConfig.m_recordJSON.text)
      if recordJSON then
        FightConfig:DisableAllDebugOption()
        CS.GameLoading.Instance.StageName = tostring(recordJSON.dungeon.baseInfo.dungeonId)
        FightConfig.m_TestDungeonType = recordJSON.dungeon.baseInfo.dungeonType
        FightConfig.m_TestStage = recordJSON.dungeon.baseInfo.dungeonId
        this:SetData("playerId", "RecordPlayer")
        WU.SyncActorAttr(recordJSON.dungeon.baseInfo)
        this:SetData("Dungeon/DungeonUid", recordJSON.dungeon.dungeonUid)
        this:SetData("FightSelfTeam", 1)
        this:SetData("FightDungeonType", recordJSON.dungeon.baseInfo.dungeonType)
        this:SetData("WindowDungeon/DungeonId", recordJSON.dungeon.baseInfo.dungeonId)
        if not FightConfig.m_manualControl then
          this:SetData("FightDataRecord", recordJSON.fightActiveData)
        end
      end
    end
  end
  local playerId = this:GetData("playerId") or ""
  FightLuaLogic.mPlayerID = playerId
  info("GameLogic", "1---- mPlayerID = " .. playerId)
  CS.SceneFight.s_Standalone = playerId == ""
  local randomSeed = 0
  local fightDataRecord = this:GetData("FightDataRecord")
  m_isRecordFight = fightDataRecord ~= nil
  if fightDataRecord then
    FightLuaLogic.fightRecordDataLua = fightDataRecord
    randomSeed = fightDataRecord.initSeed
  end
  local initGameInput = REF.InitGameInputModel["$CreateModel"](randomSeed)
  local selfTeam = this:GetData("FightSelfTeam") or FightConfig.m_TestTeam
  FightLuaLogic.mSelfTeam = selfTeam
  m_selfTeam = selfTeam
  m_dungeonType = initGameInput.dungeonType
  local dungeonTypeCondi = m_dungeonType == PB.enum.DungeonType.BurstLinkPvp or m_dungeonType == PB.enum.DungeonType.FriendPvp or m_dungeonType == PB.enum.DungeonType.RD
  CS.GameLogic.g_Team1Left = fif(dungeonTypeCondi and selfTeam == 2, false, true)
  FightLuaLogic.mDungeonType = m_dungeonType
  this:SetData("FightNetModeLeaveReason", nil)
  FightLuaLogic.mTeamCardData[0] = CS.RoundTeamInfo()
  FightLuaLogic.mTargetTable = REF.TargetLogic["$initTarget"](initGameInput)
  if CS.GameLogic.IsLocalMode() then
    local fightActiveData = REF.MainLogic["$initGame"](initGameInput)
    FightLuaLogic:ReceiveGameInitWrap(fightActiveData)
  else
    local message = {
      request = initGameInput,
      dungeonId = this:GetData("Dungeon/DungeonUid") or 0
    }
    this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsInitGameReq", message)
  end
end

function InitLogicData()
  local actorConfig = PB.all("ActorConfig")
  for i = 1, #actorConfig do
    local ac = actorConfig[i]
    CS.ActionLogicDataManager.LoadActionLogicData(ac.logicRes)
    CS.ActionLogicDataManager.LogicDataOptimization(ac.logicRes, ac.id, ac.kind == PB.enum.ActorType.Main)
  end
  local uniqueWeaponSkill = PB.all("UniqueWeaponSkill")
  for i = 1, #uniqueWeaponSkill do
    local us = uniqueWeaponSkill[i]
    CS.ActionLogicDataManager.LoadActionLogicData(us.logicRes)
    CS.ActionLogicDataManager.LogicDataOptimization(us.logicRes, us.weaponSkillId, false)
  end
end

function InitEffectData()
  m_effectData = {}
  local buffDataAll = PB.all("BuffData")
  for k, buffData in pairs(buffDataAll) do
    local name = string.trim(buffData.hitEffect)
    if name ~= "" then
      local effectObjectData = CS.EffectObjectData()
      effectObjectData.Name = "buff/" .. name
      effectObjectData.OffPosition = CS.Vector2Proto()
      effectObjectData.OffPosition.X = buffData.hitX
      effectObjectData.OffPosition.Y = buffData.hitY
      effectObjectData.Binding = buffData.hitBind
      effectObjectData.Start = buffData.hitDelay
      m_effectData[tostring(buffData.id) .. tostring(buffData.owner) .. "h"] = effectObjectData
    end
    name = string.trim(buffData.loopEffect)
    if name ~= "" then
      local effectObjectData = CS.EffectObjectData()
      effectObjectData.Name = "buff/" .. name
      effectObjectData.Position = CS.Vector2Proto()
      effectObjectData.Position.X = buffData.hitX
      effectObjectData.Position.Y = buffData.hitY
      effectObjectData.DurationBinding = true
      effectObjectData.Binding = true
      effectObjectData.BehindRole = buffData.loopLayer
      m_effectData[tostring(buffData.id) .. tostring(buffData.owner) .. "l"] = effectObjectData
    end
  end
  local effectObjectData = CS.EffectObjectData()
  effectObjectData.Name = "common/P_HuiheTishi_01"
  effectObjectData.Position = CS.Vector2Proto()
  effectObjectData.Position.X = 0
  effectObjectData.Position.Y = 425
  effectObjectData.DurationBinding = true
  effectObjectData.Binding = true
  m_effectData.TopActorDiamondEffect = effectObjectData
  effectObjectData = CS.EffectObjectData()
  effectObjectData.Name = "cmr91/cmr91_DeadGold_01"
  effectObjectData.Binding = false
  m_effectData.GoldenRobotDead = effectObjectData
end

function UpdateWaitCard()
  local fightActiveData = REF.MainLogic["$fightActiveData"]()
  local roundTeamInfo = FH.getTeamInfo(fightActiveData.teamList, fightActiveData.activeTeam)
  local cardState = FightLuaLogic:GetTeamCardData(fightActiveData.activeTeam).CardState
  if 2 <= cardState then
    FightRoundBase:SetRoundStep(CS.RoundStep.WaitRoundEnd)
    if m_selfTeam == fightActiveData.activeTeam and roundTeamInfo.cardShowDelay >= 0 and FightLuaLogic:IsActivePlayer() then
      FightLuaLogic.mFightRoundSandBox.ResetRoundTime(roundTeamInfo.cardCountDown)
      if (cardState == 2 or cardState == 3) and not FightRoundBase.m_autoFight then
        local activeActorList = fightActiveData.activeActorList
        for i = 1, #activeActorList do
          local uniqueId = activeActorList[i]
          DoPoseAction(uniqueId + DoFirstPoseAction)
          local actorProcess = ActorManager:GetActorInfo(uniqueId)
          if actorProcess then
            actorProcess.m_stateManager:AddBuffEffect(m_effectData.TopActorDiamondEffect)
          end
        end
      end
    end
  end
end

function UpdateOneShow()
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    actorProcess:BroadcastActorUIActive(false)
    local stateFSM = actorProcess.m_stateManager
    local isPose = stateFSM:CurStateCheck("ActorStatePose")
    if isPose then
      stateFSM:SendStandByActionCommand()
    end
  end
end

function UpdateRoundBuff()
  if not IsAllActorReady() then
    return
  end
  RefreshAllActorHpBuff(PB.enum.BuffFightType.HpChange)
  RefreshAllActorOnceHpChangeBuff()
  CheckAllActorState(false)
  ActorManager:ResetAllActorState()
  RefreshAllActorBuff(true)
  ResetAllActorStandPos()
  FightRoundBase:SetRoundStep(CS.RoundStep.WaitCard)
end

function UpdateWaitOneEnd(delta)
  if not IsAllActorReady() then
    m_runBackTick = m_runBackTick + delta
    if 1.0 <= m_runBackTick then
      m_runBackTick = 0
      ActorManager:AllActorRunBack(FightRoundBase.m_lastActorList)
      TemporaryFix()
    end
    return
  end
  FightRoundBase:SetRoundStep(CS.RoundStep.WaitRoundEnd)
  RefreshAllActorHpBuff(PB.enum.BuffFightType.ActionFeedBack)
  RefreshAllActorOnceHpChangeBuff()
  ActorManager:ResetAllActorState()
  ResetAllActorStandPos()
end

function UpdateWaitBulletEnd()
  FightLuaLogic.mFightRoundSandBox.OnSetBGCamera(true)
  m_runBackTick = 1.0
end

function UpdateRoundEnd()
  local winTeam = FightLuaLogic.WinTeam
  if winTeam ~= 0 then
    FightRoundBase:SetFightOver()
    FightRoundBase:SetRoundStep(CS.RoundStep.WinPose)
    info("GamePlay", "WinTeam = " .. tostring(winTeam))
    local isSelfWin = winTeam == m_selfTeam
    local fightActiveData = REF.MainLogic["$fightActiveData"]()
    local displayDefeatedTeam = fif(isSelfWin, FightLuaLogic.EnemyTeam, m_selfTeam)
    local dict = FightLuaLogic.mActorData
    for actorProcess, roundActorInfo in pairs(dict) do
      actorProcess:BroadcastActorUIActive(false)
      if actorProcess:IsGameLogicActor() then
        if roundActorInfo.team == displayDefeatedTeam then
          FightRoundBase.m_slowGameEnd = false
          actorProcess:NotifyActorDead()
          actorProcess:SetActorDeadPhysics(2)
        elseif not actorProcess:IsActorStand() then
          actorProcess.m_stateManager:SendStandByActionCommand()
        end
      end
    end
    local position = {hideUI = true}
    this:SetData("FightUI/Position", position)
    local talk = {hideUI = true}
    this:SetData("FightUI/FightTalk", talk)
    FightLuaLogic.mFightRoundSandBox.HideSelfUI(true)
    info("GameLogic", "Game End")
    if m_isRecordFight then
      local inputEmpty = true
      local fightDataRecord = this:GetData("FightDataRecord")
      for ti = 1, #fightDataRecord.teamList do
        local roundTeamInfoRec = fightDataRecord.teamList[ti]
        if 0 < #roundTeamInfoRec.statistic.inputList then
          inputEmpty = false
          break
        end
      end
      if inputEmpty then
        info("GameLogic", "[----------REPLAY----------]    Succeed Step 1 : Input OK")
      else
        warning("GameLogic", "[----------REPLAY----------]    Failed Reason 2 : Input Not Empty")
      end
      local recordHpListEqual = true
      local notEqualTeam = 0
      for ti = 1, #fightDataRecord.teamList do
        local roundTeamInfoRec = fightDataRecord.teamList[ti]
        local roundTeamInfoCur = fightActiveData.teamList[ti]
        if roundTeamInfoRec and roundTeamInfoCur and #roundTeamInfoRec.statistic.recordHpList == #roundTeamInfoCur.statistic.recordHpList then
          for ri = 1, #roundTeamInfoRec.statistic.recordHpList do
            if roundTeamInfoRec.statistic.recordHpList[ri] ~= roundTeamInfoCur.statistic.recordHpList[ri] then
              recordHpListEqual = false
              notEqualTeam = ti
              break
            end
          end
        end
      end
      if recordHpListEqual then
        info("GameLogic", "[----------REPLAY----------]    Succeed Step 2 : HP OK")
      else
        warning("GameLogic", "[----------REPLAY----------]    Failed Reason 3 : HP ERROR")
      end
    end
    REF.SceneFight["$ProcessGameEnd"](FightLuaLogic.FightLuaTable)
  elseif not FightRoundBase:CheckGameExit() then
    FightLuaLogic:ProcessRoundEnd()
  end
end

function UpdateWinPose()
end

function UpdateGameEnd()
end

function UpdateWaitRoundEnd(delta)
end

function UpdateOneStart()
end

function UpdateRoundStart()
  local fightActiveData = REF.MainLogic["$fightActiveData"]()
  
  local function refreshLockBuff(teamList, team)
    local teamInfo = FH.getTeamInfo(teamList, team)
    for i = 1, #teamInfo.playerList do
      local roundPlayerInfo = teamInfo.playerList[i]
      for pi = 1, #roundPlayerInfo.actorList do
        local roundActorInfo = roundPlayerInfo.actorList[pi]
        if roundActorInfo.actorInfo.id and roundActorInfo.actorInfo.id > 0 and not roundActorInfo.isAssist then
          FH.refreshLockBuff(roundActorInfo, teamInfo)
        end
      end
    end
  end
  
  refreshLockBuff(fightActiveData.teamList, 1)
  refreshLockBuff(fightActiveData.teamList, 2)
end

function UseCard(linkID, actorID, team, cardList, card, scard, buffList, actionList, debugVal)
  FightLuaLogic:SetTeamCardData(team, 4)
  CS.DebugFightHitResult.Begin(team)
  local input = {}
  input.noDamage = FightConfig.NoDeadMode
  input.linkID = linkID
  input.actorID = actorID
  input.team = team
  input.useCard = card
  input.useSCard = scard
  if __EditorMode then
    input.debugMode = fif(FightConfig.AllCardMode, 1, 0)
  end
  input.cardList = cardList or {}
  input.buffList = buffList or {}
  input.actionList = actionList or {}
  if CS.GameLogic.IsLocalMode() then
    REF.MainLogic["$useCard"](input, function(fightActiveData)
      if FightRoundBase:IsShowUITeam(team) then
        local teamInfo = FH.getTeamInfo(fightActiveData.teamList, team)
        if teamInfo.useResult == 1 then
          FightLuaLogic:SetTeamCardData(team, 5)
          this:BroadcastGameEvent("FightUI_ActorCard", 4)
        end
        info("GameLogic", "usecard return team = " .. team .. " result = " .. teamInfo.useResult)
      end
      FightLuaLogic:ReceiveUseCardWrap(fightActiveData)
    end)
  else
    local message = {
      request = input,
      dungeonId = FightLuaLogic.NetRoomID
    }
    this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsUseCardReq", message)
  end
end

function UseCards(cardList, card, scard, link, team, buffList, actionList, debugVal)
  cardList = cardList or {}
  local result = -1
  local state = FightLuaLogic.mFightClientData.TeamCardState[team]
  if state ~= 3 and state ~= 2 or FightLuaLogic.WinTeam ~= 0 then
    warning("GamePlay", "use card state = " .. state)
  else
    local actorID = 0
    local linkID = 0
    local checkID = 0
    if 0 < #cardList then
      checkID = cardList[1].actorRuntimeID
    end
    if 0 < link then
      linkID = link
    else
      actorID = checkID
    end
    local realSend = FightLuaLogic:IsFightActiveActor(team, checkID)
    this:BroadcastGameEvent("FightUI_ClearRoundState")
    if FightRoundBase:IsShowUITeam(team) then
      this:BroadcastGameEvent("FightUI_OverRound", actorID, card, scard, linkID)
      this:BroadcastGameEvent("FightUI_ActorCard", fif(realSend, 1, 4))
    end
    if realSend then
      UseCard(linkID, actorID, team, cardList, card, scard, buffList, actionList, debugVal)
    else
      FightLuaLogic:SetTeamCardData(team, 5)
      info("GameLogic", "--------local failed--------")
    end
    result = 0
  end
  return result
end

function TryUseTeamAI(teamInfo)
  local result = false
  local team = teamInfo.team
  local cardState = FightLuaLogic.mFightClientData.TeamCardState[team]
  if teamInfo.cardShowDelay >= 0 and cardState == 3 then
    if m_isRecordFight then
      local recordData = this:GetData("FightDataRecord")
      for i = 1, #recordData.teamList do
        local recordTeamInfo = recordData.teamList[i]
        if recordTeamInfo.team == team and 0 < #recordTeamInfo.statistic.inputList then
          local firstInput = recordTeamInfo.statistic.inputList[1]
          info("GameLogic", "[----------REPLAY----------]    Use Record : Team = " .. table.dump(firstInput))
          UseCards(firstInput.cardList, firstInput.useCard, firstInput.useSCard, firstInput.linkID, team, firstInput.buffList, firstInput.actionList, 0)
          table.remove(recordTeamInfo.statistic.inputList, 1)
          result = true
          break
        end
      end
      if result == false then
        FightRoundBase:SetRoundStep(CS.RoundStep.None)
        warning("GameLogic", "[----------REPLAY----------]    Failed Reason 1 : Not Enough Input")
      end
    else
      local run = false
      local useAI = true
      local uiAI = false
      if FightLuaLogic.ActiveTeam == FightLuaLogic.SelfTeam then
        if FightLuaLogic:IsActivePlayer() then
          useAI = FightRoundBase.m_autoFight
          uiAI = true
        end
        run = true
      else
        if __EditorMode and FightConfig.m_AIMode == CS.AI_MODE.AM_MANUAL then
          useAI = false
        end
        run = FightConfig.m_AIMode == CS.AI_MODE.AM_DEFAULT
      end
      if useAI then
        if uiAI then
          this:BroadcastGameEvent("FightUI_RunAI")
        else
          local cardsTobeUsed = {}
          local output = {}
          if run then
            local fightActiveData
            if not CS.GameLogic.IsLocalMode() then
              fightActiveData = REF.MainLogic["$fightActiveData"]()
              for i = 1, #fightActiveData.teamList do
                if fightActiveData.teamList[i].team == team then
                  fightActiveData.teamList[i] = teamInfo
                  break
                end
              end
            end
            output = REF.MainLogic["$bevtreeUpdate"]({team = team}, fightActiveData)
            local errorCard = false
            fightActiveData = REF.MainLogic["$fightActiveData"]()
            for c = 1, #output.cardSend do
              local id = output.cardSend[c].actorRuntimeID
              local find = table.find(fightActiveData.activeActorList or {}, function(_, v)
                return v == id
              end)
              if find == nil then
                warning("GameLogic", "AI usecard error = " .. id)
                errorCard = true
                break
              end
            end
            if not errorCard then
              table.append(cardsTobeUsed, output.cardSend)
            end
          end
          local skillType = output.skillType or 0
          local superSkillType = output.superSkillType or 0
          local linkId = output.linkId or 0
          local buffList = output.buffList or {}
          local actionList = output.performanceInfoList or {}
          UseCards(cardsTobeUsed, skillType, superSkillType, linkId, team, buffList, actionList, 0)
        end
      end
      result = useAI
    end
  end
  return result
end

function CheckGameOver()
  local gameIsOver = FightLuaLogic.WinTeam ~= 0
  if gameIsOver then
    FightRoundBase:SetRoundStep(CS.RoundStep.RoundEnd)
  end
  return gameIsOver
end

function CheckGameExit()
  local exitGame = FightLuaLogic.InitState ~= CS.FightInitState.InitSucceed
  if exitGame then
    FightRoundBase:SetRoundStep(CS.RoundStep.None)
    FightRoundBase:LeaveGameLua("SceneCity")
  end
  return exitGame
end

function IsAllActorReady()
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    if not roundActorInfo.isAssist then
      if actorProcess:IsActorDead() then
        if not actorProcess:IsDeadEnd() then
          return false
        end
      else
        local stateFSM = actorProcess.m_stateManager
        local isStandBy = stateFSM:CurStateCheck("ActorStateStandby")
        local isPose = stateFSM:CurStateCheck("ActorStatePose")
        local hasBuffAction = roundActorInfo.buffAction and roundActorInfo.buffAction.type ~= 0
        local atBornPos = actorProcess:IsInRoundBornPoint()
        local actionValid = hasBuffAction or isStandBy and atBornPos or isPose
        if not actionValid or actorProcess:IsRoundRunBack() then
          return false
        end
      end
    end
  end
  return true
end

function ResetAllActorStandPos()
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    local stateFSM = actorProcess.m_stateManager
    local hasBuffAction = roundActorInfo.buffAction and roundActorInfo.buffAction.type ~= 0
    if not roundActorInfo.isAssist and hasBuffAction and not stateFSM.mActorFreeze.mRetain then
      local actionName = string.lower(PB.enum.BuffLogicAction.__keys[roundActorInfo.buffAction.type])
      stateFSM.mStandAction = actionName
      if not stateFSM:SendStandByActionCommand() then
        warning("GamePlay", "fix standby action missing problem.  action name -> " .. actionName)
        stateFSM.mStandAction = CS.ActionNameDef.ACTION_STAND
        stateFSM:SendStandByActionCommand()
      end
    elseif not actorProcess:IsActorStand() then
      stateFSM.mStandAction = CS.ActionNameDef.ACTION_STAND
      stateFSM:SendStandByActionCommand()
    end
  end
end

function DoPoseAction(uniqueId)
  local doFirst = uniqueId > DoFirstPoseAction
  uniqueId = fif(uniqueId > DoFirstPoseAction, uniqueId - DoFirstPoseAction, uniqueId)
  local actorProcess = ActorManager:GetActorInfo(uniqueId)
  if actorProcess then
    local team = DEFINE.RoundActorInfoUniqueId(uniqueId)
    local fightActiveData = REF.MainLogic["$fightActiveData"]()
    local roundTeamInfo = FH.getTeamInfo(fightActiveData.teamList, team)
    local roundActorInfo = FH.getActorByUid(roundTeamInfo, uniqueId)
    local hasBuffAction = roundActorInfo.buffAction and roundActorInfo.buffAction.type ~= 0
    if actorProcess:IsActorStand() and not actorProcess:IsActorDead() and not actorProcess:IsAssist() and not hasBuffAction then
      local poseActionCnt = actorProcess.m_gameInfo.m_poseActionCount
      if 0 < poseActionCnt then
        local actorStateManager = actorProcess.m_stateManager
        local actionIndex = math.random(1, poseActionCnt)
        local action = CS.ActionNameDef.ACTION_SHOW .. "_1_" .. fif(doFirst, 1, actionIndex)
        actorStateManager:SendPoseCommand(action)
      end
    end
  end
end

function RefreshAllActorHpBuff(buffType)
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    if not actorProcess:IsAssist() then
      for i = 1, #roundActorInfo.hpChangeList do
        local buffHpChange = roundActorInfo.hpChangeList[i]
        if buffHpChange.kind == buffType then
          local val = buffHpChange.val
          if val < 0 then
            FightLuaLogic.mFightRoundSandBox.OnBuffHpChange(roundActorInfo.team, -val)
          end
          local hudText = {
            type = fif(0 <= val, PB.enum.HudTextType.HPRecover, PB.enum.HudTextType.PhysicsHPDamage),
            val = val,
            actorProcess = actorProcess,
            critical = false,
            showZero = false
          }
          this:SetData("FightUI/HudText", hudText)
          actorProcess.m_buffLogic:SetHpChange(val, 1)
        end
      end
    end
  end
end

function RefreshAllActorOnceHpChangeBuff()
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    SetActorOnceHpChange(actorProcess, roundActorInfo.hpOnceChange)
  end
end

function CheckAllActorState(playAnimation)
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    local uid = roundActorInfo.uniqueID
    local assist = actorProcess:IsAssist()
    local fix = false
    local hpClient = actorProcess.m_buffLogic:GetCurHp()
    local hpLua = roundActorInfo.dynamicAttrs[PB.enum.AttrType.Hp].value
    if hpClient ~= hpLua and not assist then
      fix = true
      warning("GameLogic", uid .. " HP [client] " .. hpClient .. " != [lua] " .. hpLua)
    end
    local seatClient = actorProcess:GetSeat()
    local seatLua = roundActorInfo.seat
    if seatClient ~= seatLua and not assist then
      fix = true
      warning("GameLogic", uid .. " SEAT [client] " .. seatClient .. " != [lua] " .. seatLua)
    end
    local actorGameInfo = actorProcess.m_gameInfo
    if fix then
      actorGameInfo.m_bornPos = CS.GameLogic.GetRoundActorPos(actorGameInfo.Team, seatLua - 1)
      if 0 < hpLua then
        if not playAnimation or actorProcess.IsActorDead() then
          actorProcess:ResetToBornPoint()
        end
        actorProcess:NotifyActorRecover(hpLua)
      else
        actorProcess:NotifyActorDead()
        actorProcess:SetActorDeadPhysics(fif(playAnimation, 1, 0))
      end
      actorGameInfo.m_seat = seatLua
      actorGameInfo.m_fixSeat = seatLua
    end
    if __EditorMode then
      if actorGameInfo.IsWeapon then
        actorProcess.LogicTransform.name = uid .. "_Weapon" .. actorGameInfo.m_Info.ActorInfo.UniqueWeaponId .. "[Seat:" .. seatLua .. "]" .. "[Hp:" .. hpLua .. "]"
      else
        local actorConfig = PB.get("ActorConfig", actorProcess:GetActorID())
        actorProcess.LogicTransform.name = uid .. "_" .. actorConfig.animRes .. "[Seat:" .. seatLua .. "]" .. "[Hp:" .. hpLua .. "]"
      end
    end
  end
end

function RefreshAllActorBuff(showEffect)
  local fightActiveData = REF.MainLogic["$fightActiveData"]()
  local sortList = {}
  if showEffect then
    for i = 1, #fightActiveData.sequenceList do
      local sequenceActorInfo = fightActiveData.sequenceList[i]
      if not sequenceActorInfo.dead then
        table.insert(sortList, sequenceActorInfo.uid)
      end
    end
  end
  local dict = FightLuaLogic.mActorData
  for actorProcess, roundActorInfo in pairs(dict) do
    FightLuaLogic.mFightRoundSandBox.OnActorBuffChange(roundActorInfo.uniqueID, roundActorInfo.buffList)
    if showEffect and not actorProcess:IsAssist() then
      local sequenceIndex = table.find(sortList, function(_, val)
        return val == actorProcess:GetUniqueID()
      end)
      if sequenceIndex then
        local position = {
          hideUI = false,
          actorProcess = actorProcess,
          positionPostfix = sequenceIndex
        }
        this:SetData("FightUI/Position", position)
      end
      actorProcess:BroadcastActorUIActive(fightActiveData.sequenceActor == actorProcess:GetUniqueID())
      actorProcess.m_stateManager:ClearBuffEffect()
      for bi = 1, #roundActorInfo.buffList do
        local roundActorBuff = roundActorInfo.buffList[bi]
        if roundActorBuff.State == PB.enum.BuffFightState.Alive then
          local key = tostring(roundActorBuff.buffKey.id) .. tostring(roundActorBuff.buffKey.owner) .. "l"
          if m_effectData[key] then
            actorProcess.m_stateManager:AddBuffEffect(m_effectData[key])
          end
        end
      end
    end
  end
  FightLuaLogic.mFightRoundSandBox.ShowWeaponTriggeredSpecial()
end

function DamageResultBuff(hitResultInfo, actorProcess, outBuffEffect)
  for i = 1, #hitResultInfo.buffKey do
    local uniqueId = hitResultInfo.buffKey[i]
    local buffResultInfoList = hitResultInfo.buffResult[i]
    if #buffResultInfoList.listInfo > 0 then
      FightLuaLogic.mFightRoundSandBox.OnActorBuffChange(uniqueId, buffResultInfoList.listInfo)
    end
    local hitActorProcess = ActorManager:GetActorInfo(uniqueId)
    if hitActorProcess then
      SetActorOnceHpChange(hitActorProcess, buffResultInfoList.hpChange, true)
    end
    if uniqueId == actorProcess:GetUniqueID() then
      for li = 1, #buffResultInfoList.listInfo do
        local roundActorBuff = buffResultInfoList.listInfo[li]
        if roundActorBuff.isNewHit then
          local hudText = {
            type = PB.enum.HudTextType.Energy,
            val = roundActorBuff.contentVal,
            actorProcess = actorProcess,
            critical = false,
            showZero = false,
            param = roundActorBuff
          }
          this:SetData("FightUI/HudText", hudText)
          local key = tostring(roundActorBuff.buffKey.id) .. tostring(roundActorBuff.buffKey.owner) .. "h"
          if m_effectData[key] then
            outBuffEffect:Add(m_effectData[key])
          end
        end
      end
    end
  end
  FightLuaLogic.mFightRoundSandBox.ShowWeaponTriggeredSpecial()
end

function RefreshUseBuffResult()
  local fightActiveData = REF.MainLogic["$fightActiveData"]()
  local teamInfo = FH.getTeamInfo(fightActiveData.teamList, fightActiveData.useCardTeam)
  if teamInfo then
    for i = 1, #teamInfo.buffKeyList do
      local uniqueId = teamInfo.buffKeyList[i]
      local buffResultInfoList = teamInfo.buffResultList[i]
      FightLuaLogic.mFightRoundSandBox.OnActorBuffChange(uniqueId, buffResultInfoList.listInfo)
      local actorProcess = ActorManager:GetActorInfo(uniqueId)
      if actorProcess then
        SetActorOnceHpChange(actorProcess, buffResultInfoList.hpChange)
      end
    end
    FightLuaLogic.mFightRoundSandBox.ShowWeaponTriggeredSpecial()
  end
end

function SetActorOnceHpChange(actorProcess, hpChangeList, immediate)
  if actorProcess:IsAssist() or actorProcess:IsActorDead() then
    return
  end
  immediate = immediate or false
  for i = 1, #hpChangeList do
    local buffHpChange = hpChangeList[i]
    if not actorProcess:IsRecordHp(buffHpChange.index) then
      local val = buffHpChange.val
      if val < 0 then
        if immediate then
          FightLuaLogic.mFightRoundSandBox.AddHurtVal(actorProcess:GetTeam(), math.abs(val), false)
        else
          FightLuaLogic.mFightRoundSandBox.OnBuffHpChange(actorProcess:GetTeam(), -val)
        end
      end
      local hudText = {
        type = fif(0 <= val, PB.enum.HudTextType.HPRecover, PB.enum.HudTextType.PhysicsHPDamage),
        val = val,
        actorProcess = actorProcess,
        critical = false,
        showZero = false
      }
      this:SetData("FightUI/HudText", hudText)
      actorProcess.m_buffLogic:SetHpChange(val, 1)
    end
  end
end

function ActorEffect(actorProcess)
  if m_dungeonType == PB.enum.DungeonType.Gold and actorProcess:GetTeam() == 2 then
    actorProcess.m_stateManager:CreateShowEffect(m_effectData.GoldenRobotDead, CS.UnityEngine.Vector3.zero, nil, false)
  end
end

function CreateGameActor(actorGameInfo)
  if actorGameInfo == nil then
    return
  end
  local xlsxData
  if actorGameInfo.IsWeapon then
    local actorInfo = actorGameInfo.m_Info.ActorInfo
    xlsxData = PB.get("UniqueWeaponSkill", actorInfo.UniqueWeaponId, actorInfo.UniqueWeaponPhase)
  else
    xlsxData = PB.get("ActorConfig", actorGameInfo.ActorID)
  end
  if xlsxData == nil then
    warning("GamePlay", "CreateGameActor Load XlsxData Failed!")
    return
  end
  InitGlobalSingleton()
  local position = CS.GameDefine.GetBornPoint(actorGameInfo.m_bornPos)
  local go = ResourceManager:InstantiatePrefabAndResetShader("Logic/Actor/Actor2D", position, actorGameInfo.m_bornDir)
  if go ~= nil then
    local scale = xlsxData.scale or 1.0
    local height = (xlsxData.height or 4.0) / scale
    local width = (xlsxData.width or 1.0) / scale
    if width > height / 2.0 * 0.9 then
      warning("GamePlay", " width out of limit : " .. width)
      width = height / 2.0 * 0.9
    end
    if __EditorMode then
      local nameMid = fif(actorGameInfo.IsWeapon, "_weapon", "_")
      local nameAffix = fif(actorGameInfo.IsWeapon, xlsxData.id, xlsxData.animRes)
      go.name = actorGameInfo.UniqueID .. nameMid .. nameAffix
    end
    local ref = _ENV["$"](go)
    local characterController = ref["$CharacterController"]
    characterController.height = height
    characterController.center = CS.UnityEngine.Vector3(0, height / 2.0, 0)
    characterController.radius = width
    local boxCollider = ref.ActorInjured.BoxCollider
    boxCollider.center = CS.UnityEngine.Vector3(0, height / 2.0, 0)
    boxCollider.size = CS.UnityEngine.Vector3(width * 2.0, height, width * 2.0)
    go.transform.localScale = CS.UnityEngine.Vector3.one * scale * 1.0
    local id = fif(actorGameInfo.IsWeapon, xlsxData.weaponSkillId, actorGameInfo.ActorID)
    local logicRes = xlsxData.logicRes
    local actionManager = CS.ActionLogicDataManager
    local inputList = actionManager.GetInputActionList(logicRes, id)
    local runTimeDataList
    if actorGameInfo.IsWeapon then
      runTimeDataList = actionManager.GetLogicListByCmd(logicRes, xlsxData.cmdStr, inputList)
    else
      local gameLogic = CS.GameLogic
      runTimeDataList = actionManager.GetLogicListBySkillList(logicRes, gameLogic.GetSkillIDByActorLink(actorGameInfo.m_linkID, id), inputList)
      local selfSkillsList = gameLogic.GetCustomSkillList(id)
      for k, skills in pairs(selfSkillsList) do
        runTimeDataList:AddRange(actionManager.GetLogicListBySkillList(logicRes, skills, inputList))
      end
    end
    local actionList = actionManager.GetActorLogicDataList(id, xlsxData.kind == PB.enum.ActorType.Main, runTimeDataList)
    local actorAnimation2D = ResourceManager:AddActorAnimation2D(ref.ActorAnim.transform, xlsxData.prefabRes or "", actionList)
    actorAnimation2D:InitAnimation2D(logicRes)
    for i = 1, #xlsxData.hookObject do
      actorAnimation2D.m_hooks:Add(xlsxData.hookObject[i])
    end
    actorAnimation2D.mShadow:SetShadowParam(xlsxData.shadowBaseY or 0, xlsxData.shadowOffset or 0)
    ResourceManager:ClearRuntimeAnimTable()
    actorGameInfo.m_configScale = fif(actorGameInfo.IsWeapon, 1.0, xlsxData.scale)
    actorGameInfo.m_configHitH = fif(actorGameInfo.IsWeapon, 0, xlsxData.hitH)
    actorGameInfo.m_configHitW = fif(actorGameInfo.IsWeapon, 0, xlsxData.hitW)
    actorGameInfo.m_poseActionCount = fif(actorGameInfo.IsWeapon, 0, xlsxData.poseActionCnt)
    actorGameInfo.m_weaponCmd = fif(actorGameInfo.IsWeapon, xlsxData.cmdStr, "")
    actorGameInfo.m_weaponVolumVal = fif(actorGameInfo.IsWeapon, xlsxData.volumVal, 0)
    actorGameInfo.m_weaponTarget = fif(actorGameInfo.IsWeapon, xlsxData.target, 0)
    actorGameInfo.m_weaponDefense = fif(actorGameInfo.IsWeapon, xlsxData.defense, "")
    actorGameInfo.m_weaponSkillId = fif(actorGameInfo.IsWeapon, xlsxData.weaponSkillId, 0)
    local actorComponent = go:AddComponent(typeof(CS.ActorComponent))
    actorComponent:InitComponent(actorGameInfo)
    local actorProcess = CS.ActorProcess()
    actorProcess:InitActor(go.transform, actorAnimation2D, actorGameInfo, true)
    ActorManager:AddActorInfo(actorProcess)
    actorProcess.m_stateManager:SendStandByActionCommand()
    actionManager.PreLoadGameActorEffect(actorProcess, actorAnimation2D:GetLogicDataList(), false, this:GetData("FightEffectLoadType") or -1)
    if xlsxData.close and 0 <= xlsxData.close then
      ref.ActorAnim.SpriteRenderer.material:SetFloat("_PaletteIndex", actorGameInfo.CloseID)
      actorAnimation2D:RefreshShadowAvatar()
    end
  end
  return go
end

function TemporaryFix()
  local actorActionCommand = CS.CommandManager.Instance:GetActorActionCommand()
  actorActionCommand.mParam.mChangePos = nil
end
