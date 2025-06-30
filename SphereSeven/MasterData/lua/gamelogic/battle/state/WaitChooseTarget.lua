local state = BaseState:New(BattleState.WaitChooseTarget)
function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     if state.battleComp.CurActSkill ~= nil then
          state.skill = state.battleComp.CurActSkill
     end

     if state.skill == nil then
          Logger.LogError("WaitChooseTarget:error")
     end

     local zSkill = state.skill.ZSkill

     local us = state.battleComp.IdUnits
     table.walk(us,function (_, u)
          local ub = u:GetComponent("SsUnitBattleComponent")
          local isValid = state.battleComp:CheckCurrentSkillToUnit(u, zSkill)
          if isValid or u == state.skill.SrcUnit then
               -- ub:HighlightScopeOn()
               u:ResetDim()
          else
               -- ub:HighlightScopeOff()
               u:SetDim()
          end
     end)
     --新手引导点击技能后10秒没有动作弹出提示
     state.enter=true
     local GuideComplete, GuideStep ,run = state.battleComp.GuideComponent:GetCurrentData()
     if state.battleComp.CurActUnit.IsPlayer and  GuideComplete==0 and run then
          state.timeUpdate=function()
               if UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide).View.Finger_rc.gameObject.activeSelf then
                    return
               end
               if state.enter and state.six==nil then
                    if zSkill.IsTargetEnemy == 0 then --技能目标是友方
                         local u = table.first(us,function(v) return v.IsPlayer==true and not v:GetComponent("CharacterComponent").IsDead and state.battleComp:CheckCurrentSkillToUnit(v, zSkill) end)
                         if  u ~= nil then
                              --local pos = u.transform.position
                              state.six= UIUtil.ToolTipSix(u.GameObject.transform.position)
                              state.timer:Stop()
                         end
                    elseif  zSkill.IsTargetEnemy == 1 then
                         local u = table.first(us,function(v) return v.IsPlayer==false and not v:GetComponent("CharacterComponent").IsDead and state.battleComp:CheckCurrentSkillToUnit(v, zSkill)  end)
                         if  u ~= nil then
                              local d=u.GameObject.transform.position
                              state.six=UIUtil.ToolTipSix(u.GameObject.transform.position)
                              state.timer:Stop()
                         end
                    end
               end
          end
          state.timer = TimerManager:GetInstance():GetTimer(10, state.timeUpdate , state)
          -- 启动定时器
          state.timer:Start()
     end
end
function IsPointerOverUIObject()
      if IsNull(EventSystem.current) then
          return false
      end
      local eventDataCurrentPosition = PointerEventData(EventSystem.current)
      eventDataCurrentPosition.position = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
      local results=CS.XLuaHelper.CreateListInstance(typeof(RaycastResult))
      EventSystem.current:RaycastAll(eventDataCurrentPosition,results)
      return results.Count > 0
end
function state:OnUpdate()
     xpcall(function ()          
          if state.battleComp.AutoBattleValue ~= 0 then --自动战斗
               state.battleComp:AutoAI() --执行自动战斗
               return
          end
          if IsPointerOverUIObject() then
               return
          end
          local centerFarCamera = state.battleComp.__entity:GetComponent("BattleCameraComponent"):GetCamera(CameraType.Center) --切换为中间摄像机
          local ray = centerFarCamera:ScreenPointToRay(Input.mousePosition) -- 使用U3D射线
          local hits = CS.UnityEngine.Physics.RaycastAll(ray, 100, LayerMask.GetMask("SsUnit")) --获取被射线穿过的单位
          if hits.Length > 0 then
               local colliderUnitId = hits[0].collider:GetComponent(typeof(CS.SsUnitEventReceiver)).SsUnitId -- 获取选中单位的ID
               local colliderUnit = state.battleComp.IdUnits[colliderUnitId]  --获取选中单位
               local colliderUnitGroup = colliderUnit:GetComponent("SsUnitMatrixComponent").Group --选中单位的阵营
               local zSkill = state.skill.ZSkill
               if zSkill ~= nil then -- 行动类型为技能 或着选择了信念技能
                    local isValid = state.battleComp:CheckCurrentSkillToUnit(colliderUnit, zSkill)
                    if isValid then
                         if Input.GetMouseButtonUp(0) then --抬起鼠标或者有效为真
                              --if state.battleComp.GuideComponent.GuideRun then
                              --return --引导时点了白点
                              --end
                              state.battleComp:DoSkill(colliderUnit)
                         else
                              if state.battleComp.cur_selected_unit_id ~= colliderUnitId then
                                   table.walk(state.battleComp.IdUnits,function (k,v) -- 重置标记
                                        v:GetComponent("SsUnitBattleComponent"):HighlightSelectedOff()
                                   end)
                                   if zSkill.IsTargetEnemy == 1 then --目标为敌方单位
                                        if zSkill.EnemyRange == EnemyRange.Row then --技能范围为整排
                                             local targetRow = colliderUnit:GetComponent("SsUnitMatrixComponent").Row --获取被选单位的排数
                                             table.walk(table.choose( state.battleComp.IdUnits,function (k,v) --遍历所有在被选单位阵营且排数相等并且未死亡未隐藏的单位
                                                  return v:GetComponent("SsUnitMatrixComponent").Group == colliderUnitGroup and v:GetComponent("SsUnitMatrixComponent").Row == targetRow and
                                                          v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
                                             end),function(k,v)
                                                  v:GetComponent("SsUnitBattleComponent"):HighlightSelectedOn() --打开标记
                                             end)
                                        elseif zSkill.EnemyRange == EnemyRange.Line then -- 技能范围为整列
                                             local targetLine = colliderUnit:GetComponent("SsUnitMatrixComponent").Line
                                             table.walk(table.choose( state.battleComp.IdUnits,function (k,v) --同上
                                                  return v:GetComponent("SsUnitMatrixComponent").Group == colliderUnitGroup and v:GetComponent("SsUnitMatrixComponent").Line == targetLine and
                                                          v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
                                             end),function(k,v)
                                                  v:GetComponent("SsUnitBattleComponent"):HighlightSelectedOn()
                                             end)
                                        elseif zSkill.EnemyRange == EnemyRange.Single then
                                             colliderUnit:GetComponent("SsUnitBattleComponent"):HighlightSelectedOn()
                                        elseif zSkill.EnemyRange == EnemyRange.All then
                                             table.walk(state.battleComp.IdUnits,function (k,v) -- 重置标记
                                                  if v:GetComponent("SsUnitMatrixComponent").Group == colliderUnitGroup 
                                                       and v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide() then
                                                       v:GetComponent("SsUnitBattleComponent"):HighlightSelectedOn()
                                                  end
                                             end)
                                        end
                                   end
                                   state.battleComp.cur_selected_unit_id = colliderUnitId --设置被选单位ID
                              end
                         end
                    end
               end
          else
               if state.battleComp.cur_selected_unit_id ~= nil and state.battleComp.cur_selected_unit_id ~= 0 then
                    table.walk(state.battleComp.IdUnits,function (k,v) -- 重置标记
                         v:GetComponent("SsUnitBattleComponent"):HighlightSelectedOff()
                    end)
                    state.battleComp.cur_selected_unit_id = 0
               end
          end
     end, function (msg) 
          Logger.LogError(msg)
     end)
end

function state:OnLeave()
     local us= state.battleComp.IdUnits
     table.walk(us,function (_,u)
         local ub=u:GetComponent("SsUnitBattleComponent")
     --     ub:HighlightScopeOff()
           u:ResetDim()
     end)
     state.enter=false
     if state.timer~=nil then
          state.timer:Stop()
     end
     if state.six~=nil then
          state.six:MoveEndCallBack()
          state.six=nil
     end
     
end
return  state