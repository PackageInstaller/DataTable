local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local EquipBoxItemCell = class("EquipBoxItemCell", Dialog)
EquipBoxItemCell.AssetBundleName = "ui/layouts.baseshop"
EquipBoxItemCell.AssetName = "TowerLegendBoxCell"

function EquipBoxItemCell:Ctor(...)
  EquipBoxItemCell.super.Ctor(self, ...)
end

function EquipBoxItemCell:OnCreate()
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._select:SetActive(false)
  self._count:SetActive(false)
end

function EquipBoxItemCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EquipBoxItemCell:RefreshCell(id)
  local item = Item.Create(id)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function EquipBoxItemCell:OnCellClicked()
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
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
end

return EquipBoxItemCell
