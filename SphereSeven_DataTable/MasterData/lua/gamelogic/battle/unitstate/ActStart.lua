local state = BaseState:New(UnitBattleState.ActStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActUnit == nil then return end
     local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")

     coroutine.start(function ()
          state.battleComp:OnActStart()
          coroutine.waitforseconds(0.5)

          local zSkill = state.battleComp.CurActSkill.ZSkill

          -- 正常来说这种情况是不可能存在的
          if actUnit.character_component.UnableAct > 0 then
               coroutine.waitforseconds(1)
               actUnit.fsm:Switch(UnitBattleState.ActEnd)
               return 
          end
          
          -- 正常来说这种情况是不可能存在的
          if actUnit:CurActIsSkill(ActiveSkillType.GeneralAtk) and actUnit.character_component.UnableGeneraAtk > 0 then
               coroutine.waitforseconds(1)
               actUnit.fsm:Switch(UnitBattleState.ActEnd)
               return
          end

          -- 正常来说这种情况是不可能存在的
          if not actUnit:CurActIsSkill(ActiveSkillType.GeneralAtk) and actUnit.character_component.UnableSkill > 0 then 
               coroutine.waitforseconds(1)
               actUnit.fsm:Switch(UnitBattleState.ActEnd)
               return 
          end
          
          -- 正常来说这种情况是不可能存在的
          if zSkill.IsNeedChoose == 1 and state.battleComp.CurTargetUnit == nil then 
               coroutine.waitforseconds(1)
               actUnit.fsm:Switch(UnitBattleState.ActEnd)
               return
          end

          table.walk(state.battleComp.IdUnits,function (k,v)
               v:GetComponent("SsUnitBattleComponent").hudList = {} -- 清空伤害显示记录
          end)

          -- 技能为远程直接开始攻击， 技能为近程优先考虑近战移动（目前只有进程有前跳，远程忽略）
          -- if zSkill.Distance == AtkDistance.Range then
          --      actUnit.fsm:Switch(UnitBattleState.AtkStart)
          -- elseif zSkill.Distance == AtkDistance.Close then 
          --      actUnit.fsm:Switch(UnitBattleState.ForwardMoveStart)
          -- end

          -- 临时处理,有前跳动作才前跳
          if state.battleComp.CurActUnit:GetComponent("SsUnitAnimatorComponent").animation_clips[SsUnitMotionType.FnJmp] ~= nil then
               actUnit.fsm:Switch(UnitBattleState.ForwardMoveStart)
          else
               actUnit.fsm:Switch(UnitBattleState.AtkStart)
          end
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end
return  state