local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local SkillBannerCell = class("SkillBannerCell", Dialog)
SkillBannerCell.AssetBundleName = "ui/layouts.battle"
SkillBannerCell.AssetName = "SkillBannerCell"

function SkillBannerCell:Ctor(...)
  SkillBannerCell.super.Ctor(self, ...)
  self._groupName = "Default"
end

function SkillBannerCell:OnCreate()
  self._lihui = self:GetChild("Live2D")
  self._skillName = self:GetChild("Text")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

function SkillBannerCell:OnDestroy()
end

function SkillBannerCell:SkillBegin(skillId, shapeId, entityId)
  local npcShapeRecorder = CNpcShapeTable:GetRecorder(shapeId)
  local iconID = npcShapeRecorder.lihuiID
  local imageRecord = CImagePathTable:GetRecorder(iconID)
  if imageRecord then
    self._lihui:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local skillRecord = CSkillShow_Common:GetRecorder(skillId)
  self._skillName:SetText(TextManager.GetText(skillRecord.nameTextID))
end

function SkillBannerCell:SkillEnd()
  self:GetRootWindow():PlayAnimation("SkillBannerHide")
end

function SkillBannerCell:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "SkillBannerHide" then
    self:Destroy()
  end
end

return SkillBannerCell
