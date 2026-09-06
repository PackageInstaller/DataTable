local function p1(protocol)
  local dlg = DialogManager.CreateSingletonDialog("invite.inviteawardlistdlg")
  
  dlg:Update(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
