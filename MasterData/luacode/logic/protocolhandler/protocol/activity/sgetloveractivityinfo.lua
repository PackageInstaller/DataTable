local function p1(protocol)
  NekoData.DataManager.DM_Activity:GetManager(DataCommon.LoverActivityManagerID):OnSGetLoverActivityInfo(protocol)
  
  DialogManager.CreateSingletonDialog("activity.lover.lovertransitiondialog")
end

local function p2(protocol, client)
end

return {p1, p2}
