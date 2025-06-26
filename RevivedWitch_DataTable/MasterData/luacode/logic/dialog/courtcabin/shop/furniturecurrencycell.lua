-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/furniturecurrencycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local FurnitureCurrencyCell = class("FurnitureCurrencyCell", Dialog)
FurnitureCurrencyCell.AssetBundleName = "ui/layouts.yard"
FurnitureCurrencyCell.AssetName = "TopGroupCell"
FurnitureCurrencyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureCurrencyCell
  ((FurnitureCurrencyCell.super).Ctor)(self, ...)
end

FurnitureCurrencyCell.OnCreate = function(self)
  -- function num : 0_1
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
end

FurnitureCurrencyCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureCurrencyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._text):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(data))
end

FurnitureCurrencyCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._cell):GetLocalPointInUiRootPanel())
  end
end

FurnitureCurrencyCell.OnAddBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._cellData == DataCommon.DiamodID then
    ((NekoData.BehaviorManager).BM_Shop):JumpToShopBuyDiamonds()
  else
    if self._cellData == DataCommon.FurnitureCion then
      ((NekoData.BehaviorManager).BM_Message):OpenCurrencyExchangeDialog(1)
    end
  end
end

return FurnitureCurrencyCell

