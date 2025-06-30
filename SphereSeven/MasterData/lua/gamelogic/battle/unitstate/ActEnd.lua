local state = BaseState:New(UnitBattleState.ActEnd)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActUnit == nil then 
          Logger.LogError("ActEnd:state.battleComp.CurActUnit == nil")
          return 
     end
     coroutine.start(function ()
          local zSkill = state.battleComp.CurActSkill.ZSkill --获取技能配置
          local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")

          -- 跳过恢复处理 --
          local pp = UIManager:GetInstance():GetWindow(UIWindowNames.UISkillSkip)
          if pp ~= nil then 
               pp.View:ShutDown()
          end
          local skip = state.battleComp.BattleSkip
          actUnit.battle_component:ReSetBattleSkip()
          Game.Scene:GetComponent("PlayerBattleComponent"):Show()
          if skip then 
               coroutine.waitforseconds(0.3) -- 等待skip界面关闭   然后显示伤害   没其他用
          else
               table.walk(state.battleComp.IdUnits,function (k,v)
                    v:GetComponent("SsUnitBattleComponent").hudList = {} -- 不需要显示伤害
               end)
          end 
          
          -- 先触发技能再触发OnActEnd --
          if zSkill.IsAwaken == 1 then
               state.battleComp:OnUseAwaken()
          end
          state.battleComp:OnActEnd()
          state.battleComp:OnActEndEvent(state.battleComp.CurActUnit)

          -- 反击结束  （普攻/技能，反击，连击，被动攻击）
          if actUnit.IsCac then
               state.battleComp.CurActUnit:GetComponent("CharacterComponent").CacLimitCur = state.battleComp.CurActUnit:GetComponent("CharacterComponent").CacLimitCur - 1
          end

          if state.battleComp.CurActType ~= ActType.UnitTurn then
               actUnit:ClearExtraMove()
          end

          -- 等待攻击彻底结束
          coroutine.waitforseconds(0.3)
          state.battleComp.CurActSkill.UnitResults = {}
          state.battleComp.fsm:Switch(BattleState.UnitActEnd)
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state