local BossRushRankBossCell = class("BossRushRankBossCell", Dialog)
BossRushRankBossCell.AssetBundleName = "ui/layouts.mainline"
BossRushRankBossCell.AssetName = "BossRushRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function BossRushRankBossCell:Ctor(...)
  BossRushRankBossCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function BossRushRankBossCell:OnCreate()
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BossRushRankBossCell:OnDestroy()
end

function BossRushRankBossCell:RefreshCell()
  local image = cimagepath:GetRecorder(self._cellData.image)
  self._img:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(self._cellData.name)
  self._select:SetActive(self._cellData.id == self._delegate._selectBossRushId)
end

function BossRushRankBossCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectBossCell(self._cellData)
end

function BossRushRankBossCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseBossRush" then
    if self._cellData.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return BossRushRankBossCell
