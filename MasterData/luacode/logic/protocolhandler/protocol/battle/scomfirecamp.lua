local function p1(protocol)
  DialogManager.DestroySingletonDialog("mainline.offlinepvp.campselectiondialog")
  
  NekoData.DataManager.DM_Activity:SetArenaCamp(protocol.camp)
end

local function p2(protocol, client)
end

return {p1, p2}
