local function p1(protocol)
  if NekoData.DataManager.DM_WeekBoss:OnSWeekBossTalent(protocol) then
    DialogManager.CreateSingletonDialog("mainline.bossrush.bossrushweekcultivatedialog")
  end
  LuaNotificationCenter.PostNotification(Common.n_SWeekBossTalent, nil, protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
