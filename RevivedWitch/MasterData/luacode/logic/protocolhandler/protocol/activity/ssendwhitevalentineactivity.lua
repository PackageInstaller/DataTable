-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/activity/ssendwhitevalentineactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  LogInfoFormat("ssendwhitevalentineactivity", "state = %s, id = %s, rewardState = %s, roleId = %s", protocol.state, protocol.id, protocol.rewardState, protocol.roleId)
  ;
  ((NekoData.DataManager).DM_Activity):OnSSendWhiteValentineActivity(protocol)
  local dialog = (DialogManager.GetDialog)("activity.whitevalentine.whitevalentinemaindialog")
  if dialog then
    if protocol.state == 0 or protocol.id == 0 or protocol.rewardState == 1 then
      dialog:Destroy()
    else
      dialog:Init()
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

