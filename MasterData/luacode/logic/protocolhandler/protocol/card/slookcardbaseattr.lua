local function p1(protocol)
  local dialog = DialogManager.GetDialog("mainline.bossrush.checkotherroleinfodialog")
  
  if dialog then
    dialog:SetRoleBaseAttr(protocol.role)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
