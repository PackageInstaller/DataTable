local function p1(protocol)
  local chatMainDlg = DialogManager.GetDialog("chat.chatmaindialog")
  
  if chatMainDlg then
    chatMainDlg:ShowBorderWindow(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
