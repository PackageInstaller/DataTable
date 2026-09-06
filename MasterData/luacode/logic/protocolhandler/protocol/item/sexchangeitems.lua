local function p1(protocol)
  local data = {
    items = protocol.itemList
  }
  if data.items and #data.items > 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = data
    })
  end
  LogInfoFormat("sexchangeitems", "activityId = %s", protocol.activityId)
  if protocol.activityId == NekoData.BehaviorManager.BM_Activity:GetActivityIdByType(DataCommon.GeneralCollectionActFuncType) then
    local dialog = DialogManager.GetDialog("activity.midautumn.midautumndialog")
    if dialog then
      dialog._animator:Play("like")
    end
    DialogManager.DestroySingletonDialog("activity.midautumn.exchangedialog")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
