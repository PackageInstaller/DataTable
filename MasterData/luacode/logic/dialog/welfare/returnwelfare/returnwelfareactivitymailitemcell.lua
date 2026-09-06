local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local ReturnWelfareActivityMailItemCell = class("ReturnWelfareActivityMailItemCell", Dialog)
ReturnWelfareActivityMailItemCell.AssetBundleName = "ui/layouts.activityhud"
ReturnWelfareActivityMailItemCell.AssetName = "CellItem"

function ReturnWelfareActivityMailItemCell:Ctor(...)
  ReturnWelfareActivityMailItemCell.super.Ctor(self, ...)
end

function ReturnWelfareActivityMailItemCell:OnCreate()
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
end

function ReturnWelfareActivityMailItemCell:OnDestroy()
end

function ReturnWelfareActivityMailItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
  else
    self._count:SetNumber(data.item:GetCount())
  end
end

function ReturnWelfareActivityMailItemCell:OnCellClicked(args)
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._cellData.item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetKey())
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
        tipsDialog:Init(self._cellData.item:GetID())
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
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

return ReturnWelfareActivityMailItemCell
