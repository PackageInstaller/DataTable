local function p1(protocol)
  LogInfoFormat("ssendwhitevalentineactivity", "state = %s, id = %s, rewardState = %s, roleId = %s", protocol.state, protocol.id, protocol.rewardState, protocol.roleId)
  
  NekoData.DataManager.DM_Activity:OnSSendWhiteValentineActivity(protocol)
  local dialog = DialogManager.GetDialog("activity.whitevalentine.whitevalentinemaindialog")
  if dialog then
    if protocol.state == 0 or protocol.id == 0 or protocol.rewardState == 1 then
      dialog:Destroy()
    else
      dialog:Init()
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
