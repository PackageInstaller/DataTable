local function p1(protocol)
  local offlinepvpmaindialog = DialogManager.GetDialog("mainline.offlinepvp.offlinepvpmaindialog")
  
  if offlinepvpmaindialog then
    local offlinepvprankingdialog = DialogManager.CreateSingletonDialog("mainline.offlinepvp.offlinepvprankingdialog")
    if offlinepvprankingdialog then
      offlinepvprankingdialog:Init(protocol)
    end
  end
  local seasonpvpmaindialog = DialogManager.GetDialog("mainline.seasonpvp.seasonpvpmaindialog")
  if seasonpvpmaindialog then
    local seasonpvprankingdialog = DialogManager.CreateSingletonDialog("mainline.seasonpvp.seasonpvprankingdialog")
    if seasonpvprankingdialog then
      seasonpvprankingdialog:Init(protocol)
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
