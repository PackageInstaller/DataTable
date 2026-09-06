local TypeEnum = {
  [DataCommon.Activities.StarMirage] = true,
  [DataCommon.Activities.Anniversary] = true,
  [DataCommon.Activities.StarMirageCopy] = true
}

local function p1(protocol)
  if TypeEnum[protocol.activity] then
    local dialog = DialogManager.GetDialog("activity.starmirage.rankmaindialog")
    if dialog then
      dialog:OnRefreshRankList(protocol)
    end
  elseif protocol.activity == DataCommon.Activities.Christmas then
    local dialog = DialogManager.GetDialog("activity.christmas.rankmaindialog")
    if dialog then
      dialog:OnRefreshRankList(protocol)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
