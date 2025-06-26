-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/scompletezone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local doNext = function()
    -- function num : 0_0_0 , upvalues : _ENV, protocol
    ((NekoData.DataManager).DM_Game):OnSCompleteZone(protocol)
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller then
      controller:OpenAccountDialogWhenCompleteZone()
    end
    ;
    ((NekoData.BehaviorManager).BM_Dungeon):ClearDungeonConquestList()
  end

  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" then
    local dialog = (DialogManager.CreateSingletonDialog)("battle.finishexploredialog")
    if dialog then
      dialog:SetSpiritGiveData(protocol.money)
      dialog:SetCallBackFunc(doNext)
    else
      doNext()
    end
  else
    do
      doNext()
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

