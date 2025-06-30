-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sdragonboatfestivalinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  local bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)
  dm:OnSDragonBoatFestivalInfo(protocol)
  if bm:GetIsOpen() then
    bm:SendCDragonBoatFestivalWish()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SDragonBoatFestivalInfo, nil, protocol)
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

