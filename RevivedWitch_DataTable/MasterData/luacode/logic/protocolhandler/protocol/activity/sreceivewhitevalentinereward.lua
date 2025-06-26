-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/sreceivewhitevalentinereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("sreceivewhitevalentinereward", "id = %s", protocol.id)
  local data = ((NekoData.BehaviorManager).BM_Activity):GetWhiteValentine()
  if data and data.id == protocol.id then
    ((NekoData.DataManager).DM_Activity):OnSReceiveWhiteValentineReward(protocol)
    ;
    (DialogManager.DestroySingletonDialog)("activity.whitevalentine.whitevalentinemaindialog")
  else
    if data then
      LogErrorFormat("sreceivewhitevalentinereward", "data is not match! id1: %s, id2: %s.", data.id, protocol.id)
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

