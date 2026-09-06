local function p1(protocol)
  NekoData.DataManager.DM_Mail:OnSReceiveMails(protocol)
  
  local userInfo = {}
  userInfo.info = protocol.uniqueIds
  userInfo.tag = "sreceivemails"
  LuaNotificationCenter.PostNotification(Common.n_MailInfoChange, DM_Mail, userInfo)
  if #protocol.role > 0 then
    local dialog = DialogManager.CreateSingletonDialog("gacha.gachamoviedialog")
    if dialog then
      dialog:DisplaySpecialCard(protocol.role, protocol.items)
    end
  elseif 0 < #protocol.items then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = protocol
    })
  end
end

local function p2(protocol, client)
end

return {p1, p2}
