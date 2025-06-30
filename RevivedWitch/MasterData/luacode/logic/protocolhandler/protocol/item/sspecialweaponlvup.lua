-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/item/sspecialweaponlvup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, UniqueEquip
  if protocol.result == 1 then
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(protocol.roleId)
    local uniqueEquipItem = (UniqueEquip.Create)(role:GetUniqueEquipId())
    local lastUniqueEquipLevel = role:GetUniqueEquipLevel()
    local lastUniqueEquipAttrs = role:GetUniqueEquipCurAttrs()
    local lastShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(lastUniqueEquipLevel)
    ;
    ((NekoData.DataManager).DM_AllRoles):OnSSpecialWeaponlvUp(protocol)
    local curUniqueEquipLevel = role:GetUniqueEquipLevel()
    local curUniqueEquipAttrs = role:GetUniqueEquipCurAttrs()
    local curShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(curUniqueEquipLevel)
    if lastUniqueEquipLevel == 0 and curUniqueEquipLevel == 1 then
      local data = {tag = (DataCommon.ShowDialogType).UniqueEquipUnlock, 
data = {lv = curUniqueEquipLevel, attrs = curUniqueEquipAttrs, showSKillId = curShowSKillId, uniqueEquipItem = uniqueEquipItem}
}
      if (DialogManager.GetDialog)("gacha.gachamaindialog") then
        ((NekoData.DataManager).DM_ItemAccountShow):CacheShowDialogData(data)
      else
        ;
        ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData(data)
      end
    else
      do
        ;
        ((DialogManager.CreateSingletonDialog)("uniqueequip.uniqueequiplevelupdialog")):SetData({lastLv = lastUniqueEquipLevel, lastattrs = lastUniqueEquipAttrs, lastShowSKillId = lastShowSKillId, curLv = curUniqueEquipLevel, curattrs = curUniqueEquipAttrs, curShowSKillId = curShowSKillId, uniqueEquipItem = uniqueEquipItem})
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_UniqueEquipLevelUp, nil, protocol)
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

