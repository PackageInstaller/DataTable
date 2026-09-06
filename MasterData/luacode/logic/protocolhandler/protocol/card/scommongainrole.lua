local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")

local function p1(protocol)
  NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
    tag = DataCommon.ShowDialogType.GainRole,
    data = protocol.roles
  })
  NekoData.DataManager.DM_Gacha:OnSCommonGainRole(protocol)
  local convertItems = NekoData.BehaviorManager.BM_Gacha:GetConvertItems()
  if convertItems and #convertItems ~= 0 then
    NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData({
      tag = DataCommon.ShowDialogType.ItemAccount,
      data = {items = convertItems}
    })
    NekoData.BehaviorManager.BM_Gacha:ClearConvertItems()
  end
  for i, v in ipairs(protocol.roles) do
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

local function p2(protocol, client)
end

return {p1, p2}
