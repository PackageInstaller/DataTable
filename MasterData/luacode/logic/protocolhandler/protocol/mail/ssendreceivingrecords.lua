local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("mail.mailrecorddialog")
  
  if dialog then
    dialog:OnSSendReceivingRecords(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
