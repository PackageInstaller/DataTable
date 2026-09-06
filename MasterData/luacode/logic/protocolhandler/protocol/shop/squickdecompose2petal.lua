local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.charresolveshopsolddialog")
  
  if dialog then
    dialog:Destroy()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
