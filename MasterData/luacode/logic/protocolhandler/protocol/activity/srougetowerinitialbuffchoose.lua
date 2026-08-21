-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/srougetowerinitialbuffchoose.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_TowerV2):OnSRougeTowerInitialBuffChoose(protocol)
  ;
  (DialogManager.DestroySingletonDialog)("towerv2.towerv2revertdialog")
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local candidates = ((NekoData.BehaviorManager).BM_TowerV2):GetInitBuffCandidates()
  if candidates and #candidates ~= 0 then
    ((DialogManager.CreateSingletonDialog)("towerv2.towerv2buffchoosedialog")):SetData(nil, candidates, controller)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

