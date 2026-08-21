-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/shop/smonthcarddailyreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if not sceneController or not sceneController._baseMainFSM or (sceneController._baseMainFSM):GetCurrentState() ~= "Normal" then
    ((NekoData.DataManager).DM_ItemAccountShow):CacheShowDialogData({tag = (DataCommon.ShowDialogType).MonthCardDailyAward, data = protocol.dailyReward})
  else
    ;
    ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).MonthCardDailyAward, data = protocol.dailyReward})
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

