local state = BaseState:New(BattleState.RoundStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     coroutine.start(function ()
          state.battleComp.RoundNum = state.battleComp.RoundNum + 1

          state.battleComp:OnRoundStart()
          
          -- 持续buff死亡
          state.battleComp:DeadClose()
          
          if state.battleComp:BattleEnd() then
               return
          end

          -- 如果敌方全部死亡
          if state.battleComp:IsMonsterAllDead() then
               state.battleComp.fsm:Switch(BattleState.BatchEnd)
               return
          end
          
          -- 回合开始重置回合反击限制
          table.walk(state.battleComp.IdUnits, function(k, v) 
               local cc = v:GetComponent("CharacterComponent")
               cc.CacLimitCur = cc.CacLimitMax
          end)
          state.battleComp.fsm:Switch(BattleState.QueueAct)
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state