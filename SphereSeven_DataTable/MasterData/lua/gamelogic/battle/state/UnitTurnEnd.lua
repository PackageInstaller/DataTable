local state = BaseState:New(BattleState.UnitTurnEnd)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     coroutine.start(function()
          state.battleComp:OnUnitTurnEnd(state.battleComp.CurTurnUnit)

          -- 清空行动过后的单位和技能
          state.battleComp:ClearCurActUnit()

          -- 如果敌方全部死亡
          if state.battleComp:IsMonsterAllDead() then
               state.battleComp.fsm:Switch(BattleState.RoundEnd)
               return
          end

          state.battleComp.fsm:Switch(BattleState.QueueAct)
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state