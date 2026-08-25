local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleCmdServer = require("Battle.DbgEngine.Cmd.BattleCmdServer")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleGMServer, Super = System.NewClass("BattleGMServer", BattleEngineComponent)

function BattleGMServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleGMServer.SetAwakerAttr(obj, msgData)
  obj.battleEngine.logger:DebugS("SetAwakerAttr {obj} {msgData}", obj, msgData)
  local BP = bc.BattleProperty
  local camp = msgData.camp or bc.BattleCamp.Camp1
  local player = obj.battleEngine.roleMgr:GetPlayer(camp)
  if not player then
    return
  end
  local attrName = msgData.attrName
  local attrValue = msgData.attrValue
  local awakerTid = msgData.awakerTid
  if 0 ~= awakerTid then
    local awaker = obj.battleEngine.roleMgr:GetAwakerByTid(awakerTid, camp)
    if not awaker then
      return
    end
    awaker.property:SetProperty(attrName, attrValue, {
      castRoleUid = awaker.uid
    })
  else
    local player = obj.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    player.property:SetProperty(attrName, attrValue, {
      castRoleUid = player.uid
    })
  end
end

function BattleGMServer.SetTargetStateLayer(obj, target, stateId, targetLayer, stateParams)
  local stateMgr = obj.battleEngine.stateMgr
  local state = stateMgr:GetState(target, stateId)
  local currentLayer = state and state:GetLayer() or 0
  if targetLayer == currentLayer then
    obj.battleEngine.logger:InfoS("SetAwakerStateLayer: target layer is equal to target layer, {targetLayer}", targetLayer)
    return
  end
  if targetLayer <= 0 then
    if state then
      stateMgr:RemoveState(state, true)
    end
    return
  end
  if targetLayer > currentLayer then
    local createArgs = {
      stateId = stateId,
      layer = targetLayer - currentLayer,
      castRoleUid = target.uid,
      targetUid = target.uid,
      targetRoleUid = target.uid,
      stateParams = stateParams,
      source = {
        {
          sourceType = "GM",
          tid = stateId,
          uid = target.uid,
          camp = target:GetCamp(),
          layer = targetLayer - currentLayer,
          level = 1
        }
      },
      skillLevel = 1
    }
    stateMgr:CreateState(target, createArgs)
  else
    local subLayer = currentLayer - targetLayer
    state:SubLayer(subLayer)
  end
end

function BattleGMServer.SetAwakerStateLayer(obj, msgData)
  obj.battleEngine.logger:InfoS("SetAwakerStateLayer {obj} {msgData}", obj, msgData)
  local camp = msgData.camp or bc.BattleCamp.Camp1
  local player = obj.battleEngine.roleMgr:GetPlayer(camp)
  if not player then
    return
  end
  local awakerTid = msgData.awakerTid or 0
  local stateId = msgData.stateId
  local targetLayer = tonumber(msgData.layer or 0) or 0
  local stateParams = msgData.stateParams or {}
  local target
  if 0 ~= awakerTid then
    target = obj.battleEngine.roleMgr:GetAwakerByTid(awakerTid, camp)
  else
    target = player
  end
  if not target then
    obj.battleEngine.logger:InfoS("SetAwakerStateLayer: target not exist, {awakerTid}, {camp}", awakerTid, camp)
    return
  end
  BattleGMServer.SetTargetStateLayer(obj, target, stateId, targetLayer, stateParams)
end

function BattleGMServer.SetMonsterAttr(obj, msgData)
  obj.battleEngine.logger:DebugS("SetMonsterAttr {obj} {msgData}", obj, msgData)
  local attrName = msgData.attrName
  local attrValue = msgData.attrValue
  local monsterPos = msgData.monsterPos or 0
  local monsterList = obj.battleEngine.roleMgr:GetPosSortedRoleByCamp(bc.BattleCamp.Camp2)
  if monsterPos > 0 then
    local monster = monsterList[monsterPos]
    if monster then
      monster.property:SetProperty(attrName, attrValue, {
        castRoleUid = monster.uid
      })
      obj.battleEngine.logger:DebugS("SetMonsterAttr: 设置怪物 {uid} 位置 {pos} 属性 {attrName} = {attrValue}", monster.uid, monsterPos, attrName, attrValue)
    else
      obj.battleEngine.logger:DebugS("SetMonsterAttr: 怪物 {pos} 不存在", monsterPos)
      return
    end
  else
    for _, monster in ipairs(monsterList) do
      monster.property:SetProperty(attrName, attrValue, {
        castRoleUid = monster.uid
      })
      obj.battleEngine.logger:DebugS("SetMonsterAttr: 设置怪物 {uid} 属性 {attrName} = {attrValue}", monster.uid, attrName, attrValue)
    end
  end
end

function BattleGMServer.SetMonsterStateLayer(obj, msgData)
  obj.battleEngine.logger:InfoS("SetMonsterStateLayer {obj} {msgData}", obj, msgData)
  local stateId = msgData.stateId
  local targetLayer = tonumber(msgData.layer or 0) or 0
  local stateParams = msgData.stateParams or {}
  local monsterPos = msgData.monsterPos or 0
  local monsterList = obj.battleEngine.roleMgr:GetPosSortedRoleByCamp(bc.BattleCamp.Camp2)
  if monsterPos > 0 then
    local monster = monsterList[monsterPos]
    if not monster then
      obj.battleEngine.logger:InfoS("SetMonsterStateLayer: monster not exist, {monsterPos}", monsterPos)
      return
    end
    BattleGMServer.SetTargetStateLayer(obj, monster, stateId, targetLayer, stateParams)
  else
    for _, monster in ipairs(monsterList) do
      BattleGMServer.SetTargetStateLayer(obj, monster, stateId, targetLayer, stateParams)
    end
  end
end

function BattleGMServer.SetHandCardAttr(obj, msgData)
  obj.battleEngine.logger:DebugS("SetHandCardAttr {obj} {msgData}", obj, msgData)
  local attrName = msgData.attrName
  local attrValue = msgData.attrValue
  local cardPos = msgData.cardPos or 0
  local handCardUidList = obj.battleEngine.cardMgr:GetCardListByDeck(bc.CardDeck.HandDeck)
  if cardPos > 0 then
    local cardUid = handCardUidList[cardPos]
    if cardUid then
      local card = obj.battleEngine.cardMgr:GetCardByUid(cardUid)
      if card then
        card.property:SetProperty(attrName, attrValue, {
          castRoleUid = card.owner.uid
        })
        obj.battleEngine.logger:DebugS("SetHandCardAttr: 设置手牌 {uid} 位置 {pos} 属性 {attrName} = {attrValue}", card.uid, cardPos, attrName, attrValue)
      else
        obj.battleEngine.logger:DebugS("SetHandCardAttr: 卡牌 {uid} 不存在", cardUid)
        return
      end
    else
      obj.battleEngine.logger:DebugS("SetHandCardAttr: 手牌位置 {pos} 不存在", cardPos)
      return
    end
  else
    for _, cardUid in ipairs(handCardUidList) do
      local card = obj.battleEngine.cardMgr:GetCardByUid(cardUid)
      if card then
        card.property:SetProperty(attrName, attrValue, {
          castRoleUid = card.owner.uid
        })
        obj.battleEngine.logger:DebugS("SetHandCardAttr: 设置手牌 {uid} 属性 {attrName} = {attrValue}", card.uid, attrName, attrValue)
      end
    end
  end
end

function BattleGMServer.SetPosRoleAttr(obj, msgData)
  local camp = msgData.camp or bc.BattleCamp.Camp1
  local pos = tonumber(msgData.pos or 0) or 0
  local attrName = msgData.attrName
  local attrValue = msgData.attrValue
  local target = obj.battleEngine.roleMgr:GetAwakerByPos(camp, pos)
  if not target then
    return
  end
  target.property:SetProperty(attrName, attrValue, {
    castRoleUid = target.uid
  })
end

function BattleGMServer.SetPosRoleStateLayer(obj, msgData)
  local camp = msgData.camp or bc.BattleCamp.Camp1
  local pos = tonumber(msgData.pos or 0) or 0
  local stateId = msgData.stateId
  local targetLayer = tonumber(msgData.layer or 0) or 0
  local stateParams = msgData.stateParams or {}
  local target = obj.battleEngine.roleMgr:GetAwakerByPos(camp, pos)
  if not target then
    return
  end
  BattleGMServer.SetTargetStateLayer(obj, target, stateId, targetLayer, stateParams)
end

function BattleGMServer.SetHandCardStateLayer(obj, msgData)
  obj.battleEngine.logger:InfoS("SetHandCardStateLayer {obj} {msgData}", obj, msgData)
  local stateId = msgData.stateId
  local targetLayer = tonumber(msgData.layer or 0) or 0
  local stateParams = msgData.stateParams or {}
  local cardPos = msgData.cardPos or 0
  local handCardUidList = obj.battleEngine.cardMgr:GetCardListByDeck(bc.CardDeck.HandDeck)
  if cardPos > 0 then
    local cardUid = handCardUidList[cardPos]
    if not cardUid then
      obj.battleEngine.logger:InfoS("SetHandCardStateLayer: hand card pos not exist, {cardPos}", cardPos)
      return
    end
    local card = obj.battleEngine.cardMgr:GetCardByUid(cardUid)
    if not card then
      obj.battleEngine.logger:InfoS("SetHandCardStateLayer: card not exist, {cardUid}", cardUid)
      return
    end
    BattleGMServer.SetTargetStateLayer(obj, card, stateId, targetLayer, stateParams)
  else
    for _, cardUid in ipairs(handCardUidList) do
      local card = obj.battleEngine.cardMgr:GetCardByUid(cardUid)
      if card then
        BattleGMServer.SetTargetStateLayer(obj, card, stateId, targetLayer, stateParams)
      end
    end
  end
end

local gmFunc = {
  [bc.BattleGMType.NewHandCard] = function(self, msgData)
    local configIds = {}
    for _ = 1, msgData.number or 1 do
      table.insert(configIds, {
        tid = msgData.configId,
        level = 1
      })
    end
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local owner
    if self.battleEngine:IsPVP() then
      local cfg = self.battleEngine.battleDT.Skill[msgData.configId]
      if cfg.AwakerID then
        local awaker = self.battleEngine.roleMgr:GetAwakerByTid(cfg.AwakerID, self.camp)
        if not awaker then
          local awakerList = self.battleEngine.roleMgr:GetPVPRoleList("AliveOnly", camp)
          owner = awakerList[1]
        end
      end
    end
    local addConfig = {
      targetPos = nil,
      enternal = nil,
      show = true,
      cardArgs = nil,
      runes = nil,
      camp = camp,
      owner = owner
    }
    self.battleEngine.cardMgr:AddNewCard(configIds, bc.CardDeck.HandDeck, addConfig)
  end,
  [bc.BattleGMType.AddRelic] = function(self, msgData)
    local relicTid = msgData.configId
    local cmdCtorData = {
      castRoleUid = self.battleEngine.roleMgr:GetPlayer() and self.battleEngine.roleMgr:GetPlayer().uid
    }
    local effectConfig = {
      effectType = bc.BattleEffectType.BEGainRelicById,
      cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData),
      targets = {},
      params = {relicTid}
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end,
  [bc.BattleGMType.RemoveRelic] = function(self, msgData)
    local relicTid = msgData.configId
    local cmdCtorData = {
      castRoleUid = self.battleEngine.roleMgr:GetPlayer() and self.battleEngine.roleMgr:GetPlayer().uid
    }
    local effectConfig = {
      effectType = bc.BattleEffectType.BERemoveRelic,
      cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData),
      targets = {},
      params = {relicTid}
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end,
  [bc.BattleGMType.BattleEnd] = function(self, msgData)
    self.battleEngine:ActiveBattleEnd(msgData.winCamp, true, msgData.timeout)
  end,
  [bc.BattleGMType.SkipStuckEffect] = function(self, msgData)
    local battleEngine = self.battleEngine
    local camp = msgData.camp or bc.BattleCamp.Camp1
    battleEngine:InfoS("SkipStuckEffectGM sync battle state {camp} {recovering}", camp, battleEngine.recovering)
    if not battleEngine:IsBattleFinish() then
      battleEngine.cardMgr:UpdateCardArgs()
      battleEngine.roleMgr:UpdateMonsterIntention()
      battleEngine.roleMgr:UpdateSkillArgs()
      battleEngine.roleMgr:UpdateSilverKeyAwakeArgs()
      battleEngine.roleMgr:UpdateSchoolArgs()
      battleEngine.cardMgr:CheckHandCardHighlight()
      battleEngine.stateMgr:UpdateStateArgs()
    end
    if battleEngine:IsPVE() then
      battleEngine.statsMgr:UpdateStats()
    end
    if battleEngine:IsPVP() then
      for _, campIter in ipairs({
        bc.BattleCamp.Camp1,
        bc.BattleCamp.Camp2
      }) do
        local player = battleEngine.roleMgr:GetPlayer(campIter)
        if player then
          player.battleStats:UpdateStats()
        end
      end
    end
    battleEngine.cardMgr:ClearNoneDeckCards()
    battleEngine.stateMgr:ClearDeletedState()
    battleEngine:ReconnectBattle(camp)
  end,
  [bc.BattleGMType.CheckEnergy] = function(self, msgData)
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    player:GainEnergy(msgData.energyNum)
  end,
  [bc.BattleGMType.AddUtiEnergy] = function(self, msgData)
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    local pos = tonumber(msgData.pos or 0)
    local addValue = tonumber(msgData.addValue or 0)
    local roleList = self.battleEngine.roleMgr:GetRoleList()
    for _, role in ipairs(roleList) do
      if role:IsRoleType(bc.RoleType.Awaker) and (0 == pos or role:GetBattleFieldPos() == pos) then
        if addValue > 0 then
          role:GainUltiEnergy(addValue, {})
        end
        if addValue < 0 then
          role:LoseUltiEnergy(math.abs(addValue), {})
        end
      end
    end
  end,
  [bc.BattleGMType.ModifyHp] = function(self, msgData)
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    local left_num = tonumber(msgData.num or 0)
    local modify_value = left_num - player:GetProperty(bc.BattleProperty.hp)
    local modifyConfig = {
      castRoleUid = player.uid,
      destRoleUid = player.uid,
      modifyVal = modify_value,
      ignoreStats = true
    }
    player:ModifyHp(modifyConfig)
  end,
  [bc.BattleGMType.PrintSnapShot] = function(self, msgData)
    self.battleEngine.battleLogMgr:PrintSnapShot()
  end,
  [bc.BattleGMType.AttackAllEnermyToDie] = function(self, msgData)
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
    local targets = self.battleEngine.roleMgr:GetAliveRoleListByCamp(enemyCamp)
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    local damageVal = msgData.damageNum
    for _, target in ipairs(targets) do
      local attackConfig = {
        castRoleUid = player.uid,
        damageVal = damageVal,
        damageType = bc.DamageType.Active,
        damageSubType = bc.DamageSubType.Normal
      }
      target:BeHit(attackConfig)
    end
  end,
  [bc.BattleGMType.AddKeeperEnergy] = function(self, msgData)
    local camp = msgData.camp or bc.BattleCamp.Camp1
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    local addValue = tonumber(msgData.addValue or 0)
    player:AddProperty(bc.BattleProperty.keeper_energy, addValue, {})
  end,
  [bc.BattleGMType.SwitchTimer] = function(self, msgData)
    local skipTimer = self.battleEngine:GetSkipTimer()
    local camp = self.battleEngine.boutMgr:GetCurCamp()
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    local awaker = player:GetAwakerList()[1]
    local textType = bc.FloatingTextType.Heal
    if skipTimer then
      self.battleEngine.instantRecordMgr:OnFloatingText(awaker.uid, "倒计时已开启，手动结束回合，下个回合会有倒计时", textType)
    else
      self.battleEngine.instantRecordMgr:OnFloatingText(awaker.uid, "倒计时已关闭，已经在倒计时中的开启的定时器不受影响", textType)
    end
    self.battleEngine:SetSkipTimer(not skipTimer)
  end,
  [bc.BattleGMType.MoveAwaker] = function(self, msgData)
    local fromPos = msgData.fromPos
    local toPos = msgData.toPos
    local camp = self.battleEngine.boutMgr:GetCurCamp()
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    if not player then
      return
    end
    local toAwaker = self.battleEngine.roleMgr:GetAwakerByPos(camp, toPos)
    if not toAwaker then
      return
    end
    local fromAwaker = self.battleEngine.roleMgr:GetAwakerByPos(camp, fromPos)
    if not fromAwaker then
      return
    end
    fromAwaker:SetBattleFieldPos(toPos)
    self.battleEngine.recordMgr:OnMonsterChangePos(fromAwaker.uid, fromAwaker:GetBattleFieldPos())
    toAwaker:SetBattleFieldPos(fromPos)
    self.battleEngine.recordMgr:OnMonsterChangePos(toAwaker.uid, toAwaker:GetBattleFieldPos())
  end,
  [bc.BattleGMType.ExeCmd] = function(self, msgData)
    local cmd = msgData.cmd
    local cmdCtorData = {
      castRoleUid = self.battleEngine.roleMgr:GetPlayer() and self.battleEngine.roleMgr:GetPlayer().uid
    }
    local effectConfig = {
      effectType = bc.BattleEffectType.BEExecuteCmd,
      cmdServer = BattleCmdServer(self.battleEngine, cmdCtorData),
      params = {
        tonumber(cmd)
      }
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end,
  [bc.BattleGMType.RewindToBout] = function(self, msgData)
    local ok, err = self.battleEngine:RewindToBout(msgData.boutNumber)
    msgData.ret = ok and true or false
    msgData.errorMsg = err
    msgData.currentBout = self.battleEngine.boutMgr:GetBoutNum()
    self.battleEngine:SendCommand(BattleCommand.rd_CommandResult, msgData)
  end,
  [bc.BattleGMType.SetAwakerAttr] = function(self, msgData)
    do return BattleGMServer.SetAwakerAttr, self end
    return BattleGMServer.SetAwakerAttr, self, msgData
  end,
  [bc.BattleGMType.SetMonsterAttr] = function(self, msgData)
    do return BattleGMServer.SetMonsterAttr, self end
    return BattleGMServer.SetMonsterAttr, self, msgData
  end,
  [bc.BattleGMType.SetHandCardAttr] = function(self, msgData)
    do return BattleGMServer.SetHandCardAttr, self end
    return BattleGMServer.SetHandCardAttr, self, msgData
  end,
  [bc.BattleGMType.SetAwakerStateLayer] = function(self, msgData)
    do return BattleGMServer.SetAwakerStateLayer, self end
    return BattleGMServer.SetAwakerStateLayer, self, msgData
  end,
  [bc.BattleGMType.SetMonsterStateLayer] = function(self, msgData)
    do return BattleGMServer.SetMonsterStateLayer, self end
    return BattleGMServer.SetMonsterStateLayer, self, msgData
  end,
  [bc.BattleGMType.SetHandCardStateLayer] = function(self, msgData)
    do return BattleGMServer.SetHandCardStateLayer, self end
    return BattleGMServer.SetHandCardStateLayer, self, msgData
  end,
  [bc.BattleGMType.SetPosRoleStateLayer] = function(self, msgData)
    do return BattleGMServer.SetPosRoleStateLayer, self end
    return BattleGMServer.SetPosRoleStateLayer, self, msgData
  end,
  [bc.BattleGMType.SetPosRoleAttr] = function(self, msgData)
    do return BattleGMServer.SetPosRoleAttr, self end
    return BattleGMServer.SetPosRoleAttr, self, msgData
  end,
  [bc.BattleGMType.PrintBattleStatPackDump] = function(self, msgData)
    local statsMgr = self.battleEngine.statsMgr
    if not statsMgr or not statsMgr.battleStatPackMgr then
      self.battleEngine.logger:WarningS("PrintBattleStatPackDump: statsMgr 或 battleStatPackMgr 不存在")
      return
    end
    statsMgr.battleStatPackMgr:LogBattleStatPackHierarchy()
  end
}

function BattleGMServer:SafeLogStr(value)
  if nil == value then
    return "nil"
  end
  local ok, str = pcall(function()
    if type(value) == "table" then
      do return table.tostring end
      return table.tostring, value
    end
    do return tostring end
    return tostring, value
  end)
  if not ok or not str then
    return "serialize_err"
  end
  if #str > 512 then
    return string.sub(str, 1, 512) .. "...(truncated)"
  end
  return str
end

function BattleGMServer:LogSkipStuckEffectSnapshot()
  local battleEngine = self.battleEngine
  local logOk, logErr = pcall(function()
    local effectMgr = battleEngine.effectMgr
    local waitingCommand, yieldData = effectMgr:GetEffectOrderInterrupted()
    local stuckEffect = effectMgr.runningEffect or effectMgr.rootEffect
    local cmdServer = stuckEffect and stuckEffect.cmdServer
    local curCardTid
    if battleEngine.curCardUid then
      local curCard = battleEngine:GetCurCard()
      if curCard then
        curCardTid = curCard.tid
      end
    end
    battleEngine:InfoS("SkipStuckEffectSnapshot {battleUuid} {boutNum} {curCamp} {battlePhase} {rootEffectUid} {runningEffectUid} {effectType} {cmdId} {castRoleUid} {waitingCommand} {isRecording} {recovering} {waitingTimes} {passTime} {hasRootOrder} {runEffectNum} {curCardUid} {curCardTid} {yieldData}", battleEngine.initData and battleEngine.initData.battleUuid, battleEngine.boutMgr and battleEngine.boutMgr:GetBoutNum(), battleEngine.boutMgr and battleEngine.boutMgr:GetCurCamp(), battleEngine.data and battleEngine.data.battlePhase, effectMgr:GetRootEffectUid(), effectMgr:GetRunningEffectUid(), stuckEffect and stuckEffect.effectType, cmdServer and cmdServer.cmdId, cmdServer and cmdServer.castRoleUid, waitingCommand, battleEngine.recordMgr and battleEngine.recordMgr.isRecording, battleEngine.recovering, battleEngine.data and battleEngine.data.waitingTimes, battleEngine.data and battleEngine.data.passTime, effectMgr:IsRootEffectOrderExist(), effectMgr.runEffectNum, battleEngine.curCardUid, curCardTid, self:SafeLogStr(yieldData))
  end)
  if not logOk then
    battleEngine:WarnS("SkipStuckEffectSnapshot log failed {err}", logErr)
  end
end

function BattleGMServer:OnReceiveGM(msgData)
  local gmType = msgData.gm
  if self.battleEngine.initData.svrBattleEntity then
    local ServerUtil = require("ServerUtil")
    if not ServerUtil.GetEnv("enable_gm") then
      return false
    end
  end
  if gmType == bc.BattleGMType.SkipStuckEffect then
    self:LogSkipStuckEffectSnapshot()
    self.battleEngine:SetPassTime(0)
    self.battleEngine.recovering = false
    self.battleEngine.data.waitingTimes = 0
    self.battleEngine.effectMgr:GMStop()
    self.battleEngine.recordMgr.isRecording = false
    self.battleEngine.effectMgr:Resume()
  end
  if gmType == bc.BattleGMType.BattleEnd then
    self.battleEngine:SetPassTime(0)
    self.battleEngine.effectMgr:GMStop()
    self.battleEngine.recordMgr.isRecording = false
  end
  if self.battleEngine.recordMgr.isRecording then
    self.battleEngine:Error("逻辑正在执行中，不能终止")
    return false
  end
  if msgData.playerId then
    local player = self.battleEngine.roleMgr:GetRoleByPlayerId(msgData.playerId)
    msgData.camp = player and player:GetCamp() or bc.BattleCamp.Camp1
    if msgData.enemyCamp then
      msgData.camp = bc.BattleCamp:GetEnemyCamp(msgData.camp)
    end
  end
  local preFunc = gmFunc[gmType]
  if preFunc then
    self.battleEngine:RunEffectOrder(function()
      preFunc(self, msgData)
    end, {})
  end
end

function BattleGMServer:Dispose()
  self.battleEngine = nil
end

return BattleGMServer
