local function p1(protocol)
  local dialog = DialogManager.GetDialog("roleevaluation.roleevaluationmaindialog")
  
  if dialog then
    dialog:SetData(protocol)
  else
    DialogManager.CreateSingletonDialog("roleevaluation.roleevaluationmaindialog"):SetData(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
