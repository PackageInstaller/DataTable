local function p1(protocol)
  local dialog = DialogManager.GetDialog("activity.swimsuitechoes.challenge.rank.rankmaindialog")
  
  if dialog then
    dialog:OnRefreshRankList(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
