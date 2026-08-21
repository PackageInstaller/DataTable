-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/yard/sinitmusic.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAudioPlayerCell = (BeanManager.GetTableByName)("courtyard.caudioplayercell")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, CAudioPlayerCell
  local level = ((NekoData.BehaviorManager).BM_YardMusic):GetLevel()
  if level == 0 and (protocol.music).level > 0 then
    (LuaNotificationCenter.PostNotification)(Common.n_BuildingUnlock, nil, {buildingId = DataCommon.YardMusic})
  end
  ;
  ((NekoData.DataManager).DM_YardMusic):OnSInitMusic(protocol)
  local allIds = CAudioPlayerCell:GetAllIds()
  ;
  ((NekoData.BehaviorManager).BM_YardMusic):SetPlayingId(allIds[1])
  ;
  (DialogManager.CreateSingletonDialog)("yardmusic.playingmusicdialog")
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_RefreshYardMusic, nil, nil)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

