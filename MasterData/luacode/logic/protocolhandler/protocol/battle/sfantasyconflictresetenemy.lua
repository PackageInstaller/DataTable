local function p1(protocol)
  local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  
  data.enemyInfo = protocol.enemyInfo
  NekoData.DataManager.DM_Battle:SetSeasonData(data)
  local dialog = DialogManager.GetDialog("mainline.seasonpvp.seasonpvpmaindialog")
  if dialog then
    dialog:Init()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
