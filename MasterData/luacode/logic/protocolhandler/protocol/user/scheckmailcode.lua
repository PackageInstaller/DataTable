local function p1(protocol)
  if protocol.result == 1 then
    NekoData.DataManager.DM_Game:OnSCheckMailCode(protocol)
    
    local dialog = DialogManager.GetDialog("systemsetting.systemsettingdialog")
    if dialog then
      dialog:OnRefreshIdentityTabCell()
    end
    DialogManager.DestroySingletonDialog("systemsetting.mailboxbinddialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
