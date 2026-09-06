local State = {}
local controllera
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")
local MainCity = require("logic.fsm.gamefsm.maincity")

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "Account Enter")
  controllera = controller
  local lastFloorId = NekoData.BehaviorManager.BM_Game:GetLastFloorId()
  local autoType = NekoData.BehaviorManager.BM_Game:GetLastAutoDungeonType()
  local lastDungeonType = NekoData.BehaviorManager.BM_Game:GetLastDungeonType()
  local tip = NekoData.BehaviorManager.BM_Game:GetTip()
  if tip == 0 or tip == 3 or tip == 6 then
    lastFloorId = 0
  end
  if lastFloorId ~= 0 or autoType == 3 and lastDungeonType == 5 or autoType == 8 and lastDungeonType == 5 then
    local dialog = DialogManager.CreateSingletonDialog("dungeon.dungeonaccountdialog")
    if dialog then
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    else
      controller._baseMainFSM:SetBoolean("toAccount", false)
    end
  else
    local resourceAccountType = NekoData.BehaviorManager.BM_Game:GetResourceAccountType()
    if resourceAccountType and resourceAccountType == SShowObtainPanelProtocol.RETURN then
      NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
        tag = DataCommon.ShowDialogType.MainCityAccount,
        data = NekoData.BehaviorManager.BM_Game:GetResourceObtainMoney()
      })
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    else
      controller._baseMainFSM:SetBoolean("toAccount", false)
    end
  end
end

function State.Update(controller)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "dungeon.dungeonaccountdialog" or notification.userInfo._dialogName == "base.maincityaccountdialog" then
    controllera._baseMainFSM:SetBoolean("toAccount", false)
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "Account Exit")
  NekoData.DataManager.DM_Team:ClearSupportRole()
  LuaNotificationCenter.RemoveObserver(State)
  NekoData.DataManager.DM_Game:OnSShowObtainPanel(nil)
  if MainCity.enterByBattle then
    MainCity.enterByBattle = false
    DialogManager.DestroySingletonDialog("base.hidemaincitymodaldialog")
    LuaNotificationCenter.PostNotification(Common.n_EnterMianCity, nil, nil)
  end
end

return State
