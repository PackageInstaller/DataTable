-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequiplevelupskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UniqueEquipLevelUpSkillCell = class("UniqueEquipLevelUpSkillCell", Dialog)
UniqueEquipLevelUpSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpSkillCell.AssetName = "CharEquipQHSkillCell"
UniqueEquipLevelUpSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipLevelUpSkillCell
  ((UniqueEquipLevelUpSkillCell.super).Ctor)(self, ...)
end

UniqueEquipLevelUpSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._curEffect = self:GetChild("RightPanel/Txt")
end

UniqueEquipLevelUpSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

UniqueEquipLevelUpSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local str = ((NekoData.BehaviorManager).BM_Message):GetUniqueEquipSkillDescribe(data.curSkillId)
  ;
  (self._curEffect):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1580) .. str)
end

return UniqueEquipLevelUpSkillCell

