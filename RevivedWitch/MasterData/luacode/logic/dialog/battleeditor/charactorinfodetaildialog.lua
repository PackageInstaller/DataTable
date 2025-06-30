-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battleeditor/charactorinfodetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CharactorInfoDetailDialog = class("CharactorInfoDetailDialog", Dialog)
CharactorInfoDetailDialog.AssetBundleName = "ui/layouts.battleeditor"
CharactorInfoDetailDialog.AssetName = "CharactorInfoDetail"
CharactorInfoDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharactorInfoDetailDialog
  ((CharactorInfoDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

CharactorInfoDetailDialog.OnCreate = function(self, root)
  -- function num : 0_1
  self._exit = self:GetChild("BackBtn")
  self._leftPhoto = self:GetChild("InfoFrame/Left/Photo")
  self._leftName = self:GetChild("InfoFrame/Left/NameBack/NameTXT")
  self._leftJobName = self:GetChild("InfoFrame/Left/NameBack/JobTXT")
  self._rightJobName = self:GetChild("InfoFrame/RightTop/Job")
  self._rightLevel = self:GetChild("InfoFrame/RightTop/Level")
  self._rightHP = self:GetChild("InfoFrame/RightTop/HP")
  self._rightSpeed = self:GetChild("InfoFrame/RightTop/SPD")
  self._rightADAtk = self:GetChild("InfoFrame/RightTop/AD_Atk")
  self._rightADDef = self:GetChild("InfoFrame/RightTop/AD_Def")
  self._rightAPAtk = self:GetChild("InfoFrame/RightTop/AP_Atk")
  self._rightAPDef = self:GetChild("InfoFrame/RightTop/AP_Def")
  self._rightSkill1Name = self:GetChild("InfoFrame/RightBottom/Skill1Name")
  self._rightSkill1Info = self:GetChild("InfoFrame/RightBottom/Skill1Info")
  self._rightSkill2Name = self:GetChild("InfoFrame/RightBottom/Skill2Name")
  self._rightSkill2Info = self:GetChild("InfoFrame/RightBottom/Skill2Info")
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

CharactorInfoDetailDialog.OnDestroy = function(self)
  -- function num : 0_2
end

CharactorInfoDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battleeditor.charactorinfodetaildialog")
end

CharactorInfoDetailDialog.RefreshRoleInfoDetail = function(self, id)
  -- function num : 0_4 , upvalues : RoleConfigTable, CNpcShapeTable, CImagePathTable, _ENV, CSkillShow_Role
  local roleConfigRecord = RoleConfigTable:GetRecorder(id)
  local shapeRecord = CNpcShapeTable:GetRecorder(roleConfigRecord.shapeID)
  if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._leftName):SetText((TextManager.GetText)(roleConfigRecord.nameTextID))
  ;
  (self._leftJobName):SetText(roleConfigRecord.vocation)
  ;
  (self._rightJobName):SetText(roleConfigRecord.vocation)
  ;
  (self._rightLevel):SetText(90)
  ;
  (self._rightHP):SetText(roleConfigRecord.hp)
  ;
  (self._rightSpeed):SetText(roleConfigRecord.speed)
  ;
  (self._rightADAtk):SetText(roleConfigRecord.attack)
  ;
  (self._rightADDef):SetText(roleConfigRecord.def)
  ;
  (self._rightAPAtk):SetText(roleConfigRecord.magic)
  ;
  (self._rightAPDef):SetText(roleConfigRecord.magicDef)
  ;
  (self._leftPhoto):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local skillRecord = CSkillShow_Role:GetRecorder(roleConfigRecord.attackID)
  ;
  (self._rightSkill1Name):SetText((TextManager.GetText)(skillRecord.nameTextID))
  ;
  (self._rightSkill1Info):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(roleConfigRecord.attackID))
  local skillRecord = CSkillShow_Role:GetRecorder(roleConfigRecord.skillid)
  ;
  (self._rightSkill2Name):SetText((TextManager.GetText)(skillRecord.nameTextID))
  ;
  (self._rightSkill2Info):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(roleConfigRecord.skillid))
end

return CharactorInfoDetailDialog

