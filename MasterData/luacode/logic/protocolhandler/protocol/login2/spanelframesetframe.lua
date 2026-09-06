local function p1(protocol)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100528)
  
  local friendsMainDlg = DialogManager.GetDialog("friend.friendsmaindialog")
  if friendsMainDlg then
    friendsMainDlg:UpdateCurBorder(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
