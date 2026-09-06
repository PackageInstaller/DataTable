local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RankBossCell = class("RankBossCell", Dialog)
RankBossCell.AssetBundleName = "ui/layouts.activitysummer2"
RankBossCell.AssetName = "ActivitySummer2XiGuaRankBossCell"

function RankBossCell:Ctor(...)
  RankBossCell.super.Ctor(self, ...)
end

function RankBossCell:OnCreate()
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function RankBossCell:OnDestroy()
end

function RankBossCell:RefreshCell(data)
  local image = CImagePathTable:GetRecorder(data.tapimageid) or DataCommon.DefaultImageAsset
  self._img:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(TextManager.GetText(data.nameTextID))
  self._select:SetActive(data.id == self._delegate._tabType)
end

function RankBossCell:OnCellClicked()
  self._delegate:SetType(self._cellData.id)
end

function RankBossCell:OnEvent(eventName, arg)
  if eventName == "ChooseBossRush" then
    self._select:SetActive(self._cellData.id == self._delegate._tabType)
  end
end

return RankBossCell
