local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BEBattleFlow, Super = System.NewClass("BEBattleFlow", BattleEffectServer)

function BEBattleFlow:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBattleFlow:Dispose()
  Super.Dispose(self)
end

local EventId2Phase = {
  [BattleLogicEvent.BFBeforeBoutBegin] = bc.BoutPhase.Begin,
  [BattleLogicEvent.BFBoutAction] = bc.BoutPhase.Action,
  [BattleLogicEvent.BFBoutEnd] = bc.BoutPhase.End
}
local FlowName = {
  [BattleLogicEvent.BFSaveSnapshot] = "================ %s 保存快照 当前回合 %s ==================",
  [BattleLogicEvent.BFBeforeBoutBegin] = "================ %s 回合开始前 当前回合 %s ================",
  [BattleLogicEvent.BFBoutBegin] = "================ %s 回合开始时 当前回合 %s ================",
  [BattleLogicEvent.BFBeforeDrawCards] = "==================== 抽牌阶段前 ==========================",
  [BattleLogicEvent.BFDrawCards] = "==================== 抽牌阶段时 ==========================",
  [BattleLogicEvent.BFAfterDrawCards] = "==================== 抽牌阶段后 ==========================",
  [BattleLogicEvent.BFAfterBoutBegin] = "================ %s 回合开始后 当前回合 %s ================",
  [BattleLogicEvent.BFBeforeDiscardCards] = "==================== 弃牌阶段前 ==========================",
  [BattleLogicEvent.BFDiscardCards] = "==================== 弃牌阶段时 ==========================",
  [BattleLogicEvent.BFAfterDiscardCards] = "==================== 弃牌阶段后 ==========================",
  [BattleLogicEvent.BFBeforeBoutEnd] = "================ %s 回合结束前 当前回合 %s ================",
  [BattleLogicEvent.BFBoutEnd] = "================ %s 回合结束时 当前回合 %s ================",
  [BattleLogicEvent.BFAfterBoutEnd] = "================ %s 回合结束后 当前回合 %s ================",
  [BattleLogicEvent.BFMonsterCalcIntention] = "====================== 怪物计算意图 ======================",
  [BattleLogicEvent.BFBattleEnd] = "======================== 战斗结束 ========================",
  [BattleLogicEvent.BFBoutAction] = "===================== %s 行动阶段开始 ====================="
}

function BEBattleFlow:DoEffect()
  Super.DoEffect(self)
  local boutMgr = self.battleEngine.boutMgr
  local phase = EventId2Phase[self.effectConfig.BattleFlowEventId]
  local boutNumber = boutMgr:GetBoutNum()
  if phase then
    boutMgr:ChangeBoutPhase(phase, {
      camp = boutMgr:GetCurCamp(),
      boutNumber = boutNumber
    })
  end
  if FlowName[self.effectConfig.BattleFlowEventId] then
    self.battleEngine:LogBattle(FlowName[self.effectConfig.BattleFlowEventId], boutMgr:GetCurCampName(), boutNumber)
  end
  self.battleEngine.eventMgr:SendEvent(self.effectConfig.BattleFlowEventId, self.effectConfig.IsExtraBout)
  return true
end

return BEBattleFlow
