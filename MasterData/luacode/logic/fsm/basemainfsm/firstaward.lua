local State = {}
local controllera
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "FirstAward Enter")
  controllera = controller
  local lastFloorId = NekoData.BehaviorManager.BM_Game:GetLastFloorId()
  local autoType = NekoData.BehaviorManager.BM_Game:GetLastAutoDungeonType()
  local lastDungeonType = NekoData.BehaviorManager.BM_Game:GetLastDungeonType()
  local firstAward = NekoData.BehaviorManager.BM_Game:GetFirstAwardFromDungeon()
  local tip = NekoData.BehaviorManager.BM_Game:GetTip()
  if tip == 0 or tip == 3 or tip == 6 then
    lastFloorId = 0
  end
  if lastFloorId ~= 0 or autoType == 3 and lastDungeonType == 5 then
    if #firstAward ~= 0 then
      local dialog = DialogManager.CreateSingletonDialog("dungeon.dungeonfirstawarddialog")
      if dialog then
        LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      else
        State.GoAccount()
      end
    else
      State.GoAccount()
    end
  else
    local resourceAccountType = NekoData.BehaviorManager.BM_Game:GetResourceAccountType()
    if resourceAccountType and resourceAccountType == SShowObtainPanelProtocol.AWARD then
      LuaNotificationCenter.AddObserver(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
        tag = DataCommon.ShowDialogType.MainCityFirstAward,
        data = NekoData.BehaviorManager.BM_Game:GetFirstAwardFromResource()
      })
    else
      State.GoAccount()
    end
  end
  NekoData.DataManager.DM_Game:ClearFirstAward()
end

function State.Update(controller)
end

function State.GoAccount()
  controllera._baseMainFSM:SetBoolean("toFirstAward", false)
  controllera._baseMainFSM:SetBoolean("toAccount", true)
end

function State.OnDialogDestroy(observer, notification)
  if notification.userInfo._dialogName == "dungeon.dungeonfirstawarddialog" or notification.userInfo._dialogName == "base.maincityfirstawarddialog" then
    State.GoAccount()
  end
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "FirstAward Exit")
  LuaNotificationCenter.RemoveObserver(State)
end

return State
