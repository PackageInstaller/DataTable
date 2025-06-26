local state = BaseState:New(BattleState.UnitTurnStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

-- 每次行动结束后，这里判断下是否还有行动，没有就回合结束
function state:OnEnter()
     coroutine.start(function()
          state.battleComp.OverallTurnNum = state.battleComp.OverallTurnNum + 1
          state.battleComp.battle_ui_component:SetRoundText(state.battleComp.OverallTurnNum)
          
          state.battleComp.CurTurnUnit = state.battleComp.CurActUnit
          state.battleComp.CurActType = ActType.UnitTurn
          state.battleComp:OnUnitTurnStart(state.battleComp.CurTurnUnit)

          local unit_battle_component = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
          local unit_ui_component = state.battleComp.CurActUnit:GetComponent("SsUnitUIComponent")
          local cam = state.battleComp.__entity:GetComponent("BattleCameraComponent")
          if cam == nil then return end

          if not state.battleComp:IsCurActUnitEnableAct() then
               state.battleComp.fsm:Switch(BattleState.UnitTurnEnd)
               return
          end

          unit_ui_component:OutGlowSrAvatar() --显示标记
          if state.battleComp.CurActUnit.IsPlayer then --玩家单位
               if state.battleComp.AutoBattleValue == 0 then --不是自动战斗
                    unit_battle_component:HighlightCurActOn() --单位模型标记打开
                    state.battleComp.battle_ui_component:LoadSkills(state.battleComp.CurActUnit) -- 显示技能按钮
                    state.battleComp.__entity:GetComponent("BattleCameraComponent"):SwitchCameraByPos(CameraType.Center)
                    state.battleComp.fsm:Switch(BattleState.WaitChooseSkill)
               else --自动战斗
                    state.battleComp:AutoAI()
               end
          else --非玩家
               if state.battleComp.is_opt_enemy_skill then --控制敌方技能
                    unit_battle_component:HighlightCurActOn()
                    state.battleComp.battle_ui_component:LoadSkills(state.battleComp.CurActUnit)
                    state.battleComp.__entity:GetComponent("BattleCameraComponent"):SwitchCameraByPos(CameraType.Center)
                    state.battleComp.fsm:Switch(BattleState.WaitChooseSkill)
               else --自动战斗
                    state.battleComp:AutoAI()
               end
          end
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state