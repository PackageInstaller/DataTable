-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sfantasyconflictbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_Battle):GetSeasonData()
  if data then
    data.enemyInfo = protocol.enemyInfo
    data.leftTime = protocol.leftTime
    data.stage = protocol.stage
    data.seasonId = protocol.seasonId
    data.currentScore = protocol.currentScore
    data.leftAttackAccessPoint = protocol.leftAttackAccessPoint
    ;
    ((NekoData.DataManager).DM_Battle):SetSeasonData(data)
    local dialog = (DialogManager.GetDialog)("mainline.seasonpvp.seasonpvpmaindialog")
    if dialog then
      dialog:Init()
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

