local function p1(protocol)
  local dlg = DialogManager.GetDialog("invite.inviteawardlistdlg")
  
  if dlg then
    dlg:UpdateReward(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
