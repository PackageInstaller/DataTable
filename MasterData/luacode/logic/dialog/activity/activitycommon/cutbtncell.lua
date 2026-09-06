local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CutBtnCell = class("CutBtnCell", Dialog)
CutBtnCell.AssetBundleName = "ui/layouts.activitycommon"
CutBtnCell.AssetName = "ActivityCommonMainCutBtn"

function CutBtnCell:Ctor(...)
  CutBtnCell.super.Ctor(self, ...)
end

function CutBtnCell:OnCreate()
  self._text = self:GetChild("CutBtn/Text")
  self._redDot = self:GetChild("CutBtn/RedDot")
  self._textImg = self:GetChild("CutBtn/TextImg")
  self._cutBtn = self:GetChild("CutBtn")
  self._cutBtn:Subscribe_PointerClickEvent(self.OnCutBtnClicked, self)
end

function CutBtnCell:OnDestroy()
end

function CutBtnCell:Init(delegate, data)
  self._data = data
  self._delegate = delegate
  self._text:SetText(TextManager.GetText(data.cfg.tabName))
  local imageRecord = CImagePathTable:GetRecorder(data.cfg.tabImg)
  if imageRecord then
    self._cutBtn:SetTextImgNormal(imageRecord.assetBundle, imageRecord.assetName)
  end
  local imageRecord = CImagePathTable:GetRecorder(data.cfg.tabImgPre)
  if imageRecord then
    self._cutBtn:SetTextImgSelected(imageRecord.assetBundle, imageRecord.assetName)
  end
  self:CheckRedDot()
  self:SelectThisBtn(false)
end

function CutBtnCell:CheckRedDot()
  local state = self._delegate._bm:GetRedDot(self._delegate._actId, self._data.cfg.tabType)
  self._redDot:SetActive(state)
end

function CutBtnCell:SelectThisBtn(state)
  self._cutBtn:SetSelected(state)
end

function CutBtnCell:OnCutBtnClicked()
  if self._delegate._bm:IsShopTabType(self._data.cfg.tabType) then
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = 48
    protocol:Send()
  end
  self._delegate:ClickCutBtn(self._data.id)
end

return CutBtnCell
