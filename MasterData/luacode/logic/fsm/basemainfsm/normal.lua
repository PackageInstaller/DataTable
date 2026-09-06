local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Normal Enter")
  if controller._responseMouseClick then
    DialogManager.DestroySingletonDialog("guide.blockclickdefaultdialog")
  end
  if lastState == "FunctionUnlock" then
    controller._baseMainFSM:SetBoolean("mainFSMEnd", true)
    controller._responseMouseClick = true
    if not NekoData.BehaviorManager.BM_Guide:CanPlayGuide(40) and not NekoData.BehaviorManager.BM_Guide:CanPlayGuide(41) and not NekoData.BehaviorManager.BM_Guide:CanPlayGuide(42) then
      DialogManager.DestroySingletonDialog("guide.blockclickdefaultdialog")
    end
    NekoData.DataManager.DM_Game:ClearTip()
    local sign = NekoData.BehaviorManager.BM_Game:GetFastMenuSignFromCourtyard()
    if sign then
      NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard(nil, NekoData.BehaviorManager.BM_Game:GetFastMenuInfoFromCourtyard())
      if not NekoData.BehaviorManager.BM_Guide:HasCurrentGuide() then
        if sign == "CharacterList" then
          controller:SetCameraAnimatorState(9)
        elseif sign == "WorkShop" then
          controller:SetCameraAnimatorState(8)
        elseif sign == "Team" then
          local dialog = DialogManager.CreateSingletonDialog("teamedit.teampresetmaindialog")
          dialog:Init(controller)
        elseif sign == "Dungeon" then
          controller:SetCameraAnimatorState(1)
        elseif sign == "Gacha" then
          controller:SetCameraAnimatorState(2)
        elseif sign == "Task" then
          controller:SetCameraAnimatorState(3)
        elseif sign == "Shop" then
          local dialog = DialogManager.GetDialog("base.basemainui")
          dialog:OnShopClick()
        elseif sign == "HandBook" then
          local dialog = DialogManager.GetDialog("base.basemainmenudialog")
          dialog:OnHandBookClicked()
        elseif sign == "Guild" then
          controller:SetCameraAnimatorState(5)
        end
      end
    end
  elseif lastState == "Init" then
    controller._baseMainFSM:SetBoolean("toNormal", false)
  end
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, State, nil)
  if NekoData.BehaviorManager.BM_Guide:HasCurrentGuide() then
    controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", true)
  end
  if CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString then
    CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString()
  end
  local deeplinkStr = CS.PixelNeko.P1.DeepLink.GetInfo()
  if deeplinkStr and string.len(deeplinkStr) > 0 then
    controller._baseMainFSM:SetBoolean("toNormal", false)
    controller._baseMainFSM:SetBoolean("toDeeplink", true)
  end
  LuaNotificationCenter.AddObserver(State, State.OnOpenDeeplinkActivity, Common.n_OpenDeeplinkActivity, nil)
end

function State.Update(controller)
end

function State.OnExit(controller, nextState)
  if controller._responseMouseClick and nextState ~= "OpenPreMainCityBattleDialog" then
    NekoData.DataManager.DM_Game:ClearLastDungeonType()
    NekoData.DataManager.DM_Game:ClearLastAutoDungeonType()
  end
  LogInfo("BaseMainFSM", "Normal Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

function State.OnOpenDeeplinkActivity(observer, noitification)
  local GameFsmInMaincity = GlobalGameFSM:GetCurrentState() == "MainCity"
  if GameFsmInMaincity then
    if CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString then
      CS.PixelNeko.P1.DeepLink.GetDeepLinkJsonString()
    end
    local deeplinkStr = CS.PixelNeko.P1.DeepLink.GetInfo()
    LogInfoFormat("NormalFSM", "OnOpenDeeplinkActivity deeplinkStr = %s", deeplinkStr)
    if deeplinkStr and string.len(deeplinkStr) > 0 then
      NekoData.BehaviorManager.BM_GotoDialog:HandleDeepLink(deeplinkStr)
    end
  end
end

return State
