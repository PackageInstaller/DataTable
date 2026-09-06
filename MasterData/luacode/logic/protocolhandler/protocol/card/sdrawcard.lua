local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")

local function p1(protocol)
  LogInfoFormat("sdrawcard", "=====p1 111")
  DialogManager.DestroySingletonDialog("gacha.gachamoviedialog")
  LogInfoFormat("sdrawcard", "=====p1 222")
  local dialog = DialogManager.CreateSingletonDialog("gacha.gachamoviedialog")
  LogInfoFormat("sdrawcard", "=====p1 333")
  dialog:SetData(protocol.cards, protocol.drawCardType)
  LogInfoFormat("sdrawcard", "=====p1 444")
  NekoData.DataManager.DM_Gacha:OnSDrawCard(protocol.items, protocol.baodiNum, protocol.share, protocol.curDayTimes)
  LogInfoFormat("sdrawcard", "=====p1 555")
  LuaNotificationCenter.PostNotification(Common.n_DrawCard, nil, protocol)
  LogInfoFormat("sdrawcard", "=====p1 666")
  if protocol.drawCardType == DataCommon.DrawCardType.Role then
    for i, v in ipairs(protocol.cards) do
      if v.isNew == 1 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v.cardId)
        if role then
          local curUniqueEquipLevel = role:GetUniqueEquipLevel()
          if role:IsUnlockUniqueEquip() and curUniqueEquipLevel == 1 then
            local uniqueEquipItem = UniqueEquip.Create(role:GetUniqueEquipId())
            local curShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(curUniqueEquipLevel)
            local data = {
              tag = DataCommon.ShowDialogType.UniqueEquipUnlock,
              data = {
                lv = curUniqueEquipLevel,
                attrs = uniqueEquipItem:GetInitAttrs(),
                showSKillId = curShowSKillId,
                uniqueEquipItem = uniqueEquipItem
              }
            }
            NekoData.DataManager.DM_ItemAccountShow:CacheShowDialogData(data)
          end
        end
      end
    end
  end
end

local function p2(protocol, client)
end

return {p1, p2}
