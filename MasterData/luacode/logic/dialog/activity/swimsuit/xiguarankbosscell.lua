local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local XiGuaRankBossCell = class("XiGuaRankBossCell", Dialog)
XiGuaRankBossCell.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankBossCell.AssetName = "ActivitySummerXiGuaRankBossCell"

function XiGuaRankBossCell:Ctor(...)
  XiGuaRankBossCell.super.Ctor(self, ...)
end

function XiGuaRankBossCell:OnCreate()
  self._boss = self:GetChild("Boss")
  self._text = self:GetChild("Text")
  self._checkBorder = self:GetChild("Select")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function XiGuaRankBossCell:OnDestroy()
end

function XiGuaRankBossCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    if arg == self._index then
      self._checkBorder:SetActive(true)
    else
      self._checkBorder:SetActive(false)
    end
  end
end

function XiGuaRankBossCell:RefreshCell(data)
  self._index = data.index
  self._data = data.data
  local imageRecord = CImagePathTable:GetRecorder(self._data.cfg.tapImage) or DataCommon.DefaultImageAsset
  self._boss:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._text:SetText(TextManager.GetText(self._data.cfg.name))
  self._checkBorder:SetActive(self._index == self._delegate._selectedBossCellIndex)
end

function XiGuaRankBossCell:OnCellClicked()
  self._delegate:OneBossCellSelect(self._index)
end

return XiGuaRankBossCell
