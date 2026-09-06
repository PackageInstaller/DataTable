local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local FragmentItemCell = class("FragmentItemCell", Dialog)
FragmentItemCell.AssetBundleName = "ui/layouts.fragment"
FragmentItemCell.AssetName = "FragmentItem"

function FragmentItemCell:Ctor(...)
  FragmentItemCell.super.Ctor(self, ...)
end

function FragmentItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._firstImage = self:GetChild("ItemCell/_Count/Image")
  self._firstText = self:GetChild("ItemCell/_Count/Text")
  self._doneImg = self:GetChild("ItemCell/Done")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function FragmentItemCell:OnDestroy()
end

function FragmentItemCell:RefreshCell(data)
  local count = data.count
  self._item = Item.Create(data.id)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetText(NumberManager.GetShowNumber(count))
  self._firstImage:SetActive(data.first)
  self._firstText:SetActive(data.first)
  self._doneImg:SetActive(data.get)
end

function FragmentItemCell:OnCellClicked(args, luawindow)
  if not self._item then
    return
  end
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:RefreshInfo(self._item)
        tipsDialog:HideBtn()
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

return FragmentItemCell
