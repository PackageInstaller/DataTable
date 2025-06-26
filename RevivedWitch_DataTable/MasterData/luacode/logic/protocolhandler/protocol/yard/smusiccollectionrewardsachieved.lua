-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/smusiccollectionrewardsachieved.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_YardMusic):OnSMusicCollectionRewardsAchieved(protocol)
  local dialog = (DialogManager.GetDialog)("yardmusic.rewarddialog")
  if dialog then
    dialog:Init()
  end
  dialog = (DialogManager.GetDialog)("yardmusic.yardmusicdialog")
  if dialog then
    dialog:RefreshCollectBtnRedDot()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_BuildingGetNumChanged, nil, {buildingId = DataCommon.YardMusic, state = ((NekoData.BehaviorManager).BM_YardMusic):GetGetNum()})
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

