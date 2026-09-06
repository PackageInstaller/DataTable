local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local GuildUpGradeTipsCell = class("GuildUpGradeTipsCell", Dialog)
GuildUpGradeTipsCell.AssetBundleName = "ui/layouts.guild"
GuildUpGradeTipsCell.AssetName = "GuildUpgradeTipsItemCell"

function GuildUpGradeTipsCell:Ctor(...)
  GuildUpGradeTipsCell.super.Ctor(self, ...)
  self._item = nil
end

function GuildUpGradeTipsCell:OnCreate()
  self._back = self:GetChild("ItemCell/_BackGround")
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._imageframe = self:GetChild("ItemCell/_BackGround/Frame")
  self._num = self:GetChild("ItemCell/_Count")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._num:SetActive(false)
  self._select:SetActive(false)
  self._back:Subscribe_PointerClickEvent(self.OnItemClicked, self)
end

function GuildUpGradeTipsCell:RefreshCell(itemId)
  self._item = Item.Create(itemId)
  local imageRecord = self._item:GetPinJiImage()
  self._imageframe:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetIcon()
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function GuildUpGradeTipsCell:OnItemClicked()
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._item:GetKey())
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
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(self._item:GetID())
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

return GuildUpGradeTipsCell
