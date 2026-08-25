local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local BP = bc.BattleProperty
local BattleRobotMgrServer, Super = System.NewClass("BattleRobotMgrServer", BattleEngineComponent)

local function shuffle(list)
  for index = 1, #list do
    local targetIndex = math.random(1, #list)
    local temp = list[index]
    list[index] = list[targetIndex]
    list[targetIndex] = temp
  end
end

local PriorityFunc = {
  MinHpIncludingShieldsCondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.hp) + target:GetProperty(BP.block)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value > cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  MaxHpIncludingShieldsCondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.hp) + target:GetProperty(BP.block)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value < cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  MinHpCondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.hp)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value > cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  MaxHpCondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.hp)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value < cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  FrontCondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetBattleFieldPos()
      if 0 == #ret or value > cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  MaxUECondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.ulti_energy)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value < cur then
        ret = {target}
        value = cur
      end
    end
    return {ret}
  end,
  MinUECondition = function(targetList)
    local ret = {}
    local value
    for _, target in ipairs(targetList) do
      local cur = target:GetProperty(BP.ulti_energy)
      if value and cur == value then
        table.insert(ret, target)
      end
      if 0 == #ret or value > cur then
        ret = {target}
        value = cur
      end
    end
    return ret
  end,
  EnemyCondition = function(targetList, camp)
    local ret = {}
    for _, target in ipairs(targetList) do
      if target:GetCamp() ~= camp then
        table.insert(ret, target)
      end
    end
    return ret
  end,
  AllyCondition = function(targetList, camp)
    local ret = {}
    for _, target in ipairs(targetList) do
      if target:GetCamp() == camp then
        table.insert(ret, target)
      end
    end
    return ret
  end,
  RandomCondition = function(targetList)
    return targetList
  end,
  StateOwnerCondition = function(targetList, camp, battleEngine)
    local ret = {}
    for _, target in ipairs(targetList) do
      if battleEngine.stateMgr:HasStateTypeNotNil(target.uid) then
        table.insert(ret, target)
      end
    end
    return ret
  end,
  BuffStateOwnerCondition = function(targetList, camp, battleEngine)
    local ret = {}
    for _, target in ipairs(targetList) do
      if battleEngine.stateMgr:HasStateByType(target.uid, bc.BuffType.Buff) then
        table.insert(ret, target)
      end
    end
    return ret
  end,
  DBuffStateOwnerCondition = function(targetList, camp, battleEngine)
    local ret = {}
    for _, target in ipairs(targetList) do
      if battleEngine.stateMgr:HasStateByType(target.uid, bc.BuffType.DeBuff) then
        table.insert(ret, target)
      end
    end
    return ret
  end
}

function BattleRobotMgrServer:GetPVPSelectTargetAwaker(camp, yieldData)
  local targetList = {}
  for _, targetUid in ipairs(yieldData.targetUids) do
    local target = self.battleEngine:GetObj(targetUid)
    table.insert(targetList, target)
  end
  if not yieldData.skillConfigId then
    return targetList
  end
  local skillCfg = self.battleEngine.battleDT.Skill[yieldData.skillConfigId]
  local awaker = self.battleEngine.roleMgr:GetAwakerByTid(skillCfg.AwakerID, camp)
  local breakSkillLevel, potencyLevel = 0, 0
  if awaker then
    breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  end
  local aiTarget = BattleUtilServer.GetTQText(skillCfg.SkillAITarget, breakSkillLevel, potencyLevel)
  local conditionList = {}
  if aiTarget then
    conditionList = string.split(aiTarget, ",")
  end
  for _, condition in ipairs(conditionList) do
    if PriorityFunc[condition] then
      targetList = PriorityFunc[condition](targetList, camp, self.battleEngine)
    end
  end
  local uids = {}
  for _, target in ipairs(targetList) do
    table.insert(uids, target.uid)
  end
  local num = bc.PVPTargetNum[yieldData.targetType]
  local ret = {}
  if num then
    shuffle(uids)
    for i = 1, num do
      table.insert(ret, uids[i])
    end
  else
    ret = uids
  end
  return ret
end

function BattleRobotMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleRobotMgrServer:WaitingCommand(waitingCommand, yieldData, camp)
  local runningEffect = self.battleEngine.effectMgr:GetRunningEffect()
  if waitingCommand == BattleCommand.lg_SelectTargets then
    local msg = string.format("处理选择指令：data=%s", table.tostring(yieldData))
    self.battleEngine:Info(msg)
    local msgData
    if yieldData.targetSelectType == bc.TargetSelectType.Card then
      local num = math.random(yieldData.minNum, yieldData.selectNum)
      local targetUids = table.clone(yieldData.targetUids)
      local targetUidOrders = {}
      for _, uid in ipairs(targetUids) do
        local card = self.battleEngine:GetObj(uid)
        if not card then
        else
          local ctorData = {
            castRoleUid = card.owner and card.owner.uid,
            skillConfigId = card.tid,
            skillLevel = card.level,
            cardUid = card.uid
          }
          local order = self.battleEngine:GetValByCondList(ctorData, card.tid, "SkillChooseOrder") or 0
          if order >= 0 then
            table.insert(targetUidOrders, {uid = uid, order = order})
          end
        end
      end
      table.sort(targetUidOrders, function(a, b)
        return a.order > b.order
      end)
      local uids = {}
      for i = 1, num do
        if targetUidOrders and targetUidOrders[i] then
          table.insert(uids, targetUidOrders[i].uid)
        end
      end
      msgData = {
        effectUid = runningEffect.uid,
        targetUids = uids,
        selectType = yieldData.targetSelectType
      }
    elseif yieldData.targetSelectType == bc.TargetSelectType.Awaker then
      local selectUid
      if self.battleEngine:IsPVP() then
        selectUid = self:GetPVPSelectTargetAwaker(camp, yieldData)
      else
        selectUid = {
          yieldData.targetUids[math.random(#yieldData.targetUids)]
        }
      end
      msgData = {
        effectUid = runningEffect.uid,
        targetUids = selectUid,
        selectType = yieldData.targetSelectType
      }
    elseif yieldData.targetSelectType == bc.TargetSelectType.KeeperSkill then
      local num = math.random(yieldData.minNum, yieldData.selectNum)
      local targetUids = table.clone(yieldData.targetUids)
      shuffle(targetUids)
      local uids = {}
      for i = 1, num do
        if targetUids and targetUids[i] then
          table.insert(uids, targetUids[i].uid)
        end
      end
      msgData = {
        effectUid = runningEffect.uid,
        targetUids = uids,
        selectType = yieldData.targetSelectType
      }
    elseif yieldData.targetSelectType == bc.TargetSelectType.Relic then
      local relicUid = yieldData.targetUids[math.random(#yieldData.targetUids)]
      msgData = {
        effectUid = runningEffect.uid,
        targetUids = {relicUid},
        selectType = yieldData.targetSelectType
      }
    elseif yieldData.targetSelectType == bc.TargetSelectType.CardDrop then
      local packCount = yieldData.packList and #yieldData.packList or 0
      local cmdParser = runningEffect and runningEffect.cmdServer and runningEffect.cmdServer.cmdParser
      local packIndexList = {}
      if cmdParser then
        packIndexList = cmdParser:RandomSelectCardDropPackIndexes(packCount, yieldData.selectMinNum, yieldData.selectMaxNum)
      end
      msgData = {
        effectUid = runningEffect.uid,
        packIndexList = packIndexList,
        selectType = yieldData.targetSelectType
      }
    elseif yieldData.targetSelectType == bc.TargetSelectType.KeeperSkillDrop then
      local packCount = yieldData.packList and #yieldData.packList or 0
      local cmdParser = runningEffect and runningEffect.cmdServer and runningEffect.cmdServer.cmdParser
      local packIndexList = {}
      if cmdParser then
        packIndexList = cmdParser:RandomSelectCardDropPackIndexes(packCount, yieldData.selectMinNum, yieldData.selectMaxNum)
      end
      msgData = {
        effectUid = runningEffect.uid,
        packIndexList = packIndexList,
        selectType = yieldData.targetSelectType
      }
    end
    self.battleEngine:OnReceiveCommand(BattleCommand.lg_SelectTargets, msgData)
  else
    if yieldData.isReliveChoose then
      return
    end
    local msg = string.format("处理确认指令：data=%s", table.tostring(yieldData))
    self.battleEngine:Info(msg)
    local msgData = {
      effectUid = runningEffect.uid,
      confirm = true
    }
    self.battleEngine:OnReceiveCommand(BattleCommand.lg_Confirm, msgData)
  end
end

function BattleRobotMgrServer:TakeOneMove(camp, playerId)
  self.battleEngine:EnterRobotAction()
  local ok, ret = xpcall(self.__TakeOneMove, debug.traceback, self, camp, playerId)
  self.battleEngine:LeaveRobotAction()
  if not ok then
    error(ret)
  end
  return ret
end

function BattleRobotMgrServer:__TakeOneMove(camp, playerId)
  local msg = string.format("阵营 %s 玩家 %s 机器人发送行动一次", camp, playerId)
  self.battleEngine:Info(msg)
  if self.battleEngine:IsBattleFinish() then
    self.battleEngine:Info("战斗已结束")
    return false
  end
  local waitingCommand, yieldData = self.battleEngine.effectMgr:GetEffectOrderInterrupted()
  if waitingCommand then
    do return self.WaitingCommand, self, waitingCommand, yieldData end
    return self.WaitingCommand, self, waitingCommand, yieldData, camp
  end
  local ret = self:UseSkill(camp, playerId)
  if not ret then
    do return self.EndBout, self end
    return self.EndBout, self, playerId, camp
  end
end

function BattleRobotMgrServer:CheckSelectTargetCommand(camp)
  local times = 6
  while times > 0 do
    local waitingCommand, yieldData = self.battleEngine.effectMgr:GetEffectOrderInterrupted()
    if waitingCommand == BattleCommand.lg_SelectTargets then
      self.battleEngine:SetTimeoutFlag(true)
      self:WaitingCommand(waitingCommand, yieldData, camp)
      self.battleEngine:SetTimeoutFlag(false)
    else
      return
    end
    times = times - 1
  end
end

function BattleRobotMgrServer:UseUltiSkill(camp, awaker, playerId)
  local msgData = {
    roleUid = awaker.uid,
    playerId = playerId
  }
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseUltiSkill, msgData)
  self:CheckSelectTargetCommand(camp)
  if self.battleEngine:IsPVP() then
    local spineName = awaker:GetSpineName()
    local skillId, _ = awaker:GetSkillIdAndLevel()
    local skillCfg = self.battleEngine.battleDT.Skill[skillId]
    local spineCfg = self.battleEngine.battleDT.SpineEventData[spineName]
    if skillCfg and spineCfg then
      local animConfig = spineCfg[skillCfg.Perform]
      local rate = self.battleEngine.battleDT.GetConstant("PVPUltiSkillPlaybackSpeed")
      local t = math.ceil((animConfig and animConfig.duration or 0) / rate)
      self.battleEngine.aiMgr:AddNeedWaitTime(t)
    end
  end
  return true
end

function BattleRobotMgrServer:UseKeeperSkill(camp, playerId)
  local msgData = {playerId = playerId}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseKeeperSkill, msgData)
  self:CheckSelectTargetCommand(camp)
  return true
end

function BattleRobotMgrServer:UseSilverKeyAwake(camp, playerId)
  local msgData = {playerId = playerId}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseSilverKeyAwake, msgData)
  self:CheckSelectTargetCommand(camp)
  return true
end

function BattleRobotMgrServer:UseChaosType2Skill(camp, playerId)
  local msgData = {playerId = playerId}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseChaosType2Skill, msgData)
  self:CheckSelectTargetCommand(camp)
  return true
end

function BattleRobotMgrServer:UseChaosType2Skill2(camp, playerId)
  local msgData = {playerId = playerId}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseChaosType2Skill2, msgData)
  self:CheckSelectTargetCommand(camp)
  return true
end

function BattleRobotMgrServer:SwitchOceanModel(camp, playerId, model)
  local msgData = {playerId = playerId, model = model}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_SwitchOceanModel, msgData)
end

function BattleRobotMgrServer:UseBloodRecoverSkill(camp, playerId)
  local msgData = {
    playerId = playerId,
    model = "BloodHealSkill"
  }
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_BloodRecoverSkill, msgData)
end

function BattleRobotMgrServer:UseDimensionSkill(camp, playerId)
  local msgData = {playerId = playerId}
  self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseDimensionSkill, msgData)
end

function BattleRobotMgrServer:EndBout(playerId)
  local boutNum = self.battleEngine.boutMgr:GetBoutNum()
  local msgData = {boutNumber = boutNum, playerId = playerId}
  local commandId = BattleCommand.lg_BoutEnd
  if self.battleEngine:IsPVE() and self.battleEngine.boutMgr and self.battleEngine.boutMgr.CheckIsExtraBout and self.battleEngine.boutMgr:CheckIsExtraBout() then
    commandId = BattleCommand.lg_ExtraBout
  end
  self.battleEngine:OnReceiveCommand(commandId, msgData)
end

function BattleRobotMgrServer:AddSchoolSkillOrder(skillOrder, player, camp)
  if camp ~= bc.BattleCamp.Camp1 then
    return
  end
  if player:CanBloodRecoverSkill() then
    local skillId = self.battleEngine.battleDT.GetConstant("BloodHealSkill")
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {bloodRecoverSkill = true, order = order})
    end
  end
  if player:CanUseDimensionSkill() then
    local skillId = self.battleEngine.battleDT.GetConstant("DimensionSKill")
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {dimensionSkill = true, order = order})
    end
  end
  if player:CanSwitchOceanModel(bc.OceanModel.OceanModel2) then
    local skillId = self.battleEngine.battleDT.GetConstant("OceanModel2")
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {switchOceanModel2 = true, order = order})
    end
  end
  if player:CanSwitchOceanModel(bc.OceanModel.OceanModel3) then
    local skillId = self.battleEngine.battleDT.GetConstant("OceanModel3")
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {switchOceanModel3 = true, order = order})
    end
  end
end

function BattleRobotMgrServer:UseSkill(camp, playerId)
  local skillOrder = {}
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  self:AddSchoolSkillOrder(skillOrder, player, camp)
  if camp == bc.BattleCamp.Camp1 and player:CanUseKeeperSkill() then
    local skillId, level = player:GetSkillIdAndLevel()
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = level
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {keeperSkill = true, order = order})
    end
  end
  if camp == bc.BattleCamp.Camp1 and player:CanUseSilverKeyAwake() then
    local skillId, _ = player:GetSilverKeyAwakeSkill()
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {silverKeyAwake = true, order = order})
    end
  end
  if camp == bc.BattleCamp.Camp1 and player:CanUseChaosType2Skill() then
    local skillId, _ = player:GetChaosType2Skill()
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {chaosType2Skill = true, order = order})
    end
  end
  if camp == bc.BattleCamp.Camp1 and player:CanUseChaosType2Skill2() then
    local skillId, _ = player:GetChaosType2Skill2()
    local ctorData = {
      castRoleUid = player.uid,
      skillConfigId = skillId,
      skillLevel = 1
    }
    local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
    if order >= 0 then
      table.insert(skillOrder, {chaosType2Skill2 = true, order = order})
    end
  end
  local awakerList = player:GetAwakerList()
  for _, awaker in ipairs(awakerList) do
    if awaker:CanUseUltiSkill() then
      local skillId, level = awaker:GetSkillIdAndLevel()
      local ctorData = {
        castRoleUid = awaker.uid,
        skillConfigId = skillId,
        skillLevel = level
      }
      local order = self.battleEngine:GetValByCondList(ctorData, skillId, "SkillAIUseOrder") or 0
      if order >= 0 then
        table.insert(skillOrder, {awaker = awaker, order = order})
      end
    end
  end
  local cards = self.battleEngine.cardMgr:GetCardListByDeck(bc.CardDeck.HandDeck)
  for _, cardUid in ipairs(cards) do
    local card = self.battleEngine:GetObj(cardUid)
    if card.owner:CanUseCard(card.uid) then
      local ctorData = {
        castRoleUid = card.owner.uid,
        skillConfigId = card.tid,
        skillLevel = card.level,
        cardUid = card.uid
      }
      local order = self.battleEngine:GetValByCondList(ctorData, card.tid, "SkillAIUseOrder") or 0
      if order >= 0 then
        table.insert(skillOrder, {card = card, order = order})
      end
    end
  end
  table.sort(skillOrder, function(a, b)
    return a.order > b.order
  end)
  local info = skillOrder[1]
  if info then
    if info.card then
      local msgData = {
        cardUid = info.card.uid
      }
      self.battleEngine:OnReceiveCommand(BattleCommand.lg_UseCard, msgData)
      self:CheckSelectTargetCommand(camp)
      return true
    end
    if info.awaker then
      self:UseUltiSkill(camp, info.awaker, playerId)
    end
    if info.keeperSkill then
      self:UseKeeperSkill(camp, playerId)
    end
    if info.silverKeyAwake then
      self:UseSilverKeyAwake(camp, playerId)
    end
    if info.chaosType2Skill then
      self:UseChaosType2Skill(camp, playerId)
    end
    if info.chaosType2Skill2 then
      self:UseChaosType2Skill2(camp, playerId)
    end
    if info.bloodRecoverSkill then
      self:UseBloodRecoverSkill(camp, playerId)
    end
    if info.dimensionSkill then
      self:UseDimensionSkill(camp, playerId)
    end
    if info.switchOceanModel2 then
      self:SwitchOceanModel(camp, playerId, bc.OceanModel.OceanModel2)
    end
    if info.switchOceanModel3 then
      self:SwitchOceanModel(camp, playerId, bc.OceanModel.OceanModel3)
    end
    return true
  end
  return false
end

return BattleRobotMgrServer
