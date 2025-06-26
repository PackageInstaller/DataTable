-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sfantasyconflictchangeteam.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local data = ((NekoData.BehaviorManager).BM_Battle):GetSeasonData()
  if protocol.teamType == 1 then
    data.attackTeam = protocol.team
  else
    data.defendTeam = protocol.team
  end
  ;
  ((NekoData.DataManager).DM_Battle):SetSeasonData(data)
  local dialog = (DialogManager.GetDialog)("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(protocol.teamType)
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

