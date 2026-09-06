local function p1(protocol)
  if protocol.score >= 0 then
    local dialog = DialogManager.GetDialog("mainline.undecidedroad.undecidedroadeditdialog")
    
    if dialog then
      dialog:OpenTeam()
    end
  else
    LogError("sconfirmentries", "entries select error %s")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
