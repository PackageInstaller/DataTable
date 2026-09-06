local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local SurveyItemCell = class("SurveyItemCell", Dialog)
SurveyItemCell.AssetBundleName = "ui/layouts.survey"
SurveyItemCell.AssetName = "SurveyItemCell"

function SurveyItemCell:Ctor(...)
  SurveyItemCell.super.Ctor(self, ...)
end

function SurveyItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._Select = self:GetChild("ItemCell/_BackGround/Select")
  self._Select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SurveyItemCell:OnDestroy()
end

function SurveyItemCell:RefreshCell(data)
  if not data.item then
    self._icon:SetSprite(DataCommon.NullImageAsset.assetBundle, DataCommon.NullImageAsset.assetName)
    self._count:SetText("")
    return
  end
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

function SurveyItemCell:OnCellClicked(args, luawindow)
  if not self._cellData.item then
    return
  end
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._cellData.item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:RefreshInfo(self._cellData.item)
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
      tipsDialog:Init(self._cellData, true)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

return SurveyItemCell
