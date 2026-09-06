local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.SignManagerID):OnSReceiveAward(protocol)
  
  if #protocol.itemInfo > 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = {
        items = protocol.itemInfo
      }
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_RefreshSignActivity, nil, protocol.actId)
end

local function p2(protocol, client)
end

return {p1, p2}
