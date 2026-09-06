local CAlchemyPicRes = BeanManager.GetTableByName("courtyard.calchemypicres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local QualityTabBtnCell = class("QualityTabBtnCell", Dialog)
QualityTabBtnCell.AssetBundleName = "ui/layouts.yard"
QualityTabBtnCell.AssetName = "AlchemyChooseGroupBtn"

function QualityTabBtnCell:Ctor(...)
  QualityTabBtnCell.super.Ctor(self, ...)
end

function QualityTabBtnCell:OnCreate()
  self._groupBtn = self:GetChild("GroupBtn")
  self._groupBtnTxt = self:GetChild("GroupBtn/Text")
  self._groupBtnDot = self:GetChild("GroupBtn/Dot")
  self._groupBtnLock = self:GetChild("GroupBtn/Lock")
  self._groupBtn:Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
end

function QualityTabBtnCell:OnDestroy()
end

function QualityTabBtnCell:RefreshCell(data)
  local alchemyPicResRecord = CAlchemyPicRes:GetRecorder(data.level)
  local imgRecord = CImagePathTable:GetRecorder(alchemyPicResRecord.bookmarkdot) or DataCommon.DefaultImageAsset
  self._groupBtnDot:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local levelTxtId = 800119 + data.level - 1
  self._groupBtnTxt:SetText(TextManager.GetText(levelTxtId))
  self._groupBtn:SetSelected(data.level == self._delegate._selectLv)
  if data.data.lock then
    self._groupBtnDot:SetActive(false)
    self._groupBtnLock:SetActive(true)
  else
    self._groupBtnDot:SetActive(true)
    self._groupBtnLock:SetActive(false)
  end
end

function QualityTabBtnCell:OnGroupBtnClicked()
  self._delegate:SelectLevel(self._cellData.level)
end

function QualityTabBtnCell:OnEvent(eventName, arg)
  if eventName == "SetSelectTab" then
    self._groupBtn:SetSelected(self._cellData.level == arg)
  end
end

return QualityTabBtnCell
