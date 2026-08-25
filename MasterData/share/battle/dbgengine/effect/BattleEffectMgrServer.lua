local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleEffectMgrServer, Super = System.NewClass("BattleEffectMgrServer", BattleEngineComponent)

function BattleEffectMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.effectList = {}
  self.runEffectNum = 0
end

function BattleEffectMgrServer:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.Confirm, self.OnConfirm, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.SelectTargets, self.OnSelectTargets, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CancelSelectTargets, self.OnCancelSelectTargets, self)
end

function BattleEffectMgrServer:CreateEffect(effectConfig, onlyCreate)
  local effectType = effectConfig.effectType
  local source = effectConfig.source or {}
  if not effectType then
    self.battleEngine:Error(string.format("效果的effectType没有，来源 buff %s，skill %s", source.buffName, source.tid))
    return
  end
  local effectClass = require("Battle.DbgEngine.Effect." .. effectType)
  if not effectClass then
    return
  end
  local effectObj = effectClass(self.battleEngine, effectConfig)
  table.insert(self.effectList, effectObj)
  if not onlyCreate then
    effectObj:PreTrigger(effectConfig.triggerData)
  end
  return effectObj
end

function BattleEffectMgrServer:GetEffectByUid(effectUid)
  local effect = self.battleEngine:GetObj(effectUid)
  if effect and not effect.isDeleted then
    return effect
  end
  return false
end

function BattleEffectMgrServer:GetRootEffectUid()
  if self.rootEffect then
    return self.rootEffect.uid
  end
  return 0
end

function BattleEffectMgrServer:GetRunningEffectUid()
  if self.runningEffect then
    return self.runningEffect.uid
  end
  return 0
end

function BattleEffectMgrServer:IsRootEffectOrderExist()
  return self.rootEffect ~= nil
end

function BattleEffectMgrServer:CreateEffectOrder(finishFunc, finishTarget, finishData)
  if self.rootEffect then
    error("CreateEffectOrder failed: order exist:" .. self.rootEffect.__name)
    return
  end
  self.orderFinishedCb = finishFunc
  self.orderFinishedTarget = finishTarget
  self.orderFinishedArgs = finishData
  self.effectOrderFinished = false
  self.effectOrderInterrupted = false
  self.yieldData = nil
  local effectType = bc.BattleEffectType.BERoot
  local effectConfig = {effectType = effectType}
  local onlyCreate = true
  local rootEffect = self:CreateEffect(effectConfig, onlyCreate)
  if not rootEffect then
    error("CreateEffectOrder failed: create failed")
    return
  end
  self.battleEngine:Info("CreateEffectOrder rootEffect:", rootEffect.uid)
  self.rootEffect = rootEffect
end

function BattleEffectMgrServer:AddRunEffectNum()
  self.runEffectNum = self.runEffectNum + 1
end

function BattleEffectMgrServer:IsOverflow()
  local maxEffectNum = 10000
  return maxEffectNum < self.runEffectNum
end

function BattleEffectMgrServer:RunRootEffect()
  if not self.rootEffect then
    error("RunRootEffect failed: rootEffect not exist")
    return
  end
  if self.rootEffect:TryDoEffect() then
    do return self.rootEffect.XpcallDoEffect end
    return self.rootEffect.XpcallDoEffect, self.rootEffect
  else
    do return self.rootEffect.EffectEnd end
    return self.rootEffect.EffectEnd, self.rootEffect
  end
end

function BattleEffectMgrServer:EffectEnd(effectUid)
  if self.effectOrderFinished then
    return
  end
  if self.rootEffect.uid == effectUid then
    self.effectOrderFinished = true
    self.battleEngine:Info("EffectEnd rootEffect:", effectUid)
  end
end

function BattleEffectMgrServer:ClearFinishCb()
  self.orderFinishedCb = nil
  self.orderFinishedTarget = nil
  self.orderFinishedArgs = nil
end

function BattleEffectMgrServer:AfterEffectOrderFinished()
  local orderFinishedCb = self.orderFinishedCb
  local orderFinishedTarget = self.orderFinishedTarget
  local orderFinishedArgs = self.orderFinishedArgs
  self:ClearFinishCb()
  self.runningEffect = nil
  self.effectOrderFinished = nil
  self.effectOrderInterrupted = nil
  self.yieldData = nil
  self.runEffectNum = 0
  self.rootEffect = nil
  for i = #self.effectList, 1, -1 do
    local effect = self.effectList[i]
    if effect.isDeleted then
      effect:Dispose()
      table.remove(self.effectList, i)
    end
  end
  if orderFinishedCb then
    orderFinishedCb(orderFinishedTarget, table.unpack(orderFinishedArgs))
  end
end

function BattleEffectMgrServer:GMStop()
  self:ClearFinishCb()
  self.runningEffect = nil
  self.effectOrderFinished = nil
  self.yieldData = nil
  self.effectOrderInterrupted = nil
  self.runEffectNum = 0
  self.rootEffect = nil
  for i = #self.effectList, 1, -1 do
    local effect = self.effectList[i]
    if effect.isDeleted then
      table.remove(self.effectList, i)
    end
  end
end

function BattleEffectMgrServer:IsEffectOrderFinished()
  return self.effectOrderFinished
end

function BattleEffectMgrServer:GetEffectOrderInterrupted()
  return self.effectOrderInterrupted, self.yieldData
end

function BattleEffectMgrServer:Yield(waitingCommand, data)
  self.effectOrderInterrupted = waitingCommand
  self.yieldData = data
end

function BattleEffectMgrServer:Resume()
  self.effectOrderInterrupted = nil
  self.yieldData = nil
end

function BattleEffectMgrServer:SetRunningEffect(effectObj)
  self.runningEffect = effectObj
end

function BattleEffectMgrServer:GetRunningEffect()
  return self.runningEffect
end

function BattleEffectMgrServer:GetParentEffectUid()
  if self.runningEffect then
    return self.runningEffect.uid
  end
  if self.rootEffect then
    return self.rootEffect.uid
  end
  return 0
end

function BattleEffectMgrServer:OnConfirm(msgData)
  if self.runningEffect.uid ~= msgData.effectUid then
    return
  end
  do return self.runningEffect.OnConfirm, self.runningEffect end
  return self.runningEffect.OnConfirm, self.runningEffect, msgData
end

function BattleEffectMgrServer:OnSelectTargets(msgData)
  if self.runningEffect.uid ~= msgData.effectUid then
    return
  end
  print("OnSelectTargets", self.runningEffect.uid, msgData.effectUid)
  do return self.runningEffect.OnSelectTargets, self.runningEffect end
  return self.runningEffect.OnSelectTargets, self.runningEffect, msgData, msgData.effectUid
end

function BattleEffectMgrServer:OnCancelSelectTargets(msgData)
  print("OnCancelSelectTargets", self.runningEffect.uid, msgData.effectUid)
  self.rootEffect:EffectEnd()
end

function BattleEffectMgrServer:ClearAll()
  self:ClearFinishCb()
  self.runningEffect = nil
  self.effectOrderFinished = nil
  self.effectOrderInterrupted = nil
  self.yieldData = nil
  self.runEffectNum = 0
  self.rootEffect = nil
  self.effectList = {}
  if self.battleEngine then
    self.battleEngine.pendingForceEndBout = false
    if self.battleEngine.Debug then
      self.battleEngine:Debug("效果队列已清空")
    end
  end
end

return BattleEffectMgrServer
