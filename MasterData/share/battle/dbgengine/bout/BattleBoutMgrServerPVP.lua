local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleBoutMgrServerPVP, Super = System.NewClass("BattleBoutMgrServerPVP", BattleEngineComponent)

function BattleBoutMgrServerPVP:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.camp = bc.BattleCamp.None
  self.initCamp = bc.BattleCamp.Camp1
  self.boutNumber = 0
  self.phase = bc.BoutPhase.None
end

function BattleBoutMgrServerPVP:BeginBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  self.battleEngine.cardMgr:ClearCardShuffleTag(self.camp)
  
  local function preFunc()
    local boutBeginDelay = 0
    if self.camp == bc.BattleCamp.None then
      boutBeginDelay = 0.5
    end
    local battleFlowEventIds
    if self.camp == bc.BattleCamp.None then
      self.camp = self.initCamp
      self.battleEngine:InfoS("BeginBout 先手阵营 {camp}", self.camp)
    else
      self.camp = bc.BattleCamp:GetEnemyCamp(self.camp)
    end
    if self.camp == self.initCamp then
      self.boutNumber = self.boutNumber + 1
      self.battleEngine.snapshotMgr:OnSaveSnapshot()
    end
    battleFlowEventIds = {
      {
        BattleLogicEvent.BFBeforeBoutBegin,
        boutBeginDelay
      },
      {
        BattleLogicEvent.BFBoutBegin,
        0.2
      },
      {
        BattleLogicEvent.BFAfterBoutBegin,
        0
      },
      {
        BattleLogicEvent.BFBeforeDrawCards,
        0
      },
      {
        BattleLogicEvent.BFDrawCards,
        0
      },
      {
        BattleLogicEvent.BFAfterDrawCards,
        0
      }
    }
    for _, data in ipairs(battleFlowEventIds) do
      local effectType = bc.BattleEffectType.BEBattleFlow
      local effectConfig = {
        effectType = effectType,
        BattleFlowEventId = data[1],
        BeforeDelay = data[2]
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
  end
  
  local finishCb = {
    func = self.ActionBout,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServerPVP:ActionBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  local afterOrderFinishedCb, cbTarget
  local cbData = {}
  local actionDelay = 0
  local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
  if not self.battleEngine:IsServerBattle() and self.camp == bc.BattleCamp.Camp2 then
    afterOrderFinishedCb = self.battleEngine.aiMgr.StartAI
    cbTarget = self.battleEngine.aiMgr
    cbData = {
      self.camp
    }
  end
  if player:IsAI() then
    afterOrderFinishedCb = self.battleEngine.aiMgr.StartAI
    cbTarget = self.battleEngine.aiMgr
    cbData = {
      self.camp
    }
  end
  
  local function preFunc()
    local effectConfig = {
      effectType = bc.BattleEffectType.BEBattleFlow,
      BattleFlowEventId = BattleLogicEvent.BFBoutAction,
      BeforeDelay = actionDelay
    }
    self.battleEngine.effectMgr:CreateEffect(effectConfig)
  end
  
  local finishCb = {
    func = afterOrderFinishedCb,
    target = cbTarget,
    data = cbData
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServerPVP:EndBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  local effectTypeList = {
    {
      BattleLogicEvent.BFBeforeDiscardCards,
      0
    },
    {
      BattleLogicEvent.BFDiscardCards,
      0
    },
    {
      BattleLogicEvent.BFAfterDiscardCards,
      0
    },
    {
      BattleLogicEvent.BFBeforeBoutEnd,
      0
    },
    {
      BattleLogicEvent.BFBoutEnd,
      0
    },
    {
      BattleLogicEvent.BFAfterBoutEnd,
      0
    }
  }
  
  local function preFunc()
    local effectType = bc.BattleEffectType.BEBattleFlow
    for _, data in ipairs(effectTypeList) do
      local effectConfig = {
        effectType = effectType,
        BattleFlowEventId = data[1],
        BeforeDelay = data[2]
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
  end
  
  local finishCb = {
    func = self.BeginBout,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServerPVP:GetIsExtraBout()
  return self.isExtraBout
end

function BattleBoutMgrServerPVP:GetBoutPlayerId()
  local battleData = self.battleEngine.initData
  return battleData[self.camp].playerId
end

function BattleBoutMgrServerPVP:CanHandleMsg(msgData)
  local playerId = msgData.playerId
  return playerId == self:GetBoutPlayerId()
end

function BattleBoutMgrServerPVP:CanPlayerEndBout(msgData)
  if self:GetBoutNum() ~= msgData.boutNumber then
    self.battleEngine:Warn("ERROR：回合数不匹配！", self:GetBoutNum(), msgData.boutNumber)
    return false
  end
  if self:GetBoutPlayerId() ~= msgData.playerId then
    self.battleEngine:Warn("ERROR：不是玩家回合！", self.camp)
    return false
  end
  if self.phase ~= bc.BoutPhase.Action then
    self.battleEngine:Warn("ERROR：不在回合行动阶段!", self.phase)
    return false
  end
  return true
end

function BattleBoutMgrServerPVP:Serialize()
  return {
    camp = self.camp,
    boutNumber = self.boutNumber,
    phase = self.phase
  }
end

function BattleBoutMgrServerPVP:OnRecover(boutData)
  self.camp = boutData.camp
  self.boutNumber = boutData.boutNumber
  self.phase = boutData.phase
end

function BattleBoutMgrServerPVP:ChangeBoutPhase(newPhase, config)
  self.battleEngine.recordMgr:OnChangeBoutPhase(self.phase, newPhase, config)
  self.phase = newPhase
end

function BattleBoutMgrServerPVP:GetCurCamp()
  return self.camp
end

function BattleBoutMgrServerPVP:GetBoutNum()
  return self.boutNumber
end

function BattleBoutMgrServerPVP:GetCurCampName()
  do return string.format, "阵营 %s" end
  return string.format, "阵营 %s", self.camp
end

function BattleBoutMgrServerPVP:IncreaseActionIndex()
  self.actionNumber = (self.actionNumber or 0) + 1
end

function BattleBoutMgrServerPVP:GetCurActionIndex()
  return self.actionNumber or 0
end

return BattleBoutMgrServerPVP
