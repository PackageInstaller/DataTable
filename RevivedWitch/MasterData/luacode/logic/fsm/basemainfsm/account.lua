-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/account.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")
local MainCity = require("logic.fsm.gamefsm.maincity")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State, SShowObtainPanelProtocol
  LogInfo("BaseMainFSM", "Account Enter")
  controllera = controller
  local lastFloorId = ((NekoData.BehaviorManager).BM_Game):GetLastFloorId()
  local autoType = ((NekoData.BehaviorManager).BM_Game):GetLastAutoDungeonType()
  local lastDungeonType = ((NekoData.BehaviorManager).BM_Game):GetLastDungeonType()
  local tip = ((NekoData.BehaviorManager).BM_Game):GetTip()
  if tip == 0 or tip == 3 or tip == 6 then
    lastFloorId = 0
  end
  if lastFloorId ~= 0 or ((autoType == 3 and lastDungeonType == 5) or autoType ~= 8 or lastDungeonType == 5) then
    local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonaccountdialog")
    if dialog then
      (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
    else
      ;
      (controller._baseMainFSM):SetBoolean("toAccount", false)
    end
  else
    do
      local resourceAccountType = ((NekoData.BehaviorManager).BM_Game):GetResourceAccountType()
      if resourceAccountType and resourceAccountType == SShowObtainPanelProtocol.RETURN then
        ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).MainCityAccount, data = ((NekoData.BehaviorManager).BM_Game):GetResourceObtainMoney()})
        ;
        (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      else
        ;
        (controller._baseMainFSM):SetBoolean("toAccount", false)
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_2 , upvalues : controllera
  if (notification.userInfo)._dialogName == "dungeon.dungeonaccountdialog" or (notification.userInfo)._dialogName == "base.maincityaccountdialog" then
    (controllera._baseMainFSM):SetBoolean("toAccount", false)
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_3 , upvalues : _ENV, State, MainCity
  LogInfo("BaseMainFSM", "Account Exit")
  ;
  ((NekoData.DataManager).DM_Team):ClearSupportRole()
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
  ;
  ((NekoData.DataManager).DM_Game):OnSShowObtainPanel(nil)
  if MainCity.enterByBattle then
    MainCity.enterByBattle = false
    ;
    (DialogManager.DestroySingletonDialog)("base.hidemaincitymodaldialog")
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_EnterMianCity, nil, nil)
  end
end

return State

