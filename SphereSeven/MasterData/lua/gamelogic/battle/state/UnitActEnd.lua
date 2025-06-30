local state = BaseState:New(BattleState.UnitActEnd)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     coroutine.start(function ()
          -- 死亡特写
          state.battleComp:DeadClose(function(deadUnits)
               if state.battleComp.CurActUnit ~= nil then
                    state.battleComp.CurActUnit:GetComponent("SkillComponent"):OnKillEnemy(deadUnits)
               else
                    if state.battleComp.CurAtkGroup == nil then
                         Logger.LogError("BattleState.UnitActEnd:state.battleComp.CurActUnit")
                    end
               end
          end)

          -- 在退出之前把行动重置
          if state.battleComp.UnitActing then
               state.battleComp.UnitActing = false
          end
 
          -- 战斗结束就退出
          if state.battleComp:BattleEnd() then
               return
          end

          -- 行动单位有反击对象，但是没有正常执行反击
          if state.battleComp.CurActUnit ~= nil then
               local sbc = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
               sbc.IsCac = false
               sbc.CacUnit = nil
          end

          -- 如果敌方全部死亡
          if state.battleComp:IsMonsterAllDead() then
               state.battleComp.fsm:Switch(BattleState.UnitTurnEnd)
               return
          end

          table.walk(state.battleComp.IdUnits, function (k, v)
               local ssUnitBattleComponent = v:GetComponent("SsUnitBattleComponent")
               if ssUnitBattleComponent.ExtraSkill ~= nil then
                    if state.battleComp.CurActType ~= ActType.UnitTurn and ssUnitBattleComponent.IgnoreExtraSkillActTypeLimit ~= true then
                         if state.battleComp.CurActUnit == v then
                              ssUnitBattleComponent:ClearExtraSkill()
                         end
                         return
                    end
                    if v ~= nil and not v:GetComponent("CharacterComponent").IsDead then
                         state.battleComp.ExtraSkillQueue:enqueue(v)
                    end
               end

               ssUnitBattleComponent.IgnoreExtraSkillActTypeLimit = false
          end)

          -- ljy: 反击队列入列移到这里以判断是否单位回合已经完全结束
          if state.battleComp.CurActType == ActType.UnitTurn then
               table.walk(state.battleComp.IdUnits, function (k, v)
                    local ssUnitBattleComponent = v:GetComponent("SsUnitBattleComponent")
                    if ssUnitBattleComponent.CacUnit ~= nil then
                         if v ~= nil and not v:GetComponent("CharacterComponent").IsDead then
                              state.battleComp.CacQueue:enqueue(v)
                         end
                    end
               end)
          else
               local sbc = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
               sbc.IsCac = false
               sbc.CacUnit = nil
               -- sbc:ClearExtraMove()
          end

          if state.battleComp:IsUnitTurnEnd() then
               state.battleComp.fsm:Switch(BattleState.UnitTurnEnd)
          else
               state.battleComp.fsm:Switch(BattleState.QueueAct)
          end
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state