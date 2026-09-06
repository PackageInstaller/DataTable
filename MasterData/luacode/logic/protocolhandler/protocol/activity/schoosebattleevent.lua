local function p1(protocol)
  local dialog = DialogManager.GetDialog("activity.swimsuitechoes.challenge.eventlistdialog")
  
  if protocol.eventId > 0 then
    if dialog then
      dialog:GoBattle()
    end
  else
    LogError("schoosebattleevent", "verification failed ")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
