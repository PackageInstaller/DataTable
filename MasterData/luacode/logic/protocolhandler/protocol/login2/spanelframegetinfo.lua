local function p1(protocol)
  local friendsMainDlg = DialogManager.GetDialog("friend.friendsmaindialog")
  
  if friendsMainDlg then
    friendsMainDlg:UpdateBorderList(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
