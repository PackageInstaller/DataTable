local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CExploreRarity = BeanManager.GetTableByName("courtyard.cexplorerarity")
local DescriptionCell = class("DescriptionCell", Dialog)
DescriptionCell.AssetBundleName = "ui/layouts.yard"
DescriptionCell.AssetName = "YardExploreDetailCell"

function DescriptionCell:Ctor(...)
  DescriptionCell.super.Ctor(self, ...)
  self._secondaryItemList = {}
end

function DescriptionCell:OnCreate()
  self._lvIcon = self:GetChild("Panel/Level")
  self._nameTxt = self:GetChild("Panel/Txt2")
  self._mainItemIcon = self:GetChild("Panel/Image")
  self._mainItemNumTxt = self:GetChild("Panel/Num")
  self._secondaryItemPanel = self:GetChild("Panel/ItemFrame")
  self._secondaryItemFrame = TableFrame.Create(self._secondaryItemPanel, self, false, false)
  self._mainItemIcon:Subscribe_PointerClickEvent(self.OnMainItemClick, self)
end

function DescriptionCell:OnDestroy()
  self._secondaryItemFrame:Destroy()
end

function DescriptionCell:RefreshCell(data)
  local rarityRecord = CExploreRarity:GetRecorder(data.rarity)
  if rarityRecord then
    local imageRecord = CImagePathTable:GetRecorder(rarityRecord.explorerarity) or DataCommon.DefaultImageAsset
    self._lvIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogInfoFormat("DescriptionCell", "Can not find record in CExploreRarity by rarity(%s)", data.rarity)
  end
  self._nameTxt:SetText(TextManager.GetText(data.nameTextID))
  local item = Item.Create(data.mainItem)
  self._mainItem = item
  local imageRecord = item:GetIcon()
  self._mainItemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._mainItemNumTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1321, {
    data.mainItemNum
  }))
  while self._secondaryItemList[#self._secondaryItemList] do
    table.remove(self._secondaryItemList, #self._secondaryItemList)
  end
  for i, v in ipairs(data.secondaryItem) do
    table.insert(self._secondaryItemList, Item.Create(v))
  end
  self._secondaryItemFrame:ReloadAllCell()
end

function DescriptionCell:OnMainItemClick()
  local width, height = self._mainItemIcon:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._mainItem
    })
    tipsDialog:SetTipsPosition(width, height, self._mainItemIcon:GetLocalPointInUiRootPanel())
  end
end

function DescriptionCell:NumberOfCell()
  return #self._secondaryItemList
end

function DescriptionCell:CellAtIndex(frame, index)
  return "explore.secondaryitemcell"
end

function DescriptionCell:DataAtIndex(frame, index)
  return self._secondaryItemList[index]
end

return DescriptionCell
