local UniqueEquipLevelUpSkillCell = class("UniqueEquipLevelUpSkillCell", Dialog)
UniqueEquipLevelUpSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpSkillCell.AssetName = "CharEquipQHSkillCell"

function UniqueEquipLevelUpSkillCell:Ctor(...)
  UniqueEquipLevelUpSkillCell.super.Ctor(self, ...)
end

function UniqueEquipLevelUpSkillCell:OnCreate()
  self._curEffect = self:GetChild("RightPanel/Txt")
end

function UniqueEquipLevelUpSkillCell:OnDestroy()
end

function UniqueEquipLevelUpSkillCell:RefreshCell(data)
  local str = NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(data.curSkillId)
  self._curEffect:SetText(NekoData.BehaviorManager.BM_Message:GetString(1580) .. str)
end

return UniqueEquipLevelUpSkillCell
