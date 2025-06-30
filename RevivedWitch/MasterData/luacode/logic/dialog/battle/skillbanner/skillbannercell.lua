-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/skillbanner/skillbannercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local SkillBannerCell = class("SkillBannerCell", Dialog)
SkillBannerCell.AssetBundleName = "ui/layouts.battle"
SkillBannerCell.AssetName = "SkillBannerCell"
SkillBannerCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillBannerCell
  ((SkillBannerCell.super).Ctor)(self, ...)
  self._groupName = "Default"
end

SkillBannerCell.OnCreate = function(self)
  -- function num : 0_1
  self._lihui = self:GetChild("Live2D")
  self._skillName = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
end

SkillBannerCell.OnDestroy = function(self)
  -- function num : 0_2
end

SkillBannerCell.SkillBegin = function(self, skillId, shapeId, entityId)
  -- function num : 0_3 , upvalues : CNpcShapeTable, CImagePathTable, CSkillShow_Common, _ENV
  local npcShapeRecorder = CNpcShapeTable:GetRecorder(shapeId)
  local iconID = npcShapeRecorder.lihuiID
  local imageRecord = CImagePathTable:GetRecorder(iconID)
  if imageRecord then
    (self._lihui):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local skillRecord = CSkillShow_Common:GetRecorder(skillId)
  ;
  (self._skillName):SetText((TextManager.GetText)(skillRecord.nameTextID))
end

SkillBannerCell.SkillEnd = function(self)
  -- function num : 0_4
  (self:GetRootWindow()):PlayAnimation("SkillBannerHide")
end

SkillBannerCell.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_5
  if stateName == "SkillBannerHide" then
    self:Destroy()
  end
end

return SkillBannerCell

