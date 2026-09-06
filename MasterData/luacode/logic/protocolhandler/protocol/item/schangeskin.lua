local CSkin = BeanManager.GetTableByName("role.cskin")

local function p1(protocol)
  local dialog = DialogManager.GetDialog("shop.fashionbuyresultdialog")
  if dialog then
    dialog:Destroy()
  end
  if protocol.skin2Change > 0 then
    NekoData.DataManager.DM_AllRoles:OnSChangeSkin(protocol)
    local skinRecord = CSkin:GetRecorder(protocol.skin2Change)
    if skinRecord then
      NekoData.BehaviorManager.BM_AllRoles:SetSkinRedDotChecked(skinRecord)
    else
      LogErrorFormat("schangeskin", "recorder with id %s is not exist in cskin", protocol.skin2Change)
    end
    LuaNotificationCenter.PostNotification(Common.n_RefreshFashion, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
