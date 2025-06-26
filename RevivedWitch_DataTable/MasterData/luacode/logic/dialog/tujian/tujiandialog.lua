-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiandialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local TuJianDialog = class("TuJianDialog", Dialog)
TuJianDialog.AssetBundleName = "ui/layouts.tujian"
TuJianDialog.AssetName = "TuJian"
TuJianDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianDialog
  ((TuJianDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TuJianDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._btn1 = self:GetChild("Type1/EnterBtn")
  self._btn2 = self:GetChild("Type2/EnterBtn")
  self._btn3 = self:GetChild("Type3/EnterBtn")
  self._btn4 = self:GetChild("Type4/EnterBtn")
  self._image1 = self:GetChild("Type1/Image")
  self._image2 = self:GetChild("Type2/Image")
  self._image3 = self:GetChild("Type3/Image")
  self._image4 = self:GetChild("Type4/Image")
  self._progress1 = self:GetChild("Type1/ProgressTuJian/_Progress")
  self._progress2 = self:GetChild("Type2/ProgressTuJian/_Progress")
  self._progress3 = self:GetChild("Type3/ProgressTuJian/_Progress")
  self._progress4 = self:GetChild("Type4/ProgressTuJian/_Progress")
  self._text1 = self:GetChild("Type1/ProgressTuJian/_Text")
  self._text2 = self:GetChild("Type2/ProgressTuJian/_Text")
  self._text3 = self:GetChild("Type3/ProgressTuJian/_Text")
  self._text4 = self:GetChild("Type4/ProgressTuJian/_Text")
  ;
  (self._btn1):Subscribe_PointerClickEvent(self.OnBtn1Click, self)
  ;
  (self._image1):Subscribe_PointerClickEvent(self.OnBtn1Click, self)
  ;
  (UIBackManager.SetUIBackShow)(true)
  self:Refresh()
end

TuJianDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
end

TuJianDialog.Init = function(self, sceneController)
  -- function num : 0_3
  self._baseSceneController = sceneController
end

TuJianDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, CRoleConfigTable
  local charOwn = #((NekoData.BehaviorManager).BM_Game):GetTuJianList()
  local charAll = #CRoleConfigTable:GetAllIds()
  if charAll < 1 then
    charAll = 1
  end
  ;
  (self._progress1):SetFillAmount(charOwn / charAll)
  ;
  (self._text1):SetText(tostring(charOwn .. "/" .. charAll))
end

TuJianDialog.OnBtn1Click = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("tujian.tujianpagedialog")
end

TuJianDialog.OnBackPressed = function(self)
  -- function num : 0_6
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  self:Destroy()
  return true, true
end

return TuJianDialog

