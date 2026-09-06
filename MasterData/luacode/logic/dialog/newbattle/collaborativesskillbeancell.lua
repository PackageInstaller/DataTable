local CollaborativesSkillBeanCell = class("CollaborativesSkillBeanCell", Dialog)
CollaborativesSkillBeanCell.AssetBundleName = "ui/layouts.battle"
CollaborativesSkillBeanCell.AssetName = "HPCellSkillMark"

function CollaborativesSkillBeanCell:Ctor(...)
  CollaborativesSkillBeanCell.super.Ctor(self, ...)
end

function CollaborativesSkillBeanCell:OnCreate()
  self._mark0 = self:GetChild("Mark0")
  self._mark1 = self:GetChild("Mark1")
  self._mark2 = self:GetChild("Mark2")
end

function CollaborativesSkillBeanCell:OnDestroy()
end

function CollaborativesSkillBeanCell:RefreshCell(data)
  if self._delegate:IsFullBean() then
    self._mark0:SetActive(false)
    self._mark1:SetActive(false)
    self._mark2:SetActive(true)
  elseif self._delegate:IsFilledBean(self._cellData.id) then
    self._mark0:SetActive(false)
    self._mark1:SetActive(true)
    self._mark2:SetActive(false)
  else
    self._mark0:SetActive(true)
    self._mark1:SetActive(false)
    self._mark2:SetActive(false)
  end
end

return CollaborativesSkillBeanCell
