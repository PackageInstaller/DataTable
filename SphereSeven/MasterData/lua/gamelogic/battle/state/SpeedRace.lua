local state = BaseState:New(BattleState.SpeedRace)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
end

-- 前面行动队列实在没人了，才会竞速
-- 只有竞速才会增加单位行动次数，但是单位行动不能超过当前回合数，死亡单位的回合数得同步
function state:OnUpdate()
     -- 竞速
     xpcall(function ()
          local liveUnits = table.filter(state.battleComp.IdUnits, function (k, v) return v:GetComponent("CharacterComponent").IsDead end)
          table.walksort(liveUnits, 
               function(lkey, rkey) 
                    return liveUnits[lkey]:GetComponent("BattleUnitComponent").ActValue > liveUnits[rkey]:GetComponent("BattleUnitComponent").ActValue 
               end,
               function (_, unit)
                    local battleUnitComponent = unit:GetComponent("BattleUnitComponent")
                    battleUnitComponent:Race(function()
                         state.battleComp.LowReadyQueue:enqueue(unit)
                    end)
               end)

          -- 竞速完毕
          if state.battleComp.LowReadyQueue:size() > 0 then
               state.battleComp.fsm:Switch(BattleState.QueueAct)
               return
          end

          state.battleComp.time = state.battleComp.time + Time.deltaTime
          if state.battleComp.time > BATTLE_TURN_DURATION then
               state.battleComp.fsm:Switch(BattleState.RoundEnd)
               state.battleComp.time = 0
          end

     end, function (msg) 
          Logger.LogError("SpeedRace: "..msg)
     end)
end

function state:OnLeave()
end

return state