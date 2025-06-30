-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/descriptioncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CExploreRarity = (BeanManager.GetTableByName)("courtyard.cexplorerarity")
local DescriptionCell = class("DescriptionCell", Dialog)
DescriptionCell.AssetBundleName = "ui/layouts.yard"
DescriptionCell.AssetName = "YardExploreDetailCell"
DescriptionCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DescriptionCell
  ((DescriptionCell.super).Ctor)(self, ...)
  self._secondaryItemList = {}
end

DescriptionCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._lvIcon = self:GetChild("Panel/Level")
  self._nameTxt = self:GetChild("Panel/Txt2")
  self._mainItemIcon = self:GetChild("Panel/Image")
  self._mainItemNumTxt = self:GetChild("Panel/Num")
  self._secondaryItemPanel = self:GetChild("Panel/ItemFrame")
  self._secondaryItemFrame = (TableFrame.Create)(self._secondaryItemPanel, self, false, false)
  ;
  (self._mainItemIcon):Subscribe_PointerClickEvent(self.OnMainItemClick, self)
end

DescriptionCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._secondaryItemFrame):Destroy()
end

DescriptionCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CExploreRarity, CImagePathTable, _ENV, Item
  local rarityRecord = CExploreRarity:GetRecorder(data.rarity)
  if rarityRecord then
    if not CImagePathTable:GetRecorder(rarityRecord.explorerarity) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._lvIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      LogInfoFormat("DescriptionCell", "Can not find record in CExploreRarity by rarity(%s)", data.rarity)
      ;
      (self._nameTxt):SetText((TextManager.GetText)(data.nameTextID))
      local item = (Item.Create)(data.mainItem)
      self._mainItem = item
      local imageRecord = item:GetIcon()
      ;
      (self._mainItemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._mainItemNumTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1321, {data.mainItemNum}))
      while (self._secondaryItemList)[#self._secondaryItemList] do
        (table.remove)(self._secondaryItemList, #self._secondaryItemList)
      end
      for i,v in ipairs(data.secondaryItem) do
        (table.insert)(self._secondaryItemList, (Item.Create)(v))
      end
      ;
      (self._secondaryItemFrame):ReloadAllCell()
    end
  end
end

DescriptionCell.OnMainItemClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._mainItemIcon):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._mainItem})
    tipsDialog:SetTipsPosition(width, height, (self._mainItemIcon):GetLocalPointInUiRootPanel())
  end
end

DescriptionCell.NumberOfCell = function(self)
  -- function num : 0_5
  return #self._secondaryItemList
end

DescriptionCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "explore.secondaryitemcell"
end

DescriptionCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._secondaryItemList)[index]
end

return DescriptionCell

