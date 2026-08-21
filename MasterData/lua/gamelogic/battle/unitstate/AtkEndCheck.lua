local state = BaseState:New(UnitBattleState.AtkEndCheck)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
end

function state:OnUpdate()
     xpcall(function ()
          if state.battleComp.CurActUnit == nil then
               Logger.LogError("UnitBattleState.AtkEndCheck:state.battleComp.CurActUnit == nil")
               return
          end
          local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
          local skill = state.battleComp.CurActSkill
          
          if skill.ExpectCompleteNum == nil then
               Logger.Log("UnitBattleState.AtkEndCheck..error")
               return
          end

          if skill.ExpectCompleteNum > 0 and skill.ExpectCompleteNum <= #skill.Completes then
               if not actUnit.IsCamCon then
                    actUnit.fsm:Switch(UnitBattleState.AtkEnd)
               else
                    actUnit.IsCamEnd = true
               end
          elseif skill.ExpectCompleteNum == 0 and table.all(table.choose(state.battleComp.IdUnits,function (k,v)
               return not actUnit:IsSameGroup(v) and not v:GetComponent("CharacterComponent").IsDead end) ,function (v)
               return v:GetComponent("CharacterComponent").IsHide > 0 end) then
               actUnit.fsm:Switch(UnitBattleState.AtkEnd)
          elseif skill.ExpectCompleteNum == 0 then
               actUnit.fsm:Switch(UnitBattleState.AtkEnd)
          end
     end,function(msg)
          Logger.LogError("AtkEndCheck: "..msg)
     end)
end

function state:OnLeave()

end

return  state