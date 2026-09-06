local function p1(protocol)
  local dialog = DialogManager.GetDialog("roleevaluation.roleevaluationmaindialog")
  
  if protocol.result == 1 and dialog then
    dialog:NewComment(protocol.userComment)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
