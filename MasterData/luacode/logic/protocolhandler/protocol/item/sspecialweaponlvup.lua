local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")

local function p1(protocol)
  if protocol.result == 1 then
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
    local uniqueEquipItem = UniqueEquip.Create(role:GetUniqueEquipId())
    local lastUniqueEquipLevel = role:GetUniqueEquipLevel()
    local lastUniqueEquipAttrs = role:GetUniqueEquipCurAttrs()
    local lastShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(lastUniqueEquipLevel)
    NekoData.DataManager.DM_AllRoles:OnSSpecialWeaponlvUp(protocol)
    local curUniqueEquipLevel = role:GetUniqueEquipLevel()
    local curUniqueEquipAttrs = role:GetUniqueEquipCurAttrs()
    local curShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(curUniqueEquipLevel)
    if lastUniqueEquipLevel == 0 and curUniqueEquipLevel == 1 then
      local data = {
        tag = DataCommon.ShowDialogType.UniqueEquipUnlock,
        data = {
          lv = curUniqueEquipLevel,
          attrs = curUniqueEquipAttrs,
          showSKillId = curShowSKillId,
          uniqueEquipItem = uniqueEquipItem
        }
      }
      if DialogManager.GetDialog("gacha.gachamaindialog") then
        NekoData.DataManager.DM_ItemAccountShow:CacheShowDialogData(data)
      else
        NekoData.DataManager.DM_ItemAccountShow:AddShowDialogData(data)
      end
    else
      DialogManager.CreateSingletonDialog("uniqueequip.uniqueequiplevelupdialog"):SetData({
        lastLv = lastUniqueEquipLevel,
        lastattrs = lastUniqueEquipAttrs,
        lastShowSKillId = lastShowSKillId,
        curLv = curUniqueEquipLevel,
        curattrs = curUniqueEquipAttrs,
        curShowSKillId = curShowSKillId,
        uniqueEquipItem = uniqueEquipItem
      })
    end
    LuaNotificationCenter.PostNotification(Common.n_UniqueEquipLevelUp, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}
