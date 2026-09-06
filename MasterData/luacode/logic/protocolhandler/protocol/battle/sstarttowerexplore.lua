local function p1(protocol)
  DialogManager.DestroySingletonDialog("mainline.mainline.mainlineworlddialog")
  
  NekoData.DataManager.DM_Tower:OnSStartTowerExplore(protocol)
  GlobalGameFSM:SetNumber("sceneLoadingId", 30009)
end

local function p2(protocol, client)
end

return {p1, p2}
