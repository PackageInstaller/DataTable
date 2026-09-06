local function p1(protocol)
  NekoData.BehaviorManager.BM_Message:SendMessageById(100529)
  
  local chatMainDlg = DialogManager.GetDialog("chat.chatmaindialog")
  if chatMainDlg then
    chatMainDlg:UpdateCurBorder(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
