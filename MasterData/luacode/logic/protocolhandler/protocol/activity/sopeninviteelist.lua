local function p1(protocol)
  if #protocol.users > 0 then
    local dlg = DialogManager.CreateSingletonDialog("invite.inviteplayerlistdlg")
    
    dlg:Update(protocol)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100409)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
