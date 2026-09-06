local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local CItemNum = BeanManager.GetTableByName("item.citemnum")
local GachaEquipRateItemCell = class("GachaEquipRateItemCell", Dialog)
GachaEquipRateItemCell.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateItemCell.AssetName = "TowerLegendBoxCell"

function GachaEquipRateItemCell:Ctor(...)
  GachaEquipRateItemCell.super.Ctor(self, ...)
end

function GachaEquipRateItemCell:OnCreate()
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._select:SetActive(false)
end

function GachaEquipRateItemCell:OnDestroy()
end

function GachaEquipRateItemCell:RefreshCell(id)
  local item = Item.Create(id)
  self._item = item
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local recorder = CItemNum:GetRecorder(id)
  if recorder then
    self._count:SetActive(true)
    self._count:SetText(recorder.Num)
  else
    self._count:SetActive(false)
  end
end

function GachaEquipRateItemCell:OnCellClicked()
  local itemType = self._item:GetItemType()
  if itemType == ItemTypeEnum.EQUIP then
    local width, height = self:GetRootWindow():GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData, self._delegate._showEquipMaxLevel)
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self:GetRootWindow():GetRectSize()
        local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

return GachaEquipRateItemCell
