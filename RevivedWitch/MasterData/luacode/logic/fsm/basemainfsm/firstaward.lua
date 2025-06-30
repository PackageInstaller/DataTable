-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/firstaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local controllera = nil
local SShowObtainPanelProtocol = require("protocols.def.protocol.battle.sshowobtainpanel")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, controllera, State, SShowObtainPanelProtocol
  LogInfo("BaseMainFSM", "FirstAward Enter")
  controllera = controller
  local lastFloorId = ((NekoData.BehaviorManager).BM_Game):GetLastFloorId()
  local autoType = ((NekoData.BehaviorManager).BM_Game):GetLastAutoDungeonType()
  local lastDungeonType = ((NekoData.BehaviorManager).BM_Game):GetLastDungeonType()
  local firstAward = ((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromDungeon()
  local tip = ((NekoData.BehaviorManager).BM_Game):GetTip()
  if tip == 0 or tip == 3 or tip == 6 then
    lastFloorId = 0
  end
  if lastFloorId ~= 0 or autoType == 3 and lastDungeonType == 5 then
    if #firstAward ~= 0 then
      local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonfirstawarddialog")
      if dialog then
        (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
      else
        ;
        (State.GoAccount)()
      end
    else
      do
        ;
        (State.GoAccount)()
        do
          local resourceAccountType = ((NekoData.BehaviorManager).BM_Game):GetResourceAccountType()
          if resourceAccountType and resourceAccountType == SShowObtainPanelProtocol.AWARD then
            (LuaNotificationCenter.AddObserver)(State, State.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
            ;
            ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).MainCityFirstAward, data = ((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromResource()})
          else
            ;
            (State.GoAccount)()
          end
          ;
          ((NekoData.DataManager).DM_Game):ClearFirstAward()
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.GoAccount = function()
  -- function num : 0_2 , upvalues : controllera
  (controllera._baseMainFSM):SetBoolean("toFirstAward", false)
  ;
  (controllera._baseMainFSM):SetBoolean("toAccount", true)
end

State.OnDialogDestroy = function(observer, notification)
  -- function num : 0_3 , upvalues : State
  if (notification.userInfo)._dialogName == "dungeon.dungeonfirstawarddialog" or (notification.userInfo)._dialogName == "base.maincityfirstawarddialog" then
    (State.GoAccount)()
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_4 , upvalues : _ENV, State
  LogInfo("BaseMainFSM", "FirstAward Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

return State

