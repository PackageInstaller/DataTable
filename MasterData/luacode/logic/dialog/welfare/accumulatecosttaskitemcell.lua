local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local AccumulateCostTaskItemCell = class("AccumulateCostTaskItemCell", Dialog)
AccumulateCostTaskItemCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTaskItemCell.AssetName = "ActivityConsumptionCellItem"

function AccumulateCostTaskItemCell:Ctor(...)
  AccumulateCostTaskItemCell.super.Ctor(self, ...)
end

function AccumulateCostTaskItemCell:OnCreate()
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  self._grey = self:GetChild("Gray")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function AccumulateCostTaskItemCell:OnDestroy()
end

function AccumulateCostTaskItemCell:RefreshCell(data)
  self._item = Item.Create(data.itemId)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(NumberManager.GetShowNumber(data.itemNum))
  self._grey:SetActive(self._delegate._cellData.status == CommonAwardsSatus.FETCHED)
end

function AccumulateCostTaskItemCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return AccumulateCostTaskItemCell
