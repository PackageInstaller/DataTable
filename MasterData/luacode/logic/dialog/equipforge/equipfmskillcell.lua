local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local EquipFMSkillCell = class("EquipFMSkillCell", Dialog)
EquipFMSkillCell.AssetBundleName = "ui/layouts.equip"
EquipFMSkillCell.AssetName = "EquipFMSkill"

function EquipFMSkillCell:Ctor(...)
  EquipFMSkillCell.super.Ctor(self, ...)
end

function EquipFMSkillCell:OnCreate()
  self._name = self:GetChild("Num")
  self._unlockDescription = self:GetChild("Txt2")
  self._toggle = self:GetChild("_Toggle_0")
  self._toggle:SetIsOnType(false)
  self._toggle:Subscribe_PointerClickEvent(self.OnToggleClicked, self)
end

function EquipFMSkillCell:OnDestroy()
end

function EquipFMSkillCell:RefreshCell(data)
  local name = CSkillShow_Common:GetRecorder(data.skillId).nameTextID
  name = TextManager.GetText(name)
  self._name:SetText(name)
end

function EquipFMSkillCell:OnToggleClicked()
  self._delegate:OnToggleClicked(self._cellData.skillId)
  self._toggle:SetIsOnType(true)
end

function EquipFMSkillCell:OnEvent(eventName, arg)
  if eventName == "OffAllToggle" then
    self._toggle:SetIsOnType(false)
  end
end

return EquipFMSkillCell
