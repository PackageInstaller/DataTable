local function p1(protocol)
  local dialog = DialogManager.CreateSingletonDialog("guildboss.guildbossrankdialog")
  
  if dialog then
    dialog:RefreshRankList(protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
