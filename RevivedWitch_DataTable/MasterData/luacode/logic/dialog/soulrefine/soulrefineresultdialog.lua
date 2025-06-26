-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/soulrefine/soulrefineresultdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local SoulRefineResultDialog = class("SoulRefineResultDialog", Dialog)
SoulRefineResultDialog.AssetBundleName = "ui/layouts.baseskill"
SoulRefineResultDialog.AssetName = "BaseSkillChangeResultChar"
SoulRefineResultDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SoulRefineResultDialog
  ((SoulRefineResultDialog.super).Ctor)(self, ...)
  self._fastMenuDialogStatus = false
  self._groupName = "Modal"
  self._handler = nil
  self._skillKey = nil
end

SoulRefineResultDialog.OnCreate = function(self)
  -- function num : 0_1
  self._live2d = self:GetChild("Live2D")
  self._photo = self:GetChild("Photo")
  self._talk = self:GetChild("Dialog/Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

SoulRefineResultDialog.OnDestroy = function(self)
  -- function num : 0_2
end

SoulRefineResultDialog.OnSRoleConverSkill = function(self, skillKey, roleid)
  -- function num : 0_3 , upvalues : Role, _ENV
  self._skillKey = skillKey
  local role = (Role.Create)(roleid)
  local record = role:GetShapeLive2DRecord()
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
  if (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName then
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    ;
    (self._photo):SetActive(true)
    ;
    (self._photo):SetSprite((role:GetShapeLiHuiImageRecord()).assetBundle, (role:GetShapeLiHuiImageRecord()).assetName)
    local scale = role:GetPhotoScale()
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    local photoPos = role:GetPhotoPosition()
    ;
    (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
  end
  do
    ;
    (self._talk):SetText(role:GetSoulRefineTalk())
  end
end

SoulRefineResultDialog.OnMouseClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("soulrefine.soulrefineresultskilldialog")):SetData(self._skillKey)
  self:Destroy()
end

return SoulRefineResultDialog

