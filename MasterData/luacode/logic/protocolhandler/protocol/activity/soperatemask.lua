local function p1(protocol)
  if protocol.result == 1 then
    local dialogName = "activity.swimsuit.maskdialog"
    
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      dialog:OnSOperateMask(protocol)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
