local state = BaseState:New(BattleState.WaitChooseSkill)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     state.enter=true
     local GuideComplete, GuideStep ,run = state.battleComp.GuideComponent:GetCurrentData()
     if GuideComplete==0 and run and  GuideStep>=16 then
          state.timeUpdateSK=function()
               if UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide).View.mask_bt.gameObject.activeSelf then
                    return
               end
               local battleUIComp=Game.Scene:GetComponent("BattleUIComponent")
               for i = 0, 2 do
                    if battleUIComp:ChooseSkill1(i) and state.sixSK==nil then
                         local parent = battleUIComp.skillRoot:Find("backGround"):GetChild(i)
                         local canvas = battleUIComp.BattleToolCanvas
                         local x,y,w,h = state.battleComp.GuideComponent:GetWorldToScreenRect(canvas,parent.transform)
                         local pos= Vector2.New(x,y)
                         state.sixSK=UIUtil.ToolTipSix(pos,1)
                         state.timerSK:Stop()
                         state.timerSK=nil
                         return
                    end 
               end

          end
          state.timerSK = TimerManager:GetInstance():GetTimer(10, state.timeUpdateSK , state)
          -- 启动定时器
          state.timerSK:Start()
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
          
          --新手引导
          local GuideComplete, GuideStep ,run = state.battleComp.GuideComponent:GetCurrentData()
          if state.battleComp.CurActUnit.IsPlayer and GuideStep==7 and  GuideComplete==0 and not state.battleComp.nex and run then
               state.battleComp.nex=true
               state.battleComp.GuideComponent:CurGuide(7)
          end
          --local GuideComplete, GuideStep ,run = state.battleComp.GuideComponent:GetCurrentData()
          if state.battleComp.CurActUnit.BattleCharacter.Id == 1003 and GuideStep >= 16 and  GuideComplete==0--刘协
                  and not state.battleComp.nex and run then
               local battleUIComp=Game.Scene:GetComponent("BattleUIComponent")
               if battleUIComp:ChooseSkill1(1) and table.indexof(state.battleComp.GuideComponent.GuideAppointStep,20) then
                    state.battleComp.nex=true
                    state.battleComp.GuideComponent:AppointGuide(20)
               end
          end
          if state.battleComp.CurActUnit.BattleCharacter.Id == 1027 and GuideStep >= 16 and  GuideComplete==0--扎尔
                  and not state.battleComp.nex and table.indexof(state.battleComp.GuideComponent.GuideAppointStep,21) and run then
               local battleUIComp=Game.Scene:GetComponent("BattleUIComponent")
               if battleUIComp:ChooseSkill1(0) then
                    state.battleComp.nex=true
                    state.battleComp.GuideComponent:AppointGuide(21)
               end
          end
          -- if state.battleComp.CurActUnit.BattleCharacter.Id == 4 and GuideStep >= 16 and  GuideComplete==0--选择的角色
          --         and not state.battleComp.nex and table.indexof(state.battleComp.GuideComponent.GuideAppointStep,22) and run then
          --      local battleUIComp=Game.Scene:GetComponent("BattleUIComponent")
          --      if battleUIComp:ChooseSkill1(3) then
          --           state.battleComp.nex=true
          --           state.battleComp.GuideComponent:AppointGuide(22)
          --      end
          -- end
          if state.battleComp.CurActUnit.BattleCharacter.Id == 1003 and GuideStep >= 16 and  GuideComplete==0--刘协 复活指引
                  and not state.battleComp.nex and table.indexof(state.battleComp.GuideComponent.GuideAppointStep,23) and run then
               local battleUIComp=Game.Scene:GetComponent("BattleUIComponent")
               local group = state.battleComp.CurActUnit:GetComponent("SsUnitMatrixComponent").Group
               local chooseUnits = table.choose(state.battleComp.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == group and v:GetComponent("CharacterComponent").IsDead end)
               if chooseUnits~=nil then
                    if battleUIComp:ChooseSkill1(2) and table.count(chooseUnits)>0 then
                         state.battleComp.nex=true
                         state.battleComp.GuideComponent:AppointGuide(23)
                    end
               end
          end
          if not table.indexof(state.battleComp.GuideComponent.GuideAppointStep,20)
               and not table.indexof(state.battleComp.GuideComponent.GuideAppointStep,21)
               and  GuideComplete==0--结束攻击引导 
               and GuideStep < 24
               and not state.battleComp.nex
               and run then
               state.battleComp.nex=true
               state.battleComp.GuideComponent:AppointGuide(24)
          end

          if IsPointerOverUIObject() then
               return
          end

          -- 这里检测角色是否点击
          local centerFarCamera = state.battleComp.__entity:GetComponent("BattleCameraComponent"):GetCamera(CameraType.Center) --切换为中间摄像机
          local ray = centerFarCamera:ScreenPointToRay(Input.mousePosition) -- 使用U3D射线
          local hits = CS.UnityEngine.Physics.RaycastAll(ray, 100, LayerMask.GetMask("SsUnit")) --获取被射线穿过的单位
          if hits.Length > 0 then
               local colliderUnitId = hits[0].collider:GetComponent(typeof(CS.SsUnitEventReceiver)).SsUnitId -- 获取选中单位的ID
               local colliderUnit = state.battleComp.IdUnits[colliderUnitId]  --获取选中单位
               local colliderUnitCharacter = colliderUnit:GetComponent("CharacterComponent") --数值组件
               if Input.GetMouseButtonDown(0) then --抬起鼠标或者有效为真
                    if not colliderUnitCharacter.IsDead then
                         state.battleComp.flash_unit = colliderUnit
                         state.battleComp.flash_unit:GetComponent("SsUnitBattleComponent"):HighlightSelectedOn()
                    end
               end
          end
          if Input.GetMouseButtonUp(0) then --抬起鼠标或者有效为真
               if state.battleComp.flash_unit~=nil then
                    state.battleComp.flash_unit:GetComponent("SsUnitBattleComponent"):HighlightSelectedOff()
                    state.battleComp.flash_unit=nil
               end
          end
     end, function (msg)
          Logger.LogError("WaitChooseSkill: "..msg)
     end)
end
function state:OnLeave()
     state.enter=false
     if state.timerSK~=nil then
          state.timerSK:Stop()
     end
     if state.sixSK~=nil then
          state.sixSK:MoveEndCallBack()
          --state.sixSK:SetActive(false)
          state.sixSK=nil
     end
end
return state