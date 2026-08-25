local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEntity = require("Battle.Ecs.BattleEntity")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleRecord = require("Battle.DbgEngine.Record.BattleRecord")
local BattleInstantRecord = require("Battle.DbgEngine.Record.BattleInstantRecord")
local BattleEventMgr = require("Battle.DbgEngine.Event.BattleEventMgr")
local BattleEffectMgrServer = require("Battle.DbgEngine.Effect.BattleEffectMgrServer")
local BattleGMServer = require("Battle.DbgEngine.GM.BattleGMServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleMonsterSpawnerMgr = require("Battle.DbgEngine.MonsterSpawner.BattleMonsterSpawnerMgr")
local BattleRoleMgrServer = require("Battle.DbgEngine.Role.BattleRoleMgrServer")
local BattleStateMgrServer = require("Battle.DbgEngine.State.BattleStateMgrServer")
local BattleStatsMgr = require("Battle.DbgEngine.Stats.BattleStatsMgr")
local BattleRobotMgrServer = require("Battle.DbgEngine.Robot.BattleRobotMgrServer")
local BattleLogMgrServer = require("Battle.DbgEngine.BattleLog.BattleLogMgrServer")
local BattleRelicMgrServer = require("Battle.DbgEngine.Relic.BattleRelicMgrServer")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleEngineData = require("Battle.DbgEngine.DataCenter.BattleEngineData")
local ResourceCache = require("Battle.Data.ResourceCache")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleSnapshotMgr = require("Battle.DbgEngine.Record.BattleSnapshotMgr")
local ConstGlobal = require("ConstGlobal")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local BP = bc.BattleProperty
local WAIT_TIMES = 5
local BattleEngine, Super = System.NewClass("BattleEngine", BattleEntity)

function BattleEngine:ctor(battleData)
  Super.ctor(self)
  self.initData = battleData
  self:InitLogger()
  self:InitRand()
  self.data = BattleEngineData.Create(battleData)
  self.data.finishType = self.data.finishType or -1
  self.data.needLog = true
  self.data.waitingTimes = 0
  self.objSet = {}
  if battleData.ResourceCache then
    self.resourceCache = battleData.ResourceCache
  else
    self.resourceCache = ResourceCache(self, battleData.gameplayType == bc.BattleGameplayType.PVP, self:IsServerBattle())
  end
  self.battleDT = self.resourceCache:GetDataTable()
  self.eventMgr = self:AddBattleComponent(BattleEventMgr)
  self:InitGameplay(battleData.gameplayType)
  self.recordMgr = self:AddBattleComponent(BattleRecord)
  self.instantRecordMgr = self:AddBattleComponent(BattleInstantRecord)
  self.effectMgr = self:AddBattleComponent(BattleEffectMgrServer)
  self.gmMgr = self:AddBattleComponent(BattleGMServer)
  self.monsterSpawnerMgr = self:AddBattleComponent(BattleMonsterSpawnerMgr)
  self.roleMgr = self:AddBattleComponent(BattleRoleMgrServer)
  self.stateMgr = self:AddBattleComponent(BattleStateMgrServer)
  self.statsMgr = self:AddBattleComponent(BattleStatsMgr, battleData.statistics)
  self.robotMgr = self:AddBattleComponent(BattleRobotMgrServer)
  self.battleLogMgr = self:AddBattleComponent(BattleLogMgrServer)
  self.relicMgr = self:AddBattleComponent(BattleRelicMgrServer)
  self.snapshotMgr = self:AddBattleComponent(BattleSnapshotMgr)
  self.pendingForceEndBout = false
  self.robotActionDepth = 0
  self:RegisterEvent(BattleLogicEvent.RoleDead, self.OnRoleDead, self)
  self:RegisterEvent(BattleLogicEvent.BFBoutEnd, self.OnBFBoutEnd, self)
  if self.logger and self.logger.Tag then
    self.logger:Tag("uid", battleData.playerUid)
  end
end

function BattleEngine:GetRelicList()
  return self.data.relics
end

function BattleEngine:InitLogger()
  if self:IsServerBattle() then
    local ServerUtil = require("ServerUtil")
    self.logger = ServerUtil.NewLogger(self.__name)
    return
  end
  
  local function compatibleLoggerFunc(_, ...)
    print(...)
  end
  
  if not ApplicationUtils.is_editor_mode() then
    function compatibleLoggerFunc(_, ...)
    end
  end
  local logger = setmetatable({}, {
    __index = function(_, _)
      return compatibleLoggerFunc
    end
  })
  self.logger = logger
end

function BattleEngine:IsServerBattle()
  return self.initData.svrRunBattle
end

function BattleEngine:GetSvrBattleEntity()
  return self.initData.svrBattleEntity
end

function BattleEngine:ExitBattle(delay)
  local svr = self:GetSvrBattleEntity()
  if svr then
    svr:ExitBattle(delay)
  end
end

function BattleEngine:InitRand()
  if self:IsServerBattle() then
    local Rand_L = require("Battle.DbgEngine.CRand")
    self.rand = Rand_L.new(self.initData.randomseed, self)
  else
    local Rand_L = require("Battle.DbgEngine.Rand")
    self.rand = Rand_L.new(self.initData.randomseed, self)
  end
end

function BattleEngine:RandomNumFromList(list, num)
  local ret = {}
  if nil == num then
    num = 1
  end
  local countNum = #list
  if num >= countNum then
    return list
  end
  while num > #ret do
    local count = #list
    if 0 == count then
      break
    end
    local index = self.rand:random(1, count)
    table.insert(ret, list[index])
    table.remove(list, index)
  end
  return ret
end

function BattleEngine:InitGameplay(gameplayType)
  self:InfoS("----------InitGameplay: {gameplayType}", gameplayType)
  if gameplayType == bc.BattleGameplayType.PVE then
    self.gameplay = require("Battle.DbgEngine.Gameplay.PVEGameplay")(self)
  elseif gameplayType == bc.BattleGameplayType.PVP then
    self.gameplay = require("Battle.DbgEngine.Gameplay.PVPGameplay")(self)
  elseif gameplayType == bc.BattleGameplayType.PVP_TRAIN then
    self.gameplay = require("Battle.DbgEngine.Gameplay.PVPTrainGameplay")(self)
  end
end

function BattleEngine:OnVisitNewLine(file, key, cfgLine)
end

function BattleEngine:GetCmdFunc(cmdStr, fenv)
  cmdStr = cmdStr or "nil"
  local cmdFunc
  if self.data.isMock then
    local func = LoadFuncUtils.GetFunc(cmdStr)
    
    function cmdFunc()
      do return func end
      return func, fenv
    end
  else
    cmdFunc = load("return " .. cmdStr, nil, nil, fenv)
    if not cmdFunc then
      self:Error("语法错误:%s", cmdStr)
    end
  end
  return cmdFunc
end

function BattleEngine:LogBattleWithTab(msg, ...)
  local curEffect = self.effectMgr:GetRunningEffect()
  if curEffect then
    local stackNum = curEffect:GetStackNum()
    for _ = 1, stackNum do
      msg = "\t" .. msg
    end
  end
  self:__LogBattle(msg, ...)
end

function BattleEngine:LogBattle(msg, ...)
  msg = msg .. "\n"
  self:__LogBattle(msg, ...)
end

function BattleEngine:__LogBattle(msg, ...)
  if self.data.test then
    return
  end
  if self.data.isReview then
    return
  end
  if self:IsServerBattle() then
    return
  end
  local bg = require("Battle.DbgRender.BattleGlobal")
  msg = "[" .. string.format("%.2f", self:GetCurPassTime()) .. "] " .. msg
  msg = string.format(msg, ...)
  bg.battleRender:LogBattle(msg)
end

function BattleEngine:LogBattleDetail(msg)
  if self.data.test then
    return
  end
  if self.data.isReview then
    return
  end
  if self:IsServerBattle() then
    return
  end
  local bg = require("Battle.DbgRender.BattleGlobal")
  if bg.battleRender then
    bg.battleRender:LogBattleDetail(msg)
  end
end

function BattleEngine:IsPrologueStage()
  local cfg = self.battleDT.Stage[self.data.stageId]
  self.logger:Debug("---------- IsPrologueStage：", self.data.stageId, cfg and cfg.BelongGroup or 0)
  if cfg and cfg.BelongGroup and 1 == cfg.BelongGroup then
    return true
  end
end

function BattleEngine:IsPVP()
  return self.initData.gameplayType == bc.BattleGameplayType.PVP or self.initData.gameplayType == bc.BattleGameplayType.PVP_TRAIN
end

function BattleEngine:IsPVE()
  return self.initData.gameplayType == bc.BattleGameplayType.PVE
end

function BattleEngine:EnterRobotAction()
  self.robotActionDepth = (self.robotActionDepth or 0) + 1
end

function BattleEngine:LeaveRobotAction()
  self.robotActionDepth = math.max(0, (self.robotActionDepth or 0) - 1)
end

function BattleEngine:IsAutoBattleOp()
  return (self.robotActionDepth or 0) > 0 and self:IsPVE() == true
end

function BattleEngine:IsPVPTraining()
  local battleTid = self.data.battleTid
  local battleConfig = self.battleDT.BattleConfig[battleTid]
  return battleConfig.BattleType == bc.BattleType.PVP_TRAINING or self.initData.gameplayType == bc.BattleGameplayType.PVP_TRAIN
end

function BattleEngine:GenUid()
  local uid = self.data._genUid + 1
  while self.objSet[uid] do
    self:Warn("GenUid exist:", uid)
    uid = uid + 1
  end
  self.data._genUid = uid
  return uid
end

function BattleEngine:GenObjUid(obj, upperUid)
  if self.recovering and not upperUid and obj.__name ~= "BattleCmdParser" and obj.__name ~= "BattleCmdServer" then
    self:Warn("GenObjUid error: recovering and not upperUid", obj.__name, debug.traceback())
  end
  local uid = upperUid or self:GenUid()
  if self.objSet[uid] then
    self:Error("GenObjUid failed: id conflict:", uid, upperUid, obj, self.objSet[uid])
  end
  if not upperUid then
    self:Debug("GenObjUid new:", uid, obj.__name)
  end
  self.objSet[uid] = obj
  self.data.objSet[uid] = obj.data
  obj.data = self.data.objSet[uid]
  return uid
end

function BattleEngine:GetCurPassTime()
  return self.data.passTime or 0
end

function BattleEngine:GetLockAwakenCardCount()
  return self.initData and self.initData.lockAwakenCardCount or 0
end

function BattleEngine:GetUnlockAwakenCardCount()
  return self.initData and self.initData.unlockAwakenCardCount or 0
end

function BattleEngine:GetInfoMsg(...)
  local passTimeText = self:GetCurPassTime()
  local prefix = string.format("[BattleEngine][%.3f]", passTimeText)
  local args = table.pack(...)
  local first = table.remove(args, 1)
  return prefix .. first, args
end

function BattleEngine:Info(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  self.logger:Info(msg, table.unpack(args))
end

function BattleEngine:Error(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  table.insert(args, debug.traceback())
  self.logger:Error(msg, table.unpack(args))
end

function BattleEngine:Warn(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  if self.logger.Warn then
    self.logger:Warn(msg, table.unpack(args))
  else
    self.logger:Info(msg, table.unpack(args))
  end
end

function BattleEngine:Debug(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  if self.logger.Debug then
    self.logger:Debug(msg, table.unpack(args, 1, args.n))
  else
    self.logger:Info(msg, table.unpack(args))
  end
end

function BattleEngine:DebugS(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  if self.logger.DebugS then
    self.logger:DebugS(msg, table.unpack(args, 1, args.n))
  else
    self.logger:Info(msg, table.unpack(args))
  end
end

function BattleEngine:InfoS(...)
  if not self.data.needLog then
    return
  end
  local msg, args = self:GetInfoMsg(...)
  if self.logger.InfoS then
    self.logger:InfoS(msg, table.unpack(args, 1, args.n))
  else
    self.logger:Info(msg, table.unpack(args))
  end
end

function BattleEngine:IsBattleFinish()
  return self.data.battlePhase == bc.BattlePhase.Finish
end

function BattleEngine:IsWin()
  if self.winCamp then
    return self.winCamp == bc.BattleCamp.Camp1
  end
end

function BattleEngine:GetStartTime()
  return self.data.startTime or 0
end

function BattleEngine:IsFail()
  if self.winCamp then
    return self.winCamp == bc.BattleCamp.Camp2
  end
end

function BattleEngine:GetBattleType()
  local battleTid = self.data.battleTid
  local battleConfig = self.battleDT.BattleConfig[battleTid]
  return battleConfig.BattleType
end

function BattleEngine:RegisterEvent(eventId, callback, target)
  self.eventMgr:RegisterEvent(eventId, callback, target)
end

function BattleEngine:RegisterEventToHead(eventId, callback, target)
  self.eventMgr:RegisterEventToHead(eventId, callback, target)
end

function BattleEngine:UnregisterEvent(eventId, callback, target)
  self.eventMgr:UnregisterEvent(eventId, callback, target)
end

function BattleEngine:UnregisterAllEventsByTarget(target)
  self.eventMgr:UnregisterAllEventsByTarget(target)
end

function BattleEngine:CreateEventEffect(eventId, eventData)
  eventData = eventData or {}
  if eventData.isAutoOp == nil then
    eventData.isAutoOp = self:IsAutoBattleOp()
  end
  local beforeEffectConfig = {
    effectType = bc.BattleEffectType.BESendEvent,
    eventId = eventId,
    eventData = eventData
  }
  self.effectMgr:CreateEffect(beforeEffectConfig)
end

function BattleEngine:BeginRecord()
  self.recordMgr:BeginRecord()
end

function BattleEngine:EndRecord()
  self.recordMgr:EndRecord()
end

function BattleEngine:IsRecording()
  return self.recordMgr.isRecording
end

function BattleEngine:SaveComponentSnapShot(componentName, component)
  if not component or not component.OnSnapShot then
    return nil
  end
  local snapshotData = component:OnSnapShot()
  if not snapshotData then
    self:Warn("SaveSnapShot: %s OnSnapShot returned nil", componentName)
    return nil
  end
  local hasLoop, loopPath = bc.has_loop_reference(snapshotData)
  if hasLoop then
    self:Warn("SaveSnapShot: %s has loop reference: %s", componentName, loopPath)
  end
  local clonedData = table.deepclone(snapshotData)
  self:Debug("SaveSnapShot: %s", componentName)
  return clonedData
end

function BattleEngine:SaveSnapShot()
  local globalData = {
    curMoney = self.data.curMoney,
    stress = self.data.stress,
    battlePhase = self.data.battlePhase,
    randomState = nil,
    gameSpeed = self.data.gameSpeed,
    _genUid = self.data._genUid,
    __exclusiveDropCards = self.__exclusiveDropCards,
    battleUuid = self.data.battleUuid,
    battleEngineUuid = self.data.battleEngineUuid,
    draftRelicTid = self.data.draftRelicTid,
    gender = self.data.gender,
    playerName = self.data.playerName,
    extraAddedLives = self.data.extraAddedLives or 0
  }
  globalData = table.deepclone(globalData)
  self:Debug("SaveSnapShot: globalData")
  local snapshot = {
    globalData = globalData,
    boutMgr = self:SaveComponentSnapShot("boutMgr", self.boutMgr),
    roleMgr = self:SaveComponentSnapShot("roleMgr", self.roleMgr),
    cardMgr = self:SaveComponentSnapShot("cardMgr", self.cardMgr),
    stateMgr = self:SaveComponentSnapShot("stateMgr", self.stateMgr),
    statsMgr = self:SaveComponentSnapShot("statsMgr", self.statsMgr),
    relicMgr = self:SaveComponentSnapShot("relicMgr", self.relicMgr)
  }
  snapshot.aiMgr = self:SaveComponentSnapShot("aiMgr", self.aiMgr)
  snapshot.monsterSpawnerMgr = self:SaveComponentSnapShot("monsterSpawnerMgr", self.monsterSpawnerMgr)
  if self.snapshotMgr then
    self.snapshotMgr:TakeAtBoutStart(snapshot)
  end
  snapshot.globalData.randomState = self.rand:getstate()
end

function BattleEngine:CanRecoverFromSnapShot()
  local privilegeLevel = self.initData.privilegeLevel or 0
  return privilegeLevel >= ConstGlobal.BPPrivilege.Core
end

function BattleEngine:ShouldSaveBoutSnapshot()
  return self:IsPVE() == true
end

function BattleEngine:RecoverFromSnapShot(snapShot)
  self:Info("开始恢复快照: 回合 %s", snapShot.boutMgr.boutNumber)
  self.recovering = true
  local oldObjSet = self.objSet
  local rootEffect = self.effectMgr.rootEffect
  local stack = {rootEffect}
  self.objSet = {}
  while #stack > 0 do
    local effect = stack[#stack]
    self.objSet[effect.uid] = effect
    oldObjSet[effect.uid] = nil
    stack[#stack] = nil
    if effect.subEffectList then
      for _, subEffect in ipairs(effect.subEffectList) do
        table.insert(stack, subEffect)
      end
    end
  end
  for uid, obj in pairs(oldObjSet) do
    if obj.__name == "BattleStateServer" then
      obj:DisposeTrigger()
    end
    self:UnregisterAllEventsByTarget(obj)
  end
  local globalData = snapShot.globalData
  self.data.curMoney = globalData.curMoney
  self.data.stress = globalData.stress
  self.data.battlePhase = globalData.battlePhase
  self.data.gameSpeed = globalData.gameSpeed
  self.data._genUid = globalData._genUid
  self.__exclusiveDropCards = globalData.__exclusiveDropCards
  if globalData.randomState then
    self.rand:setstate(globalData.randomState)
  end
  if self.boutMgr then
    self.boutMgr:OnRecover(snapShot.boutMgr)
  end
  if self.roleMgr then
    self.roleMgr:OnRecover(snapShot.roleMgr)
  end
  if self.cardMgr then
    self.cardMgr:OnRecover(snapShot.cardMgr)
  end
  if self.relicMgr then
    self.relicMgr:OnRecover(snapShot.relicMgr)
  end
  if self.stateMgr then
    self.stateMgr:OnRecover(snapShot.stateMgr)
  end
  if self.statsMgr then
    self.statsMgr:OnRecover(snapShot.statsMgr)
  end
  if self.aiMgr then
    self.aiMgr:OnRecover(snapShot.aiMgr)
  end
  if self.monsterSpawnerMgr then
    self.monsterSpawnerMgr:OnRecover(snapShot.monsterSpawnerMgr)
  end
  local extraAddedLivesDelta = (self.data.extraAddedLives or 0) - (globalData.extraAddedLives or 0)
  if extraAddedLivesDelta > 0 then
    local player = self.roleMgr and self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    if player then
      player.data.lives = player.data.lives + extraAddedLivesDelta
      self:Info("RecoverFromSnapShot 补回额外累增生命: +%s lives=%s", extraAddedLivesDelta, player.data.lives)
    end
  end
  self.recovering = false
  self:InitSchoolData()
  self:Info("快照恢复完成，快照数量: %s", self.snapshotMgr:GetSnapshotCount())
end

function BattleEngine:RewindToBout(targetBoutNumber)
  local currentBoutNumber = self.boutMgr:GetBoutNum()
  self:Info(string.format("RewindToBout 当前回合:%s, 目标回合:%s", currentBoutNumber, targetBoutNumber))
  if not self.snapshotMgr or not self.snapshotMgr:Has(targetBoutNumber) then
    local errorMsg = string.format("回溯失败: 当前回合 %s，目标回合 %s 的快照不存在", currentBoutNumber, targetBoutNumber)
    self:Warn(errorMsg)
    return false, errorMsg
  end
  local waiting, _ = self.effectMgr:GetEffectOrderInterrupted()
  if waiting then
    local errorMsg = "回溯失败: 当前有效果正在等待执行或客户端选择"
    self:Warn(errorMsg)
    return false, errorMsg
  end
  if self.scheduler and self.scheduler.Reset then
    self.scheduler:Reset()
  end
  local snapshot = self.snapshotMgr:Get(targetBoutNumber)
  self:RecoverFromSnapShot(table.deepclone(snapshot))
  if self.cardMgr and self.cardMgr.UpdateCardArgs then
    self.cardMgr:UpdateCardArgs()
  end
  if self.roleMgr and self.roleMgr.UpdateMonsterIntention then
    self.roleMgr:UpdateMonsterIntention()
  end
  if self.stateMgr and self.stateMgr.UpdateStateArgs then
    self.stateMgr:UpdateStateArgs()
  end
  local randomState = snapshot.globalData and snapshot.globalData.randomState
  if randomState then
    self.rand:setstate(randomState)
  else
    self:Warn("RewindToBout randomState 为空, 目标回合:%s", targetBoutNumber)
  end
  if self.snapshotMgr then
    self.snapshotMgr:OnRewind(currentBoutNumber, targetBoutNumber)
  end
  self:Info(string.format("RewindToBout 回溯成功, 当前回合:%s, 目标回合:%s", currentBoutNumber, targetBoutNumber))
  self:LogBattleWithTab("回溯到第 %s 回合", targetBoutNumber)
  return true
end

function BattleEngine:GetClientStatsData()
  local statsData
  if self:IsPVE() then
    statsData = {
      [bc.BattleCamp.Camp1] = self.statsMgr:Serialize()
    }
  else
    statsData = {}
    for _, camp in ipairs({
      bc.BattleCamp.Camp1,
      bc.BattleCamp.Camp2
    }) do
      local player = self.roleMgr:GetPlayer(camp)
      statsData[camp] = player.battleStats:Serialize()
    end
  end
  return statsData
end

function BattleEngine:ReconnectBattle(camp)
  local roleDataList = self.roleMgr:GetCampRoleDataList(bc.BattleCamp.Camp1)
  local monsterDataList = self.roleMgr:GetCampRoleDataList(bc.BattleCamp.Camp2)
  local boutLeftTime
  if self:IsPVP() then
    self.gameplay:GetSelectInitCardRecord()
    boutLeftTime = self.gameplay:GetBoutLeftTime()
  end
  local lives
  if self:IsPVE() then
    local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    lives = player:GetData("lives")
  end
  local data = {
    cardDataList = self.cardMgr:GetAllCardData(),
    roleDataList = roleDataList,
    monsterDataList = monsterDataList,
    relicDataList = self.data.relics or {},
    stateDataList = self.stateMgr:Serialize(),
    boutDataList = self.boutMgr:Serialize(),
    highlightList = self.cardMgr:GetHighlightList(),
    statsData = self:GetClientStatsData(),
    money = self.data.curMoney,
    stress = self.data.stress,
    gameSpeed = self.data.gameSpeed,
    boutDamage = self.statsMgr:GetCurBoutStats(bc.StatsKey.MonsterBeDamage),
    lastRecordList = self.recordMgr:GetRecordData(),
    lives = lives,
    gender = self.data.gender,
    playerName = self.data.playerName,
    camp = camp,
    battleUuid = self.data.battleUuid,
    battleUid = self.data.battleUid,
    battleEngineUuid = self.data.battleEngineUuid,
    boutLeftTime = boutLeftTime,
    monsterDamage = self.roleMgr:GetAllMonsterDamageInfo(),
    targetModel = self.gameplay:GetTargetModel(),
    initCamp = self.boutMgr.initCamp,
    draftRelicTid = self.data.draftRelicTid
  }
  self:SendCommand(BattleCommand.rd_RecoverBattle, data)
end

function BattleEngine:StartBattle(playerId)
  if self:GetSvrBattleEntity() then
    self.data.startTime = require("date").second()
  end
  self.gameplay:StartBattle(playerId)
end

function BattleEngine:__StartBattle()
  if self:GetSvrBattleEntity() then
    self.data.battleEngineUuid = require("uuid").getUUID()
  end
  self.data.IsInit = true
  self:Info("StartBattle", self.data.battleTid)
  self:LogBattle("战斗ID: %s UID: %s", self.data.battleTid, self.data.battleUuid)
  self.data.battlePhase = bc.BattlePhase.Ready
  local battleConfig = self.battleDT.BattleConfig[self.data.battleTid]
  
  local function preFunc()
    self:LogBattle("=========================== 战斗初始化 ===========================")
    self.gameplay:InitBattle()
    local cardDataList = self.cardMgr:GetAllCardData()
    local roleDataList = self.roleMgr:GetCampRoleDataList(bc.BattleCamp.Camp1)
    local monsterDataList = self.roleMgr:GetCampRoleDataList(bc.BattleCamp.Camp2)
    self:LogBattle("======================== 初始属性 ========================")
    local worldAttrs = self:GetWorldAttrs()
    for _, v in pairs(roleDataList) do
      local old = v.properties[BP.enchant_upgrade_per]
      if v.properties and old and old > 0 then
        v.properties[BP.enchant_upgrade_per] = old + (worldAttrs[BP.enchant_upgrade_per] or 0)
      end
    end
    local lives
    if self:IsPVE() then
      local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
      lives = player:GetData("lives")
    end
    self:SendCommand(BattleCommand.rd_InitBattle, {
      battleUuid = self.data.battleUuid,
      cardDataList = cardDataList,
      roleDataList = roleDataList,
      monsterDataList = monsterDataList,
      relicDataList = self.data.relics or {},
      money = self.data.curMoney,
      stress = self.data.stress,
      gameSpeed = self.data.gameSpeed,
      lives = lives,
      gender = self.data.gender,
      playerName = self.data.playerName,
      battleEngineUuid = self.data.battleEngineUuid,
      statsData = self:GetClientStatsData(),
      targetModel = self.gameplay:GetTargetModel(),
      initCamp = self.boutMgr.initCamp,
      draftRelicTid = self.data.draftRelicTid
    })
    self.gameplay:AfterBattleInit()
    local delayTime = battleConfig.StartDelay or 0
    self:AddPassTime(delayTime)
    local effectConfig = {
      effectType = bc.BattleEffectType.BEBattleBegin
    }
    self.effectMgr:CreateEffect(effectConfig)
  end
  
  local finishCb = {
    func = self.AfterBattleBegin,
    target = self,
    data = {}
  }
  self:RunEffectOrder(preFunc, finishCb)
end

function BattleEngine:InitSchoolData()
  local roleList = self.roleMgr:GetRoleList()
  for _, role in ipairs(roleList) do
    if role.schoolCompPVE then
      role.schoolCompPVE:InitSchoolData()
    end
    if role.schoolCompPVP then
      role.schoolCompPVP:InitSchoolData()
    end
  end
end

function BattleEngine:InitSchoolState(needInitState)
  local roleList = self.roleMgr:GetRoleList()
  for _, role in ipairs(roleList) do
    if role.schoolCompPVE then
      role.schoolCompPVE:InitSchoolState(needInitState)
    end
    if role.schoolCompPVP then
      role.schoolCompPVP:InitSchoolState()
    end
  end
end

function BattleEngine:InitPassiveState()
  local roleList = self.roleMgr:GetRoleList()
  for _, role in ipairs(roleList) do
    if role.monsterBehaviorComp then
      role.monsterBehaviorComp:InitExistState()
    end
  end
  self:MockPassiveState()
end

function BattleEngine:MockPassiveState()
  if not self.data.isMock or self:IsServerBattle() then
    return
  end
  self:MockRelicStates()
  self:MockAwakerStates()
  self:MockWeaponStates()
end

function BattleEngine:MockRelicStates()
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, relic in ipairs(self.data.relics or {}) do
    local relicCfg = self.battleDT.RelicConfig[relic.tid]
    for i = 1, 2 do
      local target = relicCfg["StateTarget" .. i]
      if not target then
      else
        local ctorData = {
          castRoleUid = player.uid
        }
        local cmdParser = BattleCmdParser(self, ctorData)
        local params = {}
        for _, p in ipairs(relicCfg.StatePara or {}) do
          table.insert(params, cmdParser:GetValueByCmd(p))
        end
        for _, stateId in ipairs(relicCfg["State" .. i] or {}) do
          local createArgs = {
            stateId = stateId,
            layer = 1,
            castRoleUid = player.uid,
            targetUid = player.uid,
            stateParams = params
          }
          if "PlayerRole" == target then
            local state = self.stateMgr:CreateState(player, createArgs)
            table.insert(relic.stateUids, state.uid)
          elseif "AllAwaker" == target then
            local awakerList = player:GetAwakerList()
            for _, awaker in ipairs(awakerList) do
              local state = self.stateMgr:CreateState(awaker, createArgs)
              table.insert(relic.stateUids, state.uid)
            end
          end
        end
      end
    end
  end
end

function BattleEngine:MockAwakerStates()
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  local awakerList = player:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    local breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
    local nextTid = 0
    local potencyList = AwakerDataUtils.GetAwakerPotencyList(awaker.tid)
    for i = 1, potencyLevel do
      local p = potencyList[i]
      local cfg = self.battleDT.AwakerPotency[p.tid]
      if cfg.EffectType and cfg.EffectType == "BEAddState" and cfg.Effect then
        for _, stateTid in ipairs(cfg.Effect) do
          local createArgs = {
            stateId = stateTid,
            layer = 1,
            castRoleUid = awaker.uid,
            targetUid = awaker.uid,
            stateParams = {},
            noDirectCmd = true
          }
          self.stateMgr:CreateState(awaker, createArgs)
        end
        potencyLevel = potencyLevel + 1
        if not nextTid or nextTid == awaker.potential then
          break
        end
      end
    end
    local skillId = awaker:GetSkillIdAndLevel()
    local skillCfg = self.battleDT.Skill[skillId]
    if skillCfg and skillCfg.ExistState then
      do
        local ctorData = {
          castRoleUid = awaker.uid,
          skillConfigId = skillId
        }
        local existState = self:GetValByCondList(ctorData, skillId, "ExistState")
        for _, stateTid in ipairs(existState or {}) do
          local params = BattleUtilServer.GetTQList(skillCfg.StatePara, breakSkillLevel, potencyLevel)
          local cmdCtorData = {}
          cmdCtorData.skillConfigId = skillId
          cmdCtorData.castRoleUid = awaker.uid
          cmdCtorData.configPara = params
          cmdCtorData.genArgsInstantly = true
          local cmdServer = BattleCmdServer(self, cmdCtorData)
          local stateCfg = self.battleDT.State[stateTid]
          if stateCfg.ShowJudgement and not cmdServer:GetValueByCmd(stateCfg.ShowJudgement) then
          elseif stateCfg.ShowType == bc.StateShowType.Affix or stateCfg.ShowType == bc.StateShowType.Describe then
          else
            local args = cmdServer:GetSkillArgs(params)
            local createArgs = {
              stateId = stateTid,
              layer = 1,
              castRoleUid = awaker.uid,
              targetUid = awaker.uid,
              stateParams = args
            }
            self.stateMgr:CreateState(awaker, createArgs)
          end
        end
      end
    end
    for tid, v in pairs(awaker.data.talents or {}) do
      local talentCfg = self.battleDT.AwakerTalent[tid]
      local levelCfg = talentCfg.data_list[v.lv]
      for i = 1, 2 do
        local talentType = levelCfg["TalentType" .. i]
        local talentEffect = levelCfg["TalentEffect" .. i]
        local talentEffectPara = levelCfg["TalentEffectPara" .. i]
        if "Add_State" == talentType then
          for _, stateId in ipairs(talentEffect) do
            local createArgs = {
              stateId = stateId,
              layer = 1,
              castRoleUid = awaker.uid,
              targetUid = awaker.uid,
              stateParams = table.deepclone(talentEffectPara)
            }
            self.stateMgr:CreateState(awaker, createArgs)
          end
        end
      end
    end
  end
end

function BattleEngine:MockWeaponStates()
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, weapon in ipairs(self.data.mockWeaponList or {}) do
    local weaponCfg = self.battleDT.Item[weapon.tid]
    for i = 1, 2 do
      local target = weaponCfg["StateTarget" .. i]
      local stateId = weaponCfg["State" .. i]
      if not (target and stateId) or not weapon.awakerTid then
      else
        local ctorData = {
          castRoleUid = player.uid
        }
        local cmdParser = BattleCmdParser(self, ctorData)
        local params = {}
        for _, p in ipairs(weaponCfg.StatePara or {}) do
          table.insert(params, cmdParser:GetValueByCmd(p))
        end
        local createArgs = {
          stateId = stateId,
          layer = 1,
          castRoleUid = player.uid,
          targetUid = player.uid,
          stateParams = params
        }
        if "PlayerRole" == target then
          self.stateMgr:CreateState(player, createArgs)
        elseif "TargetCmdOwner" == target then
          local awakerList = player:GetAwakerList()
          for _, awaker in ipairs(awakerList) do
            if awaker.tid == weapon.awakerTid then
              self.stateMgr:CreateState(awaker, createArgs)
            end
          end
        elseif "AllAwaker" == target then
          local awakerList = player:GetAwakerList()
          for _, awaker in ipairs(awakerList) do
            local state = self.stateMgr:CreateState(awaker, createArgs)
            table.insert(weapon.stateUids, state.uid)
          end
        end
      end
    end
  end
end

function BattleEngine:InitStatisticsByBattleData()
  if not self.data.statistics then
    return
  end
end

function BattleEngine:AfterBattleBegin()
  self.data.battlePhase = bc.BattlePhase.Battle
  self.gameplay:AfterBattleBegin()
end

function BattleEngine:GetWorldAttrs()
  return self.data.worldAttrs
end

function BattleEngine:OnRoleDead(eventData)
  self.isNeedCheckEnd = true
end

function BattleEngine:OnBFBoutEnd(eventData)
end

function BattleEngine:CheckIsFinishOrNextWave()
  self.isNeedCheckEnd = false
  local playerList = self.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp1)
  local monsterRoleList = self.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  if 0 == #playerList or 0 == #monsterRoleList or self.gmFinish then
    return true
  end
end

function BattleEngine:RunBattleEndEffect()
  local function preFunc()
    local effectType = bc.BattleEffectType.BEBattleEnd
    
    local effectConfig = {effectType = effectType, isShow = true}
    self.effectMgr:CreateEffect(effectConfig)
  end
  
  local finishCb = {}
  self:RunEffectOrder(preFunc, finishCb)
end

function BattleEngine:SetBattleFinishInfo(winCamp, isShow)
  if self.data.finishType < 0 then
    self.data.finishType = bc.BattleEndType.Normal
  end
  self.data.battlePhase = bc.BattlePhase.Finish
  self.winCamp = winCamp
  self.statsMgr:OnBFBeforeBoutEnd()
  self.stateMgr:ClearBattleEndState()
  local battleFinishData = self:GetBattleFinishData(winCamp)
  self.data.IsInit = false
  self.gameplay:BattleFinish(winCamp, battleFinishData)
  self.recordMgr:OnBattleFinish(winCamp, isShow, battleFinishData)
end

function BattleEngine:OnBattleFinish()
  if self._isBattleFinish then
    return
  end
  self._isBattleFinish = true
  if self.snapshotMgr then
    self.snapshotMgr:SaveBattleReview()
  end
  local delay = 0
  if self:IsPVP() then
    delay = 5
    self.logger:Debug("------------SetBattleFinish:", delay)
  end
  self:ExitBattle(delay)
end

function BattleEngine:WorldRpc(...)
  local svrBattleEntity = self:GetSvrBattleEntity()
  if svrBattleEntity then
    svrBattleEntity:WorldRpc(...)
  end
end

function BattleEngine:PlayerRpc(...)
  local svrBattleEntity = self:GetSvrBattleEntity()
  if svrBattleEntity then
    svrBattleEntity:PlayerRpc(...)
  end
end

function BattleEngine:SendCommand(msgId, msgData)
  self:Debug("SendCommand", msgId, self.data.battleEngineUuid)
  if self.battleRender then
    msgData.battleEngineUuid = self.data.battleEngineUuid
    self.battleRender:OnReceiveCommand(msgId, msgData)
    if self.snapshotMgr then
      self.snapshotMgr:InsertReviewRecord(msgId, msgData)
    end
  end
end

function BattleEngine:CommandResult(msgData, ret)
  msgData.ret = ret
  self:Debug("SendCommand CommandResult", table.tostring(msgData))
  self:SendCommand(BattleCommand.rd_CommandResult, msgData)
end

function BattleEngine:lg_UseCard(msgData)
  local curCamp = self.boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    local usedCount = self.statsMgr:GetCurBoutStats(bc.StatsKey.UsedCardCount) or 0
    local maxPlay = self.battleDT.GetConstant("MaxPlayPerBout", 299)
    if usedCount >= maxPlay then
      self:Warn(string.format("本回合出牌达上限 %s，强制结束回合 bout:%s player:%s usedCount:%s", maxPlay, self.boutMgr:GetBoutNum(), msgData.playerId, usedCount))
      do return self.lg_BoutEnd, self end
      return self.lg_BoutEnd, self, {
        playerId = msgData.playerId,
        boutNumber = self.boutMgr:GetBoutNum()
      }, self.boutMgr:GetBoutNum(), self.boutMgr, string.format("本回合出牌达上限 %s，强制结束回合 bout:%s player:%s usedCount:%s", maxPlay, self.boutMgr:GetBoutNum(), msgData.playerId, usedCount)
    end
  end
  local cardUid = msgData.cardUid
  local cardData = self.cardMgr:GetCardByUid(cardUid)
  if not cardData then
    self:CommandResult(msgData, false)
    return false, bc.CardFailedReason.NotInHand
  end
  local msg = string.format("使用卡牌：uid=%s， tid=%s, targetUids=%s", cardData.uid, cardData.tid, table.tostring(msgData.targetUids))
  self:Info(msg)
  local owner = cardData.owner
  local targetModel = self.gameplay:GetTargetModel()
  local replaceUids
  if targetModel ~= bc.PVPTargetModel.Client then
    msgData.targetUids = nil
  else
    local card = self:GetObj(cardUid)
    if card then
      local cmdServer = card:GetCardCmdServer()
      replaceUids = owner:ReplaceClientTarget(cmdServer, msgData.targetUids)
      if replaceUids then
        msgData.targetUids = replaceUids
      end
    end
  end
  local ret, reason = owner:CanUseCard(cardUid, msgData.targetUids, replaceUids)
  if not ret then
    msgData.newDeck = cardData and cardData.deck
    self:CommandResult(msgData, false)
    return ret, reason
  end
  owner:UseCard(cardUid, msgData.targetUids)
  msgData.newDeck = cardData and cardData.deck
  msgData.handCardList = self.cardMgr:GetHandCardUidList(curCamp)
  self:CommandResult(msgData, true)
  return true
end

function BattleEngine:lg_BoutEnd(msgData)
  if not self.boutMgr:CanPlayerEndBout(msgData) then
    self:CommandResult(msgData, false)
    return
  end
  local curBoutNum = self.boutMgr:GetBoutNum()
  if self:IsServerBattle() and curBoutNum > bc.ServerBattleBoutLimit then
    self:Warn(string.format("ERROR：回合数超过上限，自动判负 limit=%s boutNumber=%s", bc.ServerBattleBoutLimit, curBoutNum))
    local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    if not player then
      self:Warn("ERROR：回合数超过上限判负失败，找不到Camp1玩家")
      self:CommandResult(msgData, false)
      return
    end
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(player.camp)
    self:CommandResult(msgData, true)
    if self:IsPVE() then
      self:RunEffectOrder(function()
        self.effectMgr:CreateEffect({
          effectType = bc.BattleEffectType.BEBoutLimitConfirm,
          enemyCamp = enemyCamp
        })
      end, {}, nil)
    else
      self:RunEffectOrder(function()
        self:ActiveBattleEnd(enemyCamp)
      end, {}, nil)
    end
    return true
  end
  local msg = string.format("结束回合，发送的当前回合数=%s", msgData.boutNum)
  self:Info(msg)
  if self:IsPVE() then
    msgData.isEnterExtraBout = self.boutMgr:CheckIsExtraBout()
  end
  self:CommandResult(msgData, true)
  self.boutMgr:EndBout()
  return true
end

function BattleEngine:lg_ExtraBout(msgData)
  local useExtraBout = self.battleDT.GetConstant("DimensionTurnCtl", 1)
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local extraSpaceState = self.battleDT.GetConstant("TranscendentCtl", 0)
  local hasState = 0 ~= extraSpaceState and self.stateMgr:GetState(player, extraSpaceState) ~= nil
  if 0 == useExtraBout or hasState then
    local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local msg = string.format("使用超维超越之光功能：uid=%s", player.uid)
    self:Info(msg)
    if self:IsPVE() then
      msgData.isEnterExtraBout = self.boutMgr:CheckIsExtraBout()
    end
    self:CommandResult(msgData, true)
    player:DimensionalSkill()
    return true
  else
    do return self.lg_BoutEnd, self end
    return self.lg_BoutEnd, self, msgData, player, msgData, true
  end
end

function BattleEngine:lg_GM(msgData)
  self:CommandResult(msgData, true)
  self.gmMgr:OnReceiveGM(msgData)
end

function BattleEngine:lg_ChangeGameSpeed(msgData)
  self:CommandResult(msgData, true)
  self.data.gameSpeed = msgData.gameSpeed
  return true, self.data.gameSpeed
end

function BattleEngine:lg_UseUltiSkill(msgData)
  local caster = self:GetObj(msgData.roleUid)
  if caster.roleType ~= bc.RoleType.Awaker then
    self:CommandResult(msgData, false)
    return false
  end
  local skillId, skillLevel = caster:GetSkillIdAndLevel()
  local msg = string.format("使用狂气爆发：uid=%s， tid=%s，skillId=%s，skill_level=%s", caster.uid, caster.tid, skillId, skillLevel)
  self:Info(msg)
  local curCamp = self.boutMgr:GetCurCamp()
  local player = self.roleMgr:GetPlayer(curCamp)
  if self:IsPVP() and (not player or player:GetData("playerId") ~= msgData.playerId) then
    self:CommandResult(msgData, false)
    return false
  end
  if caster:GetCamp() ~= curCamp then
    self:CommandResult(msgData, false)
    return false
  end
  local targetModel = self.gameplay:GetTargetModel()
  local replaceUids
  if targetModel ~= bc.PVPTargetModel.Client then
    msgData.targetUids = nil
  else
    local cmdServer = caster:GetSkillCmd(skillId, skillLevel)
    replaceUids = caster:ReplaceClientTarget(cmdServer, msgData.targetUids)
    if replaceUids then
      msgData.targetUids = replaceUids
    end
  end
  local ret, err = caster:CanUseUltiSkill(msgData.targetUids, replaceUids)
  if not ret then
    msgData.errReason = err
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  caster:UseUltiSkill(msgData.targetUids)
  return true
end

function BattleEngine:lg_UseKeeperSkill(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用主角技能")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local skillId, _ = player:GetSkillIdAndLevel()
  local msg = string.format("使用钥令：uid=%s， skillId=%s", player.uid, skillId)
  self:Info(msg)
  if msgData.skillId and msgData.skillId ~= skillId then
    self:Warn("使用钥令失败，技能不匹配")
    return
  end
  local ret, err = player:CanUseKeeperSkill()
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:UseSkill()
  return true
end

function BattleEngine:lg_UseSilverKeyAwake(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用银钥觉醒")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local skillId = player:GetSilverKeyAwakeSkill()
  local msg = string.format("使用银钥觉醒：uid=%s， skillId=%s", player.uid, skillId)
  self:Info(msg)
  local ret, err = player:CanUseSilverKeyAwake()
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:UseSkill(skillId, 1, bc.BattleEffectType.BEUseSilverKeyAwake, bc.BattleEffectType.BEAfterUseSilverKeyAwake)
  return true
end

function BattleEngine:lg_UseChaosType2Skill(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用新混沌三重钥令技能")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if (player:GetProperty(bc.RoleProperty.is_chaos_type2) or 0) <= 0 then
    self:Warn("使用新混沌三重钥令技能失败，未拥有 is_chaos_type2")
    self:CommandResult(msgData, false)
    return
  end
  local skillId, skillLevel = player:GetChaosType2Skill()
  local msg = string.format("使用新混沌三重钥令技能：uid=%s， skillId=%s", player.uid, skillId)
  self:Info(msg)
  local ret, err = player:CanUseChaosType2Skill()
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:UseSkill(skillId, skillLevel)
  return true
end

function BattleEngine:lg_UseChaosType2Skill2(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用新混沌双重钥令技能")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if (player:GetProperty(bc.RoleProperty.is_chaos_type2) or 0) <= 0 then
    self:Warn("使用新混沌双重钥令技能失败，未拥有 is_chaos_type2")
    self:CommandResult(msgData, false)
    return
  end
  local skillId, skillLevel = player:GetChaosType2Skill2()
  local msg = string.format("使用新混沌双重钥令技能：uid=%s， skillId=%s", player.uid, skillId)
  self:Info(msg)
  local ret, err = player:CanUseChaosType2Skill2()
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:UseSkill(skillId, skillLevel)
  return true
end

function BattleEngine:lg_UseDimensionSkill(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local skillId = self.battleDT.GetConstant("DimensionSKill")
  local msg = string.format("使用超维量表黑洞：uid=%s， skillId=%s", player.uid, skillId)
  self:Info(msg)
  local ret, err = player:CanUseDimensionSkill()
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:UseSkill(skillId, 1, bc.BattleEffectType.BEUseDimensionSkill, bc.BattleEffectType.BEAfterUseDimensionSkill)
  return true
end

function BattleEngine:lg_SelectTargets(msgData)
  local waitingCommand = self.effectMgr:GetEffectOrderInterrupted()
  if waitingCommand ~= BattleCommand.lg_SelectTargets then
    self:CommandResult(msgData, false)
    return false
  end
  self:CommandResult(msgData, true)
  
  local function preFunc()
    local tag
    if msgData.selectType == bc.TargetSelectType.Card then
      tag = "卡牌"
    elseif msgData.selectType == bc.TargetSelectType.Awaker then
      tag = "唤醒体"
    elseif msgData.selectType == bc.TargetSelectType.KeeperSkill then
      tag = "钥令"
    elseif msgData.selectType == bc.TargetSelectType.CardDrop then
      tag = "卡包"
    elseif msgData.selectType == bc.TargetSelectType.KeeperSkillDrop then
      tag = "钥令包"
    end
    local names = ""
    for _, uid in ipairs(msgData.uids or {}) do
      local obj = self:GetObj(uid)
      local name = obj and obj.GetBattleLogName and obj:GetBattleLogName()
      names = names .. name .. ", "
    end
    self:LogBattleWithTab("选择%s: %s", tag, names)
    self.eventMgr:SendEvent(BattleLogicEvent.SelectTargets, msgData)
  end
  
  local finishCb = {}
  self:RunEffectOrder(preFunc, finishCb, true)
  return true
end

function BattleEngine:lg_ConfirmRewindToFirst(msgData)
  local effectMgr = self.effectMgr
  local snapshotMgr = self.snapshotMgr
  local waitingCommand, yieldData = effectMgr:GetEffectOrderInterrupted()
  if not (waitingCommand == BattleCommand.lg_Confirm and yieldData) or yieldData.isReliveChoose ~= true then
    self:Warn("rewindToFirst 拒绝: 非死亡复活确认挂起态, waiting=%s", tostring(waitingCommand))
    msgData.rewindToFirst = nil
    do return self.lg_Confirm, self end
    return self.lg_Confirm, self, msgData, tostring(waitingCommand)
  end
  if msgData.effectUid ~= yieldData.effectUid then
    self:Warn("rewindToFirst 拒绝: effectUid 不匹配, 传入=%s 期望=%s", tostring(msgData.effectUid), tostring(yieldData.effectUid))
    self:CommandResult(msgData, false)
    return false
  end
  if not snapshotMgr or not snapshotMgr:Has(1) then
    self:Error("rewindToFirst 失败: 回合1快照不存在，回退普通确认")
    msgData.rewindToFirst = nil
    do return self.lg_Confirm, self end
    return self.lg_Confirm, self, msgData, false, tostring(yieldData.effectUid)
  end
  effectMgr:ClearAll()
  self:RunEffectOrder(function()
    local rewindOk, rewindErr = self:RewindToBout(1)
    if not rewindOk then
      self:Error("rewindToFirst RewindToBout 失败: %s，兜底判负", tostring(rewindErr))
      self.effectMgr:ClearFinishCb()
      self:ActiveBattleEnd(bc.BattleCamp.Camp2)
      msgData.ret = false
      msgData.errorMsg = rewindErr
      self:SendCommand(BattleCommand.rd_CommandResult, msgData)
      return
    end
    msgData.ret = true
    msgData.errorMsg = nil
    msgData.currentBout = self.boutMgr:GetBoutNum()
    self:SendCommand(BattleCommand.rd_CommandResult, msgData)
  end, {
    func = function()
      self.boutMgr:AfterSnapshotBout(0)
    end,
    target = self,
    data = {}
  })
  return true
end

function BattleEngine:lg_Confirm(msgData)
  if msgData.rewindToFirst == true then
    do return self.lg_ConfirmRewindToFirst, self end
    return self.lg_ConfirmRewindToFirst, self, msgData, nil, nil, nil, nil, nil
  end
  local waitingCommand = self.effectMgr:GetEffectOrderInterrupted()
  if waitingCommand ~= BattleCommand.lg_Confirm then
    self:Warn("lg_Confirm 拒绝: 非确认挂起态, waiting=%s", tostring(waitingCommand))
    self:CommandResult(msgData, false)
    return false
  end
  
  local function preFunc()
    self.eventMgr:SendEvent(BattleLogicEvent.Confirm, msgData)
  end
  
  local finishCb = {}
  self:RunEffectOrder(preFunc, finishCb, true)
  return true
end

function BattleEngine:lg_CancelSelectTargets(msgData)
  local waitingCommand = self.effectMgr:GetEffectOrderInterrupted()
  if waitingCommand ~= BattleCommand.lg_SelectTargets then
    self:CommandResult(msgData, false)
    return false
  end
  self:CommandResult(msgData, true)
  
  local function preFunc()
    local tag
    if msgData.selectType == bc.TargetSelectType.Card then
      tag = "卡牌"
    else
      tag = "唤醒体"
    end
    self:LogBattleWithTab("取消选择%s", tag)
    self.cardMgr:RevertCurUseCard()
    self.eventMgr:SendEvent(BattleLogicEvent.CancelSelectTargets, msgData)
  end
  
  local finishCb = {}
  self:RunEffectOrder(preFunc, finishCb, true)
  return true
end

function BattleEngine:lg_RobotAction(msgData)
  if self:IsBattleFinish() then
    self:Warn("ERROR: 战斗已经结束")
    return
  end
  local camp = self.boutMgr:GetCurCamp()
  self.robotMgr:TakeOneMove(camp, msgData.playerId)
  return true
end

function BattleEngine:lg_SelectInitCard(msgData)
  local player = self.roleMgr:GetRoleByPlayerId(msgData.playerId)
  self.gameplay:OnSelectInitCard(player.camp, msgData)
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(player.camp)
  local enemy = self.roleMgr:GetPlayer(enemyCamp)
  self.logger:Debug("------------lg_SelectInitCard:", enemyCamp, enemy and table.tostring(enemy.originRoleData) or "player")
  if enemy and enemy:IsAI() then
    msgData.selectUids = {}
    self.gameplay:OnSelectInitCard(enemyCamp, msgData)
  end
  if not self:IsServerBattle() then
    msgData.selectUids = {}
    self.gameplay:OnSelectInitCard(enemyCamp, msgData)
  end
  return true
end

function BattleEngine:lg_ClickInitCard(msgData)
  local player = self.roleMgr:GetRoleByPlayerId(msgData.playerId)
  self.gameplay:OnClickInitCard(player.camp, msgData)
  return true
end

function BattleEngine:lg_Giveup(msgData)
  self.data.finishType = bc.BattleEndType.GiveUp
  local player = self.roleMgr:GetRoleByPlayerId(msgData.playerId)
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(player.camp)
  self:CommandResult(msgData, true)
  self:RunEffectOrder(function()
    self:ActiveBattleEnd(enemyCamp)
  end, {}, nil)
  return true
end

function BattleEngine:lg_ClientAction(msgData)
  self:CommandResult(msgData, true)
  if msgData.frameList then
    self.instantRecordMgr:SendRecordList(msgData.frameList)
    for _, frame in ipairs(msgData.frameList) do
      if frame.eventId == BattleRenderEvent.ShowEmoji then
        self:DebugS("lg_ClientAction: SendEmoji {frame}", frame)
        self.eventMgr:SendEvent(BattleLogicEvent.SendEmoji, {
          playerId = msgData.playerId,
          emoji = frame.data.emoji
        })
      end
    end
  end
  return true
end

function BattleEngine:lg_SwitchOceanModel(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以切换深海形态")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local msg = string.format("切换深海形态：uid=%s， model=%s", player.uid, msgData.model)
  self:Info(msg)
  local model = msgData.model
  local ret, err = player:CanSwitchOceanModel(model)
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:SwitchOceanModel(model)
  return true
end

function BattleEngine:lg_BloodRecoverSkill(msgData)
  if self.boutMgr.camp ~= bc.BattleCamp.Camp1 then
    self:Warn("ERROR: 仅玩家回合可以使用猩红熔炉回复功能")
    self:CommandResult(msgData, false)
    return
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local msg = string.format("使用猩红熔炉回复功能：uid=%s， model=%s", player.uid, msgData.model)
  self:Info(msg)
  local model = msgData.model
  local ret, err = player:CanBloodRecoverSkill(model)
  if not ret then
    self:CommandResult(msgData, false)
    return err
  end
  self:CommandResult(msgData, true)
  player:BloodRecoverSkill(model)
  return true
end

function BattleEngine:lg_UpdatePrivilegeLevel(msgData)
  if not self:IsPVE() then
    self:Warn("lg_UpdatePrivilegeLevel: 仅 PVE 副本战斗支持")
    return false
  end
  if not msgData or type(msgData.privilegeLevel) ~= "number" then
    self:Warn("lg_UpdatePrivilegeLevel: 参数错误")
    return false
  end
  local newLevel = msgData.privilegeLevel
  local curLevel = self.initData.privilegeLevel or 0
  if newLevel <= curLevel then
    self:Info("lg_UpdatePrivilegeLevel 幂等跳过 cur=%s new=%s", curLevel, newLevel)
    return true
  end
  self.initData.privilegeLevel = newLevel
  self:Info("lg_UpdatePrivilegeLevel 已更新 privilegeLevel=%s (old=%s)", newLevel, curLevel)
  if self.instantRecordMgr then
    self.instantRecordMgr:OnPrivilegeLevelChanged(newLevel)
  end
  return true
end

function BattleEngine:lg_RewindToBout(msgData)
  self:Info("收到回溯指令: boutNumber=%s", msgData and msgData.boutNumber)
  local targetBoutNumber = msgData and msgData.boutNumber
  if not targetBoutNumber or type(targetBoutNumber) ~= "number" then
    msgData.ret = false
    msgData.errorMsg = "参数错误: boutNumber 必须为数字"
    self:SendCommand(BattleCommand.rd_CommandResult, msgData)
    return false
  end
  if 1 ~= targetBoutNumber and not self:CanRecoverFromSnapShot() then
    msgData.ret = false
    msgData.errorMsg = "回溯功能未开放"
    self:SendCommand(BattleCommand.rd_CommandResult, msgData)
    return false
  end
  self.effectMgr:ClearAll()
  self:RunEffectOrder(function()
    local ok, err = self:RewindToBout(targetBoutNumber)
    msgData.ret = ok
    msgData.errorMsg = err
    msgData.currentBout = self.boutMgr:GetBoutNum()
    self:SendCommand(BattleCommand.rd_CommandResult, msgData)
    if ok and self:IsPVE() and self.instantRecordMgr then
      local player = self.roleMgr and self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
      if player then
        self.instantRecordMgr:OnSyncLives(player.data.lives)
      end
    end
  end, {
    func = function()
      self.boutMgr:AfterSnapshotBout(0)
    end,
    target = self,
    data = {}
  })
  return true
end

function BattleEngine:AddRespawnLife(delta, reason)
  if self:IsBattleFinish() then
    self:Warn("AddRespawnLife 拒绝: 战斗已结束")
    return false
  end
  delta = tonumber(delta) or 0
  if delta <= 0 then
    return false
  end
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player then
    return false
  end
  player.data.lives = player.data.lives + delta
  self.data.extraAddedLives = (self.data.extraAddedLives or 0) + delta
  if self.instantRecordMgr then
    self.instantRecordMgr:OnSyncLives(player.data.lives)
  end
  self:LogBattle(string.format("AddRespawnLife delta=%s lives=%s extraAddedLives=%s reason=%s", delta, player.data.lives, self.data.extraAddedLives, tostring(reason)))
  return true
end

local MsgId2FuncName = {
  [BattleCommand.lg_UseCard] = BattleEngine.lg_UseCard,
  [BattleCommand.lg_BoutEnd] = BattleEngine.lg_BoutEnd,
  [BattleCommand.lg_GM] = BattleEngine.lg_GM,
  [BattleCommand.lg_UseUltiSkill] = BattleEngine.lg_UseUltiSkill,
  [BattleCommand.lg_ExtraBout] = BattleEngine.lg_ExtraBout,
  [BattleCommand.lg_SelectTargets] = BattleEngine.lg_SelectTargets,
  [BattleCommand.lg_ChangeGameSpeed] = BattleEngine.lg_ChangeGameSpeed,
  [BattleCommand.lg_Confirm] = BattleEngine.lg_Confirm,
  [BattleCommand.lg_RobotAction] = BattleEngine.lg_RobotAction,
  [BattleCommand.lg_UseKeeperSkill] = BattleEngine.lg_UseKeeperSkill,
  [BattleCommand.lg_UseDimensionSkill] = BattleEngine.lg_UseDimensionSkill,
  [BattleCommand.lg_CancelSelectTargets] = BattleEngine.lg_CancelSelectTargets,
  [BattleCommand.lg_SelectInitCard] = BattleEngine.lg_SelectInitCard,
  [BattleCommand.lg_Giveup] = BattleEngine.lg_Giveup,
  [BattleCommand.lg_ClientAction] = BattleEngine.lg_ClientAction,
  [BattleCommand.lg_ClickInitCard] = BattleEngine.lg_ClickInitCard,
  [BattleCommand.lg_SwitchOceanModel] = BattleEngine.lg_SwitchOceanModel,
  [BattleCommand.lg_BloodRecoverSkill] = BattleEngine.lg_BloodRecoverSkill,
  [BattleCommand.lg_UseSilverKeyAwake] = BattleEngine.lg_UseSilverKeyAwake,
  [BattleCommand.lg_UseChaosType2Skill] = BattleEngine.lg_UseChaosType2Skill,
  [BattleCommand.lg_UseChaosType2Skill2] = BattleEngine.lg_UseChaosType2Skill2,
  [BattleCommand.lg_RewindToBout] = BattleEngine.lg_RewindToBout,
  [BattleCommand.lg_UpdatePrivilegeLevel] = BattleEngine.lg_UpdatePrivilegeLevel
}

function BattleEngine:OnReceiveCommand(msgId, msgData)
  self:LogBattle("使用指令：" .. msgId)
  if msgId == BattleCommand.lg_GM then
    do return self.lg_GM, self end
    return self.lg_GM, self, msgData, msgId, nil, nil, nil, nil, nil, nil
  end
  msgData = msgData or {}
  msgData.msgId = msgId
  if msgId == BattleCommand.lg_RobotAction then
    do return self.lg_RobotAction, self end
    return self.lg_RobotAction, self, msgData, msgId, nil, nil, nil, nil, nil, nil
  end
  if msgId == BattleCommand.lg_ClientAction then
    do return self.lg_ClientAction, self end
    return self.lg_ClientAction, self, msgData, msgId, nil, nil, nil, nil, nil, nil
  end
  if self:IsPVP() then
    local player = self.roleMgr:GetRoleByPlayerId(msgData.playerId)
    if player then
      player:ClearTimeoutTimes()
      local ignoreCampMsg = {
        [BattleCommand.lg_SelectInitCard] = true,
        [BattleCommand.lg_Giveup] = true,
        [BattleCommand.lg_ClientAction] = true,
        [BattleCommand.lg_ClickInitCard] = true
      }
      local curCamp = self.boutMgr:GetCurCamp()
      if not ignoreCampMsg[msgId] and curCamp ~= player:GetCamp() then
        self:Warn("阵营不匹配，无法执行指令" .. msgId)
        msgData.ret = false
        self:SendCommand(BattleCommand.rd_CommandResult, msgData)
        return false
      end
    end
  end
  if not BattleCommand.IgnoreWaitingCommands[msgId] then
    local waitingCommand, yieldData = self.effectMgr:GetEffectOrderInterrupted()
    if waitingCommand and not BattleCommand.ResumeCommands[msgId] then
      self.data.waitingTimes = self.data.waitingTimes + 1
      if self.data.waitingTimes >= WAIT_TIMES then
        self:SetTimeoutFlag(true)
        self.robotMgr:WaitingCommand(waitingCommand, yieldData)
        self:SetTimeoutFlag(false)
        return false
      else
        local str = "逻辑层等待指令 %s 回应，再尝试 %s 次跳过该指令"
        str = string.format(str, waitingCommand, WAIT_TIMES - self.data.waitingTimes + 1)
        self:Warn(str)
        msgData.ret = false
        self:SendCommand(BattleCommand.rd_CommandResult, msgData)
        return false
      end
    end
    if not waitingCommand and self.effectMgr:IsRootEffectOrderExist() then
      self:Warn(string.format("逻辑层还在执行上一个指令，无法处理:%s, rootEffectUid:%s, runningEffectUid:%s", msgId, self.effectMgr:GetRootEffectUid(), self.effectMgr:GetRunningEffectUid()))
      msgData.ret = false
      self:SendCommand(BattleCommand.rd_CommandResult, msgData)
      return false
    end
  end
  local funcName = MsgId2FuncName[msgId]
  if not funcName then
    self:Error("无法处理" .. msgId .. " 没有该指令")
    return false
  end
  if self:IsBattleFinish() then
    self:Warn("ERROR: 战斗已经结束")
    self:CommandResult(msgData, false)
    return
  end
  self.data.waitingTimes = 0
  local ret = funcName(self, msgData)
  return ret
end

function BattleEngine:SetPassTime(passTime)
  self.data.passTime = passTime
end

function BattleEngine:AddPassTime(passTime)
  if passTime < 0 then
    return
  end
  self.data.passTime = self.data.passTime + passTime / self.data.gameSpeed
end

function BattleEngine:SetTimeoutFlag(flag)
  self.timeoutFlag = flag
end

function BattleEngine:GetTimeoutFlag()
  return self.timeoutFlag
end

function BattleEngine:RunEffectOrder(preFunc, finishCb, isResume)
  local effectMgr = self.effectMgr
  self:BeginRecord()
  if not isResume then
    effectMgr:CreateEffectOrder(finishCb.func, finishCb.target, finishCb.data)
  end
  preFunc()
  if not isResume then
    effectMgr:RunRootEffect()
  end
  local battleFinish = self:IsBattleFinish()
  if not battleFinish then
    self.cardMgr:UpdateCardArgs()
    self.roleMgr:UpdateMonsterIntention()
    self.roleMgr:UpdateSkillArgs()
    self.roleMgr:UpdateSilverKeyAwakeArgs()
    self.roleMgr:UpdateSchoolArgs()
    self.cardMgr:CheckHandCardHighlight()
    self.stateMgr:UpdateStateArgs()
  end
  if self:IsPVE() then
    self.statsMgr:UpdateStats()
  end
  if self:IsPVP() then
    for _, camp in ipairs({
      bc.BattleCamp.Camp1,
      bc.BattleCamp.Camp2
    }) do
      local player = self.roleMgr:GetPlayer(camp)
      player.battleStats:UpdateStats()
    end
  end
  self:EndRecord()
  local battleOver = self:CheckIsFinishOrNextWave()
  if battleOver then
    effectMgr:ClearFinishCb()
  end
  local orderFinised = effectMgr:IsEffectOrderFinished()
  if orderFinised or battleFinish then
    self.cardMgr:ClearNoneDeckCards()
    self.stateMgr:ClearDeletedState()
    effectMgr:AfterEffectOrderFinished()
  end
  if battleOver and orderFinised and not battleFinish then
    self:RunBattleEndEffect()
  elseif orderFinised and self.pendingForceEndBout and not battleFinish then
    self.pendingForceEndBout = false
    self.boutMgr:EndBout()
  elseif battleFinish or battleOver then
    self.pendingForceEndBout = false
  end
  if self.data.battlePhase == bc.BattlePhase.Finish then
    self:OnBattleFinish()
  end
end

function BattleEngine:ActiveBattleEnd(winCamp, gmFinish, timeout, isShow)
  self.gmFinish = gmFinish
  self.timeout = timeout
  if not self.data.finishType or self.data.finishType < 0 then
    self.data.finishType = bc.BattleEndType.Other
  end
  if nil == isShow then
    isShow = true
  end
  local effectType = bc.BattleEffectType.BEBattleEnd
  local effectConfig = {
    effectType = effectType,
    winCamp = winCamp,
    isShow = isShow
  }
  self.effectMgr:CreateEffect(effectConfig)
end

function BattleEngine:SyncMonsterIntention2Render()
  local monsters = self.roleMgr:GetAliveRoleListByCamp(bc.BattleCamp.Camp2)
  for _, monster in ipairs(monsters) do
    monster:UpdateIntentionToRender()
  end
end

function BattleEngine:GetBattleFinishData(winCamp)
  local player = self.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local stateList = self.stateMgr:SerializeToServer()
  local attrNameList = {
    BP.death_resist,
    BP.death_resist_times,
    BP.permanent_max_tentacle_count,
    BP.permanent_tentacle_count,
    BP.scarlet_blood_count,
    BP.hp,
    BP.max_hp,
    BP.keeper_energy,
    BP.max_keeper_energy
  }
  local syncAttrs = {}
  for _, propertyName in ipairs(attrNameList) do
    syncAttrs[propertyName] = player.property.properties[propertyName]
  end
  local dimensionCards = self.cardMgr:GetDimensionCards()
  local battleFinishData = {
    _genUid = self.data._genUid,
    battleUuid = self.initData.battleUuid,
    winCamp = winCamp,
    finishType = self:GetFinishType(),
    syncAttrs = syncAttrs,
    roleRespawnedNum = player:GetData("respawnedNum") or 0,
    battleTid = self.data.battleTid,
    gearType = self.data.gearType,
    stateList = stateList,
    relics = self.relicMgr:GetBattleFinishData(),
    statistics = self.statsMgr:GetBattleFinishStats(winCamp),
    enternalCards = self.cardMgr:GetEnternalCards(),
    destroyedCards = self.cardMgr:GetDestroyedCards(),
    actorAttrs = self.roleMgr:GetSyncAwakerProperties(),
    curMoney = self:GetCurMoney(),
    stress = self:GetStress(),
    dimensionCards = dimensionCards,
    globalVariable = self.data.globalVariable,
    logStatistics = {
      ultiTimes = self.statsMgr:GetStats("BattleStats", bc.StatsKey.UltiSkillCount),
      totalDamage = self.statsMgr:GetStats("BattleStats", bc.StatsKey.PlayerDoDamage),
      totalBlock = self.statsMgr:GetStats("BattleStats", bc.StatsKey.PlayerDoBlock),
      totalHeal = self.statsMgr:GetStats("BattleStats", bc.StatsKey.PlayerDoHeal),
      round = self.boutMgr:GetBoutNum()
    },
    timeout = self.timeout,
    keeperSkillIdMap = player:GetData("keeperSkillIdMap"),
    selectedKeeperSkill = player:GetData("selectedKeeperSkill"),
    randUnlockKeeperSkillUsed = player:GetData("randUnlockKeeperSkillUsed"),
    awakerMotions = self.roleMgr:GetAwakerMotions()
  }
  if self:IsPVP() then
    battleFinishData.pvpStat = {}
    battleFinishData.statistics = nil
    for _, role in ipairs(self.roleMgr:GetPlayerList()) do
      battleFinishData.pvpStat[role.data.playerId] = role.battleStats:GetBattleFinishStats()
    end
    battleFinishData.matchType = self.initData.matchType
  end
  return battleFinishData
end

function BattleEngine:RemoveObj(uid)
  self.objSet[uid] = nil
  self.data.objSet[uid] = nil
end

function BattleEngine:GetObj(uid)
  return self.objSet[uid]
end

function BattleEngine:GetCurMoney()
  return self.data.curMoney
end

function BattleEngine:ChangeMoney(value)
  local oldValue = self.data.curMoney
  self.data.curMoney = math.max(0, self.data.curMoney + value)
  self:LogBattleWithTab("贤石: %s -> %s", oldValue, self.data.curMoney)
end

function BattleEngine:ChangeStress(value)
  local oldValue = self.data.stress
  self.data.stress = math.max(0, self.data.stress + value)
  self:LogBattleWithTab("压力值: %s -> %s", oldValue, self.data.stress)
end

function BattleEngine:GetStress()
  return self.data.stress
end

function BattleEngine:SetCurCard(cardUid)
  self.curCardUid = cardUid
end

function BattleEngine:GetCurCard()
  if not self.curCardUid then
    return
  end
  do return self.GetObj, self end
  return self.GetObj, self, self.curCardUid
end

function BattleEngine:GetRelicCount(quality)
  if not self.data.relics then
    return 0
  end
  if "All" == quality then
    return #self.data.relics
  else
    local count = 0
    for _, relic in ipairs(self.data.relics) do
      local relicCfg = self.battleDT.RelicConfig[relic.tid]
      if relicCfg.Quality == quality then
        count = count + 1
      end
    end
    return count
  end
end

function BattleEngine:GetRelicCountByID(id)
  if not self.data.relics then
    return 0
  end
  local count = 0
  for _, relic in ipairs(self.data.relics) do
    if relic.tid == id then
      count = count + 1
    end
  end
  return count
end

function BattleEngine:SetIsInit(isInit)
  self.data.IsInit = isInit
end

function BattleEngine:IsInit()
  return self.data.IsInit
end

function BattleEngine:GetStageId()
  return self.data.stageId
end

function BattleEngine:GetDifficultyId()
  return self.data.difficultyId
end

function BattleEngine:GetBattleTid()
  return self.data.battleTid
end

function BattleEngine:GetMapNodeGroupId()
  return self.data.mapNodeGroupId or 0
end

function BattleEngine:GetFinishType()
  return self.data.finishType or 0
end

function BattleEngine:GetStageStar()
  return self.data.stageStar or 0
end

function BattleEngine:GetTimer()
  if self:GetSvrBattleEntity() then
    return self.initData.svrBattleEntity.timer
  end
  if self.battleRender then
    return self.battleRender.scheduler
  end
end

function BattleEngine:SetSkipTimer(skip)
  if self:GetSvrBattleEntity() then
    local ServerUtil = require("ServerUtil")
    if ServerUtil.GetEnv("public_server") then
      return
    end
  end
  self.data.skipTimer = skip
end

function BattleEngine:GetSkipTimer()
  return self.data.skipTimer
end

function BattleEngine:GetData(key)
  return self.data[key]
end

function BattleEngine:SetGlobalVariable(key, value)
  key = bc.GlobalVariableAffix .. key
  self.data.globalVariable[key] = value
end

function BattleEngine:GetGlobalVariable(key, value)
  key = bc.GlobalVariableAffix .. key
  return self.data.globalVariable[key] or 0
end

function BattleEngine:RemoveGlobalVariable(key, value)
  key = bc.GlobalVariableAffix .. key
  self.data.globalVariable[key] = nil
end

function BattleEngine:GetTargetFlag()
  return self.targetFlag
end

function BattleEngine:SetTargetFlag(flag)
  self.targetFlag = flag
end

function BattleEngine:GetCardInfo(tid)
  local initData = self.gameplay:GetInitData()
  local cards = initData.backupAwakeCards
  for _, card in pairs(cards) do
    if card.tid == tid then
      return card
    end
  end
  return nil
end

function BattleEngine:GetValByCondList(params, tid, colName, tableName)
  tableName = tableName or "Skill"
  local tableData = self.battleDT[tableName]
  if not tableData then
    return
  end
  local cfg = tableData[tid]
  if not cfg then
    return
  end
  if not colName or not cfg[colName] then
    return
  end
  local condList = cfg[colName]
  if type(condList) ~= "table" then
    return {condList}
  end
  local matchResult
  local cmdParser = BattleCmdParser(self, params)
  for i = #condList, 1, -1 do
    local condCfg = condList[i]
    local cond = condCfg[1]
    if self:IsCondMatch(cmdParser, cond) then
      matchResult = cmdParser:GetValueByCmd(condCfg[2])
      break
    end
  end
  return matchResult
end

function BattleEngine:IsCondMatch(cmdParser, cond)
  if "true" == cond then
    return true
  else
    local val = cmdParser:GetValueByCmd(cond)
    if type(val) == "boolean" then
      return val
    elseif type(val) == "number" then
      return val and val > 0
    end
    return val
  end
end

function BattleEngine:GetSkillTargetType(castRoleUid, skillId, skillLevel, breakSkillLevel, potencyLevel)
  breakSkillLevel = breakSkillLevel or 0
  potencyLevel = potencyLevel or 0
  local skillCfg = self.battleDT.Skill[skillId]
  if not skillCfg then
    return
  end
  if skillCfg.IsPVP then
    local ctorData = {
      castRoleUid = castRoleUid,
      skillConfigId = skillId,
      skillLevel = skillLevel
    }
    local matchResult
    local cmdParser = BattleCmdParser(self, ctorData)
    local condList = skillCfg.CmdTarget
    for i = #condList, 1, -1 do
      local condCfg = condList[i]
      local cond = condCfg[1]
      if self:IsCondMatch(cmdParser, cond) then
        matchResult = condCfg[2]
        break
      end
    end
    return matchResult
  end
  do return BattleUtilServer.GetTQText, skillCfg.CmdTarget, breakSkillLevel end
  return BattleUtilServer.GetTQText, skillCfg.CmdTarget, breakSkillLevel, potencyLevel, #condList, 1, -1, nil, condList[i], condCfg[1], self:IsCondMatch(cmdParser, cond), self, cmdParser, cond
end

return BattleEngine
