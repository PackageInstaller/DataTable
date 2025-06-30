-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/card/sdrawcard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, UniqueEquip
  (DialogManager.DestroySingletonDialog)("gacha.gachamoviedialog")
  local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachamoviedialog")
  dialog:SetData(protocol.cards, protocol.drawCardType)
  ;
  ((NekoData.DataManager).DM_Gacha):OnSDrawCard(protocol.items, protocol.baodiNum, protocol.share, protocol.curDayTimes)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_DrawCard, nil, protocol)
  if protocol.drawCardType == (DataCommon.DrawCardType).Role then
    for i,v in ipairs(protocol.cards) do
      if v.isNew == 1 then
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v.cardId)
        if role then
          local curUniqueEquipLevel = role:GetUniqueEquipLevel()
          if role:IsUnlockUniqueEquip() and curUniqueEquipLevel == 1 then
            local uniqueEquipItem = (UniqueEquip.Create)(role:GetUniqueEquipId())
            local curShowSKillId = uniqueEquipItem:GetCurShowSkillIdByLevel(curUniqueEquipLevel)
            local data = {tag = (DataCommon.ShowDialogType).UniqueEquipUnlock, 
data = {lv = curUniqueEquipLevel, attrs = uniqueEquipItem:GetInitAttrs(), showSKillId = curShowSKillId, uniqueEquipItem = uniqueEquipItem}
}
            ;
            ((NekoData.DataManager).DM_ItemAccountShow):CacheShowDialogData(data)
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

