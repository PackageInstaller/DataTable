local function p1(protocol)
  local data = NekoData.BehaviorManager.BM_Battle:GetSeasonData()
  
  if data then
    data.enemyInfo = protocol.enemyInfo
    data.leftTime = protocol.leftTime
    data.stage = protocol.stage
    data.seasonId = protocol.seasonId
    data.currentScore = protocol.currentScore
    data.leftAttackAccessPoint = protocol.leftAttackAccessPoint
    NekoData.DataManager.DM_Battle:SetSeasonData(data)
    local dialog = DialogManager.GetDialog("mainline.seasonpvp.seasonpvpmaindialog")
    if dialog then
      dialog:Init()
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
