-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/normal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "Normal Enter")
  if controller._responseMouseClick then
    (DialogManager.DestroySingletonDialog)("guide.blockclickdefaultdialog")
  end
  if lastState == "FunctionUnlock" then
    (controller._baseMainFSM):SetBoolean("mainFSMEnd", true)
    controller._responseMouseClick = true
    if not ((NekoData.BehaviorManager).BM_Guide):CanPlayGuide(40) and not ((NekoData.BehaviorManager).BM_Guide):CanPlayGuide(41) and not ((NekoData.BehaviorManager).BM_Guide):CanPlayGuide(42) then
      (DialogManager.DestroySingletonDialog)("guide.blockclickdefaultdialog")
    end
    ;
    ((NekoData.DataManager).DM_Game):ClearTip()
    local sign = ((NekoData.BehaviorManager).BM_Game):GetFastMenuSignFromCourtyard()
    if sign then
      ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard(nil, ((NekoData.BehaviorManager).BM_Game):GetFastMenuInfoFromCourtyard())
      if not ((NekoData.BehaviorManager).BM_Guide):HasCurrentGuide() then
        if sign == "CharacterList" then
          controller:SetCameraAnimatorState(9)
        else
          if sign == "WorkShop" then
            controller:SetCameraAnimatorState(8)
          else
            if sign == "Team" then
              local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teampresetmaindialog")
              dialog:Init(controller)
            else
              do
                if sign == "Dungeon" then
                  controller:SetCameraAnimatorState(1)
                else
                  if sign == "Gacha" then
                    controller:SetCameraAnimatorState(2)
                  else
                    if sign == "Task" then
                      controller:SetCameraAnimatorState(3)
                    else
                      if sign == "Shop" then
                        local dialog = (DialogManager.GetDialog)("base.basemainui")
                        dialog:OnShopClick()
                      else
                        do
                          if sign == "HandBook" then
                            local dialog = (DialogManager.GetDialog)("base.basemainmenudialog")
                            dialog:OnHandBookClicked()
                          else
                            do
                              do
                                if sign == "Guild" then
                                  controller:SetCameraAnimatorState(5)
                                end
                                if lastState == "Init" then
                                  (controller._baseMainFSM):SetBoolean("toNormal", false)
                                end
                                ;
                                (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, State, nil)
                                if ((NekoData.BehaviorManager).BM_Guide):HasCurrentGuide() then
                                  (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", true)
                                else
                                  if lastState == "FunctionUnlock" or lastState == "OpenPreMainCityBattleDialog" then
                                    local shouldOpenDeeplinkUI = ((NekoData.BehaviorManager).BM_Game):GetOpenDeepLinkActivityTag()
                                    if shouldOpenDeeplinkUI then
                                      ((NekoData.BehaviorManager).BM_Game):ClearOpenDeepLinkActivityTag()
                                      ;
                                      (DialogManager.CreateSingletonDialog)("activity.activitydeeplinkdialog")
                                    end
                                  end
                                end
                                do
                                  ;
                                  (LuaNotificationCenter.AddObserver)(State, State.OnOpenDeeplinkActivity, Common.n_OpenDeeplinkActivity, nil)
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  if controller._responseMouseClick and nextState ~= "OpenPreMainCityBattleDialog" then
    ((NekoData.DataManager).DM_Game):ClearLastDungeonType()
    ;
    ((NekoData.DataManager).DM_Game):ClearLastAutoDungeonType()
  end
  LogInfo("BaseMainFSM", "Normal Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnOpenDeeplinkActivity = function(observer, noitification)
  -- function num : 0_3 , upvalues : _ENV
  local GameFsmInMaincity = GlobalGameFSM:GetCurrentState() == "MainCity"
  if GameFsmInMaincity then
    ((NekoData.BehaviorManager).BM_Game):ClearOpenDeepLinkActivityTag()
    ;
    (DialogManager.CreateSingletonDialog)("activity.activitydeeplinkdialog")
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return State

