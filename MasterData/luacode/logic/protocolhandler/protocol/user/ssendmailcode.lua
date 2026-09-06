local function p1(protocol)
  NekoData.DataManager.DM_Game:OnSSendMailCode(protocol)
  
  local dialog = DialogManager.GetDialog("systemsetting.mailboxbinddialog")
  if dialog then
    dialog:Refresh()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
