local state = BaseState:New(BattleState.QueueAct)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

-- 每次行动结束后，这里判断下是否还有行动，没有就回合结束
function state:OnEnter()
     if state.battleComp.CacQueue:size() > 0 or --反击队列大于0 （受击后反击）
               state.battleComp.ExtraSkillQueue:size() > 0 or --技能队列大于0
               state.battleComp.SuoLifeQueue:size() > 0 or
             state.battleComp.AutoGAtkQueue:size() > 0 or --连击队列大于0（索命，霸者雄心被动，拿破仑战魂）
             state.battleComp.BattleArraySkillQueue:size() > 0 or --战阵技能队列
             state.battleComp.TempSaveQueue:size() > 0 or --
             state.battleComp.SuoLifeTempSaveQueue:size() > 0 or --
             state.battleComp.HighReadyQueue:size() > 0 or --高级优先队列（神行）
             #state.battleComp.MediumReadyList > 0 or --中级（强袭）
             state.battleComp.LowReadyQueue:size() > 0 --低级（竞速）
     then
          state.battleComp.fsm:Switch(BattleState.ReadyQueueHandle)
          return
     end

     state.battleComp.fsm:Switch(BattleState.SpeedRace)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state