local state = BaseState:New(UnitBattleState.ForwardMoveStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActUnit == nil then return end
     local actUnit = state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent")
     local zSkill = state.battleComp.CurActSkill.ZSkill
     local curActForwardDestPos = Vector3.zero --ǰ��Ŀ��λ��
     local ctu = actUnit.battle_component.CurTargetUnit --Ŀ�굥λ
     
     local xOffset = 0
     local zOffset = 0
     xOffset = xOffset + actUnit.__entity.CloseAtkOffset.x
     zOffset = zOffset + actUnit.__entity.CloseAtkOffset.z
     if ctu ~= nil then
          xOffset = xOffset + ctu.ZSsUnit.HitPosOffset[1]
          zOffset = zOffset + ctu.ZSsUnit.HitPosOffset[3]
     end

     -- ������Ϊ���壬ֱ�ӻ�ȡ��λ��λ��
     if actUnit.IsCac or zSkill.EnemyRange == EnemyRange.Single then 
          curActForwardDestPos.x = ctu:GetPosition().x
          curActForwardDestPos.z = ctu:GetPosition().z
     -- ����Ϊȫ��������x�ɵз���ǰ�ž��� z�����д��ĵ��˾���
     elseif zSkill.EnemyRange == EnemyRange.All or zSkill.EnemyRange == EnemyRange.Random then 
          local frontRowUnits = actUnit.battle_component:GetEnemyFrontRow(actUnit.__entity:GetComponent("SsUnitMatrixComponent").Group)
          local us = table.values(frontRowUnits)
          local pos = Vector3.New(0, 0, 0)
          for _, v in pairs(us) do
               pos = pos + v.Pos
          end
          curActForwardDestPos.x = (pos / #us).x
          
          local tb = table.choose(actUnit.battle_component.IdUnits,function (k,v)
               return not actUnit:IsSameGroup(v) and v:GetComponent("CharacterComponent"):IsNotDead()
          end)
          us = table.values(tb)
          pos = Vector3.New(0, 0, 0)
          for _, v in pairs(us) do
               pos = pos + v.Pos
          end
          curActForwardDestPos.z = (pos / #us).z
     -- ����Ϊ����
     elseif zSkill.EnemyRange == EnemyRange.Line then 
          xOffset = 0
          local line = ctu:GetComponent("SsUnitMatrixComponent").Line
          if actUnit.__entity.IsPlayer then
               curActForwardDestPos = actUnit.matrix_component.LMLineIdGameObjects[line].transform.position
          else
               curActForwardDestPos = actUnit.matrix_component.RMLineIdGameObjects[line].transform.position
          end
     -- ����Ϊ���� ����ǰ�ŵ����е��˾���λ��
     elseif zSkill.EnemyRange == EnemyRange.Row then 
          local frontRowUnits = actUnit.battle_component:GetEnemyFrontRow(actUnit.__entity:GetComponent("SsUnitMatrixComponent").Group)
          local us = table.values(frontRowUnits)
          local pos = Vector3.New(0, 0, 0)
          for _, v in pairs(us) do
               pos = pos + v.Pos
          end
          local targetPos = pos / #us
          curActForwardDestPos.x = targetPos.x
          curActForwardDestPos.z = targetPos.z
     end

     xOffset = actUnit.__entity.IsPlayer and xOffset or -xOffset
     curActForwardDestPos.x = curActForwardDestPos.x + xOffset
     curActForwardDestPos.z = curActForwardDestPos.z + zOffset
     actUnit.cur_act_forward_dest_pos = curActForwardDestPos
     --���кͷǷ��У�����û����ض���
     actUnit.cur_act_move_speed = zSkill.MoveType ~= 9 and actUnit.moveSpeed or actUnit.flySpeed
     -- ��ȡ�ƶ�ʱ��
     actUnit.cur_act_move_time = actUnit.unit_move_component:CalcMoveToDestTime(curActForwardDestPos,actUnit.cur_act_move_speed)
     -- ������Ϊ������ʼ  ��ǰ��  ֱ�ӿ�ʼ����
     if zSkill.IsAwaken == 1 or zSkill.MoveType == 1 or zSkill.MoveType == 2 then
          actUnit.fsm:Switch(UnitBattleState.AtkStart)
          return
     end
     -- ��ս�ƶ������������
     -- actUnit.battle_camera_component:SwitchCameraByTnf(actUnit.__entity.IsPlayer and CameraType.Right or CameraType.Left, actUnit.__entity.GameObject.transform)
     -- ������Ч
     actUnit.unit_animator_component:PlayInTime(SsUnitMotionType.FnJmp, actUnit.downTime) --����ǰ������
     actUnit.unit_move_component:MoveToDest(curActForwardDestPos, actUnit.cur_act_move_speed) --�ƶ���λ
     DOTween.Sequence()
            :Append(actUnit.__entity.GameObject.transform:DOMoveY(actUnit.jumpHigh, actUnit.cur_act_move_time / 2):SetEase(Ease.OutQuad))
            :Append(actUnit.__entity.GameObject.transform:DOMoveY(0, actUnit.cur_act_move_time / 2):SetEase(Ease.InQuad))
     coroutine.start(function ()
          coroutine.waitforseconds(actUnit.cur_act_move_time)
          -- ���в���� �����
          if zSkill.MoveType ~= 9 then
               actUnit.unit_animator_component:PlayInTime(SsUnitMotionType.FnJmpDown, actUnit.downTime) 
               coroutine.waitforseconds(actUnit.downTime)
          end
          actUnit.fsm:Switch(UnitBattleState.AtkStart)
     end)
end

function  state:OnUpdate()

end

function   state:OnLeave()

end
return  state