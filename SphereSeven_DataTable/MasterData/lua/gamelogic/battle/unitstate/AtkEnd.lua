local state = BaseState:New(UnitBattleState.AtkEnd)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActUnit == nil then
          Logger.LogError("ActEnd:state.battleComp.CurActUnit == nil")
          return 
     end
     local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
     actUnit.atkEnd = true
     
     coroutine.start(function ()
          local zSkill = state.battleComp.CurActSkill.ZSkill
          local atkEndDelay = zSkill.AtkEndDelay

          -- ��������ʱ����ʱ�������Ͻ���
          if atkEndDelay > 0 then
               coroutine.waitforseconds(atkEndDelay) 
          end

          -- ����������ؿ�ʩ����
          if zSkill.AtkEndLookSpeller ~= nil and zSkill.AtkEndLookSpeller > 0 then
               local type = actUnit.__entity.IsPlayer and CameraType.Right or CameraType.Left
               actUnit.battle_camera_component:SwitchCameraByPos(type, actUnit.__entity:GetPosition())
               actUnit.battle_component:RangeView(actUnit.__entity.IsPlayer)
               coroutine.waitforseconds(zSkill.AtkEndLookSpeller) 
          end

          -- ���Ѽ��ܽ�����ʾUI
          if zSkill.IsAwaken == 1 then
               actUnit.battle_ui_component:ShowBattleUIOnAwaken()
               actUnit.battle_camera_component:SwitchCameraByPos(CameraType.Center)
          end
          
          -- Զ�����ص��˵�ʱ�������Ҫ��ʱ�л����⴩��
          if not actUnit.IsCamCon then
               if zSkill.IsAwaken == 1 then
                    actUnit.battle_component:AwakeView(state.battleComp.CurActSkill.TargetUnits, state.battleComp.CurActSkill.SrcUnit)
               elseif zSkill.Distance == AtkDistance.Range then
                    if zSkill.HideEm == 1 then
                         actUnit.battle_camera_component:SwitchCameraByPos(CameraType.Center)
                         actUnit.battle_component:DeRangeView()
                    end
               end
          end
          
          if not actUnit.IsCac and 
                  actUnit:CurActIsSkill(ActiveSkillType.GeneralAtk) and 
                  table.sum(state.battleComp.CurActSkill.Completes) > 0 then
          end
          table.walk(state.battleComp.CurActSkill.TargetUnits,function (k,v)
               local activeSkillResult = state.battleComp.CurActSkill.UnitResults[v.UID]
               v:GetComponent("SsUnitBattleComponent"):AfterAllHurt(state.battleComp.CurActUnit, activeSkillResult)
               v:GetComponent("SsUnitBattleComponent"):AfterBeHitAll(state.battleComp.CurActUnit, activeSkillResult)
               state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent"):AfterOneTargetAllHit(v, activeSkillResult)

               if v:GetComponent("NumericComponent"):Get(NumericType.Hp) ~= 0 then
                    v:GetComponent("SsUnitAnimatorComponent").keepHit = false
                    v:GetComponent("SsUnitAnimatorComponent"):OnHit()
               end
          end)

          for UID, result in pairs(state.battleComp.CurActSkill.UnitResults) do
               if result.ActChange ~= 0 then
                    local unit = state.battleComp.IdUnits[UID]
                    unit:GetComponent("BattleUnitComponent"):ChangeActValue(result.ActChange)
               end
          end

          state.battleComp:OnAtkEnd()
          if not state.battleComp.CurActSkill.DoNotCd then
               state.battleComp.CurActSkill.LeftCooldownTurn = state.battleComp.CurActSkill:GetCooldownTurn()
          else
               state.battleComp.CurActSkill.LeftCooldownTurn = 0
          end
          state.battleComp.CurActSkill.DoNotCd = false
          state.battleComp.CurActSkill.Completes = {} --���õ�ǰ�ж������table
          state.battleComp.CurActSkill.ExpectCompleteNum = 0 --���õ�ǰ�ж����������
          
          if not actUnit.IsCac and state.battleComp.CurActSkill.LeftComboNum > 0 then --and zSkill.MoveType ~= 1 and  zSkill.MoveType ~= 2 then --����  ���ܶ�===��ι���
               actUnit.battle_component.CurActType = ActType.Continue
               actUnit.fsm:Switch(UnitBattleState.AtkStart)
               return
          end

          -- ȡ������
          if not actUnit.IsCamCon then
               actUnit.battle_camera_component:DeRightAwakeSet()
               actUnit.battle_camera_component:DeLeftAwakeSet()
               actUnit.battle_component:DeRangeView()
               actUnit.battle_component:TargetsShow()
          end

          -- 临时处理
          if state.battleComp.CurActUnit:GetComponent("SsUnitAnimatorComponent").animation_clips[SsUnitMotionType.FnJmp] ~= nil then
          -- if zSkill.Distance == AtkDistance.Close and zSkill.IsAwaken ~= 1 and (zSkill.MoveType == 9 or zSkill.MoveType == 0 or zSkill.MoveType == 1) then --����
          if zSkill.IsAwaken ~= 1 and (zSkill.MoveType == 9 or zSkill.MoveType == 0 or zSkill.MoveType == 1) then --����
               coroutine.waitforseconds(0.1)
               actUnit.cur_act_move_time = actUnit.unit_move_component:CalcMoveToDestTime(actUnit.unit_matrix_component.GameObject.transform.position,actUnit.cur_act_move_speed) --��ȡ�ƶ�ʱ��
               if actUnit.cur_act_move_time >= 0.01 then
                    actUnit.unit_animator_component:PlayInTime(SsUnitMotionType.BkJmp, actUnit.downTime) --���ź�������
                    actUnit.unit_move_component:MoveToDest(actUnit.unit_matrix_component.GameObject.transform.position,actUnit.cur_act_move_speed) --�ƶ���λ
                    DOTween.Sequence()
                           :Append(actUnit.__entity.GameObject.transform:DOMoveY(actUnit.jumpHigh, actUnit.cur_act_move_time/2):SetEase(Ease.OutQuad))
                           :Append(actUnit.__entity.GameObject.transform:DOMoveY(0, actUnit.cur_act_move_time/2):SetEase(Ease.InQuad))
                    coroutine.waitforseconds(actUnit.cur_act_move_time)
                    if zSkill.MoveType ~=9 and zSkill.MoveType ~=2 and zSkill.MoveType ~=3then
                         --���в����
                         actUnit.unit_animator_component:PlayInTime(SsUnitMotionType.BkJmpDown, actUnit.downTime) --���ź�����ض���
                         coroutine.waitforseconds(actUnit.downTime)
                    end
                    actUnit.unit_animator_component:Play(SsUnitMotionType.Idle) --����վ������
                    coroutine.waitforseconds(0.2)
               else
                    Logger.LogError("actUnit.cur_act_move_time:"..actUnit.cur_act_move_time)
               end
          end
          end
          
          -- �ѻ��ŵĽ�ɫ�㼶����ԭ
          table.walk(state.battleComp.IdUnits, function (_, v) 
               local character_component = v:GetComponent("CharacterComponent")
               local unit_battle_component = v:GetComponent("SsUnitBattleComponent")
               if character_component:IsNotDeadAndNotHide() then
                    unit_battle_component:Awaken2SsUnitLayer(1)
               end
          end)

          if zSkill.IsMoveToTargetRow == 1 then
               actUnit.__entity:SetPosition(actUnit.old_pos)
          end

          actUnit.battle_component:DeAwakeView()
          actUnit.atktime = nil
          
          actUnit.fsm:Switch(UnitBattleState.ActEnd)
     end)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state