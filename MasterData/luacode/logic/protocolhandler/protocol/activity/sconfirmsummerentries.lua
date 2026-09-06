local function p1(protocol)
  if protocol.result == 1 then
    local dialog = DialogManager.GetDialog("activity.swimsuitechoes.challenge.maindialog")
    
    if dialog then
      dialog:OpenTeam()
    end
  else
    LogError("sconfirmsummerentries", "verification failed")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
