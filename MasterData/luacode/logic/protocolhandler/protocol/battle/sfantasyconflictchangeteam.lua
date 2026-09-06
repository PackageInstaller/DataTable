local function p1(protocol)
  local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  
  if protocol.teamType == 1 then
    data.attackTeam = protocol.team
  else
    data.defendTeam = protocol.team
  end
  NekoData.DataManager.DM_Battle:SetSeasonData(data)
  local dialog = DialogManager.GetDialog("mainline.seasonpvp.seasonteameditdialog")
  if dialog then
    dialog:SetData(protocol.teamType)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
