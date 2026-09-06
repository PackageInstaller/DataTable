local function p1(protocol)
  local resourceFloorDialog = DialogManager.GetDialog("mainline.resource.resourcefloordialog")
  
  if resourceFloorDialog and not NekoData.BehaviorManager.BM_Team:GetTeamEditCopyInfo() then
    LogError("srefreshsupportrolelist 数据不匹配")
    return
  end
  NekoData.DataManager.DM_Friends:OnSRefreshSupportRoleList(protocol)
  local selectLevelMainDialog = DialogManager.GetDialog("activity.starmirage.selectlevelmaindialog")
  if selectLevelMainDialog then
    local tabCell = selectLevelMainDialog._tabFrame:GetCellAtIndex(selectLevelMainDialog._tabType)
    if tabCell and not tabCell._selectLevelId then
      return
    end
  end
  local dialog = DialogManager.GetDialog("assistbattle.choosesupportroledialog")
  dialog = dialog or DialogManager.CreateSingletonDialog("assistbattle.choosesupportroledialog")
  dialog:OnSRefreshSupportRoleList(protocol)
end

local function p2(protocol, client)
end

return {p1, p2}
