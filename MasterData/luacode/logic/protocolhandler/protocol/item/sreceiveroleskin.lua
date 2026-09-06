local function p1(protocol)
  NekoData.DataManager.DM_AllRoles:OnSReceiveRoleSkin(protocol)
  
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
    tag = DataCommon.ShowDialogType.GainRoleSkin,
    data = {
      itemId = protocol.skins.skinID
    }
  })
  LuaNotificationCenter.PostNotification(Common.n_SkinCheckedOrGain, nil, protocol.skins.skinID)
end

local function p2(protocol, client)
end

return {p1, p2}
