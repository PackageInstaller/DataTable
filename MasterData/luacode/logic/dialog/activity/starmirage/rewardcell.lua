local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.mainline"
RewardCell.AssetName = "DungeonSelectItemCell"

function RewardCell:Ctor(...)
  RewardCell.super.Ctor(self, ...)
end

function RewardCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  self._count:SetActive(false)
  self._check = self:GetChild("Check")
  self._check:SetActive(false)
  self._firstLable = self:GetChild("First")
  self._normalLable = self:GetChild("Normal")
  self._chanceLable = self:GetChild("Chance")
  self:GetChild("Limited"):SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function RewardCell:OnDestroy()
end

local function RefreshShow(self, first, random, normal)
  self._firstLable:SetActive(first)
  self._normalLable:SetActive(normal)
  self._chanceLable:SetActive(random)
end

function RewardCell:RefreshCell(data)
  self._item = Item.Create(data.data.id)
  local image = self._item:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = self._item:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  if data.tag == "First" then
    RefreshShow(self, true, false, false)
  elseif data.tag == "Random" then
    RefreshShow(self, false, true, false)
  elseif data.tag == "Normal" then
    RefreshShow(self, false, false, true)
  end
end

function RewardCell:OnCellClick()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return RewardCell
