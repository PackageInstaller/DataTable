local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("activity.lover.loverchocolatedialog")
  
  if dialog then
    dialog:SetData(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
