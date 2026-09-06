local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.shopmaindialog")
  
  if dialog then
    dialog:SetHomePage(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
