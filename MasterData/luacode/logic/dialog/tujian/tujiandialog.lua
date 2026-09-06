local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local TuJianDialog = class("TuJianDialog", Dialog)
TuJianDialog.AssetBundleName = "ui/layouts.tujian"
TuJianDialog.AssetName = "TuJian"

function TuJianDialog:Ctor(...)
  TuJianDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TuJianDialog:OnCreate()
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
  self._btn1:Subscribe_PointerClickEvent(self.OnBtn1Click, self)
  self._image1:Subscribe_PointerClickEvent(self.OnBtn1Click, self)
  UIBackManager.SetUIBackShow(true)
  self:Refresh()
end

function TuJianDialog:OnDestroy()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  UIBackManager.SetUIBackShow(false)
end

function TuJianDialog:Init(sceneController)
  self._baseSceneController = sceneController
end

function TuJianDialog:Refresh()
  local charOwn = #NekoData.BehaviorManager.BM_Game:GetTuJianList()
  local charAll = #CRoleConfigTable:GetAllIds()
  if charAll < 1 then
    charAll = 1
  end
  self._progress1:SetFillAmount(charOwn / charAll)
  self._text1:SetText(tostring(charOwn .. "/" .. charAll))
end

function TuJianDialog:OnBtn1Click()
  DialogManager.CreateSingletonDialog("tujian.tujianpagedialog")
end

function TuJianDialog:OnBackPressed()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
  self:Destroy()
  return true, true
end

return TuJianDialog
