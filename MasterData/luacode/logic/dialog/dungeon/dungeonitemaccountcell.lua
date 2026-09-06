local Item = require("logic.manager.experimental.types.item")
local DungeonItemAccountCell = class("DungeonItemAccountCell", Dialog)
DungeonItemAccountCell.AssetBundleName = "ui/layouts.dungeon"
DungeonItemAccountCell.AssetName = "DungeonItemCell"

function DungeonItemAccountCell:Ctor(...)
  DungeonItemAccountCell.super.Ctor(self, ...)
end

function DungeonItemAccountCell:OnCreate()
  self._img = self:GetChild("Frame/BackGround/Icon")
  self._count = self:GetChild("Frame/Count")
  self._name = self:GetChild("Frame/Name")
  self._count:SetActive(false)
end

function DungeonItemAccountCell:OnDestroy()
end

function DungeonItemAccountCell:Refresh(data)
  self._data = data.id
  local item = Item.Create(data.id)
  local imageRecord = item:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
    self._count:SetActive(true)
  end
  self._name:SetText(data.name)
end

return DungeonItemAccountCell
