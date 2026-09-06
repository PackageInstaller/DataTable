local Item = require("logic.manager.experimental.types.item")
local FlowerRankRewardCell = class("FlowerRankRewardCell", Dialog)
FlowerRankRewardCell.AssetBundleName = "ui/layouts.flower"
FlowerRankRewardCell.AssetName = "FlowerRewardCell"

function FlowerRankRewardCell:Ctor(...)
  FlowerRankRewardCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function FlowerRankRewardCell:OnCreate()
  self._descripeText = self:GetChild("Panel/Description/Txt")
  self._cellItem = {}
  for i = 1, 7 do
    self._cellItem[i] = {}
    self._cellItem[i].root = self:GetChild("CellItem" .. tostring(i))
    self._cellItem[i].root:SetActive(false)
    self._cellItem[i].frame = self:GetChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Frame")
    self._cellItem[i].count = self:GetChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_Count")
    self._cellItem[i].icon = self:GetChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Icon")
    self._cellItem[i].item = nil
    self._cellItem[i].root:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end, self)
  end
end

function FlowerRankRewardCell:OnDestroy()
end

function FlowerRankRewardCell:RefreshCell(data)
  local count = 0
  for index, cellItem in ipairs(self._cellItem) do
    local itemID = data.itemID[index]
    if itemID and 0 < itemID then
      count = count + 1
      cellItem.root:SetActive(true)
      cellItem.item = Item.Create(itemID)
      local imageRecord = cellItem.item:GetIcon()
      cellItem.icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = cellItem.item:GetPinJiImage()
      cellItem.frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      cellItem.count:SetNumber(data.itemNum[index])
    end
  end
  for index = count + 1, #self._cellItem do
    self._cellItem[index].root:SetActive(false)
  end
  self._descripeText:SetText(TextManager.GetText(tonumber(data.txt)))
end

function FlowerRankRewardCell:OnCellClick(index)
  local width, height = self._cellItem[index].root:GetRectSize()
  if self._cellItem[index].item then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._cellItem[index].item
      })
      tipsDialog:SetTipsPosition(width, height, self._cellItem[index].root:GetLocalPointInUiRootPanel())
    end
  end
end

return FlowerRankRewardCell
