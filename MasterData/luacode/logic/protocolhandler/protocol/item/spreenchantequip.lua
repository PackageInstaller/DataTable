local function p1(protocol)
  NekoData.DataManager.DM_Game:SetCanPreEnchantEquip(protocol.leftEnchant > 0)
  
  if protocol.leftEnchant < 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100266)
  else
    NekoData.DataManager.DM_BagInfo:OnSPreEnchantEquip(protocol)
    local equipFMResultDialog = DialogManager.CreateSingletonDialog("equipforge.equipfmresultdialog")
    equipFMResultDialog:Refresh(protocol)
    LuaNotificationCenter.PostNotification(Common.n_PreEnchantEquip, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
