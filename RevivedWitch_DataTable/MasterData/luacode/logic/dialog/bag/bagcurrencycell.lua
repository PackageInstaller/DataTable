-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/bagcurrencycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local BagCurrencyCell = class("BagCurrencyCell", Dialog)
BagCurrencyCell.AssetBundleName = "ui/layouts.bag"
BagCurrencyCell.AssetName = "TopCurrencyCell"
BagCurrencyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BagCurrencyCell
  ((BagCurrencyCell.super).Ctor)(self, ...)
end

BagCurrencyCell.OnCreate = function(self, root)
  -- function num : 0_1
  self._btn = self:GetChild("Button")
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Text")
  self._addBtn = self:GetChild("Add")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddClicked, self)
end

BagCurrencyCell.OnDestroy = function(self)
  -- function num : 0_2
end

BagCurrencyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  self._currencyId = data.CurrencyID
  if not CImagePathTable:GetRecorder(data.CurrencyShowID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._currencyId))
end

BagCurrencyCell.OnAddClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(self._currencyId)
end

BagCurrencyCell.OnBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(self._currencyId)})
    local width, height = (self._btn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._btn):GetLocalPointInUiRootPanel())
  end
end

return BagCurrencyCell

