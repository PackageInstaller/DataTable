local UndecidedRoadRankBossCell = class("UndecidedRoadRankBossCell", Dialog)
UndecidedRoadRankBossCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadRankBossCell.AssetName = "ActivityRoadRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")

function UndecidedRoadRankBossCell:Ctor(...)
  UndecidedRoadRankBossCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function UndecidedRoadRankBossCell:OnCreate()
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  self._title = self:GetChild("Difficulty/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function UndecidedRoadRankBossCell:OnDestroy()
end

function UndecidedRoadRankBossCell:RefreshCell()
  local image = cimagepath:GetRecorder(self._cellData.image)
  self._img:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(self._cellData.name)
  self._select:SetActive(self._cellData.id == self._delegate._selectDayId)
  if self._cellData.id == 1 then
    self._title:SetText(TextManager.GetText(1901007))
  else
    self._title:SetText(TextManager.GetText(1901008) .. " " .. self._cellData.id - 1)
  end
end

function UndecidedRoadRankBossCell:OnCellClicked()
  if not self._cellData then
    return
  end
  self._delegate:OnSelectBossCell(self._cellData)
end

function UndecidedRoadRankBossCell:OnEvent(eventName, arg)
  if self._cellData and eventName == "ChooseBossRush" then
    if self._cellData.id == arg then
      self._select:SetActive(true)
    else
      self._select:SetActive(false)
    end
  end
end

return UndecidedRoadRankBossCell
