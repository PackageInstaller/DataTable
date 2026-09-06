local ShareSingleDialog = class("ShareSingleDialog", Dialog)
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
ShareSingleDialog.AssetBundleName = "ui/layouts.tujianpuzzle"
ShareSingleDialog.AssetName = "TuJianPuzzleShow"

function ShareSingleDialog:Ctor(...)
  ShareSingleDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function ShareSingleDialog:OnCreate()
  self._img = self:GetChild("BackImage/Puzzle")
  self._share = self:GetChild("BackImage/DownloadBtn")
  self._back = self:GetChild("BackImage/CloseBtn")
  self._share:Subscribe_PointerClickEvent(self.OnShareClick, self)
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function ShareSingleDialog:OnDestroy()
end

function ShareSingleDialog:SetData(data)
  self._data = data
  local imgRecord = CImagePathTable:GetRecorder(data.SharePic_id) or DataCommon.DefaultImageAsset
  self._img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

function ShareSingleDialog:OnShareClick(args)
  DialogManager.CreateSingletonDialog("handbook.memorybookfullscreendialog"):SetData(self._data)
  self:Destroy()
end

function ShareSingleDialog:OnBackBtnClicked()
  self:Destroy()
end

return ShareSingleDialog
