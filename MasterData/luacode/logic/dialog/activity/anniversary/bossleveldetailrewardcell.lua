local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local BossLevelDetailRewardCell = class("BossLevelDetailRewardCell", Dialog)
BossLevelDetailRewardCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
BossLevelDetailRewardCell.AssetName = "Activity1YearAnniversaryBossDetailItemCell"

function BossLevelDetailRewardCell:Ctor(...)
  BossLevelDetailRewardCell.super.Ctor(self, ...)
end

function BossLevelDetailRewardCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function BossLevelDetailRewardCell:OnDestroy()
end

function BossLevelDetailRewardCell:RefreshCell(data)
  self._item = Item.Create(data.data.id)
  local image = self._item:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = self._item:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
end

function BossLevelDetailRewardCell:OnCellClick()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return BossLevelDetailRewardCell
