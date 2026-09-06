local Item = require("logic.manager.experimental.types.item")
local DungeonUseItemsSecondConfirmCell = class("DungeonUseItemsSecondConfirmCell", Dialog)
DungeonUseItemsSecondConfirmCell.AssetBundleName = "ui/layouts.dungeon"
DungeonUseItemsSecondConfirmCell.AssetName = "DungeonItemCell"

function DungeonUseItemsSecondConfirmCell:Ctor(...)
  DungeonUseItemsSecondConfirmCell.super.Ctor(self, ...)
end

function DungeonUseItemsSecondConfirmCell:OnCreate()
  self._img = self:GetChild("Frame/BackGround/Icon")
  self._count = self:GetChild("Frame/Count")
  self._count:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnSelfClick, self)
end

function DungeonUseItemsSecondConfirmCell:OnDestroy()
end

function DungeonUseItemsSecondConfirmCell:RefreshCell(data)
  self._data = data.data
  local item = Item.Create(data.data)
  local imageRecord = item:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
    self._count:SetActive(true)
  end
end

function DungeonUseItemsSecondConfirmCell:OnSelfClick()
  self._delegate._whichitem = self._data
end

return DungeonUseItemsSecondConfirmCell
