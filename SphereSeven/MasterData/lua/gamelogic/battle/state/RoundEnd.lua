local state = BaseState:New(BattleState.RoundEnd)

function state:OnInit()
     state.battleComp=Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     coroutine.start(function ()
          -- 死亡特写
          state.battleComp:DeadClose()
          -- 战斗结束就离开
          if state.battleComp:BattleEnd() then
               return
          end
          
          -- 战斗没有结束
          -- 先处理回合结束的逻辑
          state.battleComp:OnRoundEnd()
          -- 持续buff死亡特写
          state.battleComp:DeadClose()
          
          -- 如果敌方全部死亡
          if state.battleComp:IsMonsterAllDead() then
               state.battleComp.fsm:Switch(BattleState.BatchEnd)
               return
          end

          -- 继续战斗
          state.battleComp.fsm:Switch(BattleState.RoundStart)
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state