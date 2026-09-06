local function p1(protocol)
  local pools = NekoData.BehaviorManager.BM_Gacha:GetGachaPools()
  
  local old = false
  for _, poolInfo in ipairs(pools) do
    if not protocol.pools[poolInfo.id] then
      old = true
      break
    end
  end
  NekoData.DataManager.DM_Gacha:OnSUpdateCardPools(protocol)
  LuaNotificationCenter.PostNotification(Common.n_DrawCard, nil, protocol)
  if old then
    NekoData.BehaviorManager.BM_Message:AddConfirmDialog(NekoData.BehaviorManager.BM_Message:GetString(1302), function()
      DialogManager.DestroySingletonDialog("gacha.gacharesultdialog")
      local dialog = DialogManager.GetDialog("gacha.gachamaindialog")
      if dialog then
        dialog:OnRefreshPools()
      end
    end)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
