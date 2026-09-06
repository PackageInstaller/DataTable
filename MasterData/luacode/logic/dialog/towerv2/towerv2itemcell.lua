local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local TowerV2ItemCell = class("TowerV2ItemCell", Dialog)
TowerV2ItemCell.AssetBundleName = "ui/layouts.stair"
TowerV2ItemCell.AssetName = "StairMainItemCell"

function TowerV2ItemCell:Ctor(...)
  TowerV2ItemCell.super.Ctor(self, ...)
end

function TowerV2ItemCell:OnCreate()
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
  self._select:SetActive(false)
end

function TowerV2ItemCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2ItemCell:RefreshCell(data)
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

function TowerV2ItemCell:OnCellClicked(args)
  self._select:SetActive(true)
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

return TowerV2ItemCell
