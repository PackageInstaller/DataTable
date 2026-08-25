local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BP = bc.BattleProperty
local BattleBoutMgrServer, Super = System.NewClass("BattleBoutMgrServer", BattleEngineComponent)

function BattleBoutMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.camp = bc.BattleCamp.None
  self.boutNumber = 0
  self.actionNumber = 0
  self.isExtraBout = false
  self.phase = bc.BoutPhase.None
  self.boutEndTime = 0
end

function BattleBoutMgrServer:BeginBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  local boutBeginDelay = 0
  if self.camp == bc.BattleCamp.None then
    boutBeginDelay = 0.5
  end
  
  local function preFunc()
    if self.camp == bc.BattleCamp.None then
      local firstbattle = self.battleEngine.battleDT.GetConstant("PrologueFirstBattle")
      if self.battleEngine.data.battleTid == firstbattle then
        self.boutNumber = self.boutNumber + 1
        self.actionNumber = 0
        self.camp = bc.BattleCamp.Camp2
      else
        self.camp = bc.BattleCamp.Camp1
      end
    else
      self.camp = bc.BattleCamp:GetEnemyCamp(self.camp)
    end
    if self.camp == bc.BattleCamp.Camp1 then
      self.boutNumber = self.boutNumber + 1
      self.actionNumber = 0
      self.battleEngine.effectMgr:CreateEffect({
        effectType = bc.BattleEffectType.BEBattleFlow,
        BattleFlowEventId = BattleLogicEvent.BFSaveSnapshot,
        BeforeDelay = 0
      })
    end
  end
  
  local finishCb = {
    func = function()
      self:AfterSnapshotBout(boutBeginDelay)
    end,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServer:AfterSnapshotBout(boutBeginDelay)
  if self.battleEngine:IsBattleFinish() then
    return
  end
  self.battleEngine:Info("AfterSnapshotBout boutNumber:%s actionNumber:%s", self.boutNumber, self.actionNumber)
  self.isExtraBout = false
  self.battleEngine.cardMgr:ClearCardShuffleTag()
  
  local function preFunc()
    local battleFlowEventIds
    if self.camp == bc.BattleCamp.Camp1 then
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
    else
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
        }
      }
    end
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
    func = function()
      self:ActionBout()
    end,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServer:GetIsExtraBout()
  return self.isExtraBout
end

function BattleBoutMgrServer:ExtraBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  self.isExtraBout = true
  self.battleEngine.cardMgr:ClearCardShuffleTag()
  local boutBeginDelay = 0
  local battleFlowEventIds
  if self.camp == bc.BattleCamp.Camp1 then
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
  else
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
      }
    }
  end
  
  local function preFunc()
    for _, data in ipairs(battleFlowEventIds) do
      local effectType = bc.BattleEffectType.BEBattleFlow
      local effectConfig = {
        effectType = effectType,
        BattleFlowEventId = data[1],
        BeforeDelay = data[2],
        IsExtraBout = true
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

function BattleBoutMgrServer:ActionBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  local afterOrderFinishedCb, cbTarget
  local actionDelay = 0
  if self.camp == bc.BattleCamp.Camp2 then
    afterOrderFinishedCb = self.battleEngine.aiMgr.StartMonsterAI
    cbTarget = self.battleEngine.aiMgr
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
    func = function()
      if afterOrderFinishedCb and cbTarget then
        afterOrderFinishedCb(cbTarget)
      end
    end,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServer:EndBout()
  if self.battleEngine:IsBattleFinish() then
    return
  end
  self.boutEndTime = os.time()
  local enterExtraBout = self:CheckIsExtraBout()
  local effectTypeList
  if self.camp == bc.BattleCamp.Camp1 then
    effectTypeList = {
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
  else
    effectTypeList = {
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
      },
      {
        BattleLogicEvent.BFMonsterCalcIntention,
        0.5
      }
    }
  end
  
  local function preFunc()
    self.battleEngine.recordMgr:OnChangeExtraBout(enterExtraBout)
    local effectType = bc.BattleEffectType.BEBattleFlow
    for _, data in ipairs(effectTypeList) do
      local effectConfig = {
        effectType = effectType,
        BattleFlowEventId = data[1],
        BeforeDelay = data[2],
        IsExtraBout = self.isExtraBout
      }
      self.battleEngine.effectMgr:CreateEffect(effectConfig)
    end
  end
  
  local finishCb = {
    func = enterExtraBout and self.ExtraBout or self.BeginBout,
    target = self,
    data = {}
  }
  self.battleEngine:RunEffectOrder(preFunc, finishCb)
end

function BattleBoutMgrServer:CanHandleMsg(msgData)
  return true
end

function BattleBoutMgrServer:CanPlayerEndBout(msgData)
  if self:GetBoutNum() ~= msgData.boutNumber then
    self.battleEngine:Warn("ERROR：回合数不匹配！", self:GetBoutNum(), msgData.boutNumber)
    return false
  end
  if self.camp ~= bc.BattleCamp.Camp1 then
    self.battleEngine:Warn("ERROR：不是玩家回合！", self.camp)
    return false
  end
  if self.phase ~= bc.BoutPhase.Action then
    self.battleEngine:Warn("ERROR：不在回合行动阶段!", self.phase)
    return false
  end
  local now = os.time()
  if now - (self.boutEndTime or 0) < 1 then
    self.battleEngine:Warn("ERROR：回合结束过快!", msgData.boutNumber)
    return false
  end
  return true
end

function BattleBoutMgrServer:CheckIsExtraBout()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player.schoolCompPVE:IsSchoolID(bc.SchoolID.DIMENSION) then
    return false
  end
  local dimensionCardMax = player:GetProperty(BP.dimension_slot)
  local dimensionCardNum = #self.battleEngine.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
  if dimensionCardMax > dimensionCardNum or dimensionCardMax <= 0 then
    self.battleEngine:Warn("ERROR：超维卡牌未满，却尝试额外回合！", dimensionCardNum, dimensionCardMax)
    return false
  end
  return true
end

function BattleBoutMgrServer:CanPlayerExtraBout(msgData)
  if self:GetBoutNum() ~= msgData.boutNumber then
    self.battleEngine:Error("ERROR：回合数不匹配！", self:GetBoutNum(), msgData.boutNumber)
    return false
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if not player.schoolCompPVE:IsSchoolID(bc.SchoolID.DIMENSION) then
    return false
  end
  local dimensionCardMax = player:GetProperty(BP.dimension_slot)
  local dimensionCardNum = #self.battleEngine.cardMgr:GetCardListByDeck(bc.CardDeck.DimensionDeck)
  if dimensionCardMax > dimensionCardNum then
    self.battleEngine:Warn("ERROR：超维卡牌未满，却尝试额外回合！", dimensionCardNum, dimensionCardMax)
    return false
  end
  do return self.CanPlayerEndBout, self end
  return self.CanPlayerEndBout, self, msgData, dimensionCardNum, dimensionCardMax
end

function BattleBoutMgrServer:Serialize()
  return {
    camp = self.camp,
    boutNumber = self.boutNumber,
    isExtraBout = self.isExtraBout,
    phase = self.phase
  }
end

function BattleBoutMgrServer:OnSnapShot()
  return {
    camp = self.camp,
    boutNumber = self.boutNumber,
    isExtraBout = self.isExtraBout,
    phase = self.phase,
    actionNumber = self.actionNumber or 0,
    boutEndTime = self.boutEndTime or 0
  }
end

function BattleBoutMgrServer:OnRecover(boutData)
  self.camp = boutData.camp
  self.boutNumber = boutData.boutNumber
  self.isExtraBout = boutData.isExtraBout
  self.phase = boutData.phase
  self.actionNumber = boutData.actionNumber or 0
  self.boutEndTime = boutData.boutEndTime or 0
end

function BattleBoutMgrServer:ChangeBoutPhase(newPhase, config)
  self.battleEngine.recordMgr:OnChangeBoutPhase(self.phase, newPhase, config)
  self.phase = newPhase
end

function BattleBoutMgrServer:GetCurCamp()
  return self.camp
end

function BattleBoutMgrServer:GetBoutNum()
  return self.boutNumber
end

function BattleBoutMgrServer:GetCurCampName()
  if self.camp == bc.BattleCamp.Camp1 then
    return "玩家"
  else
    return "怪物"
  end
end

function BattleBoutMgrServer:IncreaseActionIndex()
  self.actionNumber = (self.actionNumber or 0) + 1
end

function BattleBoutMgrServer:GetCurActionIndex()
  return self.actionNumber or 0
end

return BattleBoutMgrServer
