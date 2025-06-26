-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/themefurniturecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ThemeFurnitureCell = class("ThemeFurnitureCell", Dialog)
ThemeFurnitureCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureCell.AssetName = "FurnitureThemeBuyFrameCell"
ThemeFurnitureCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeFurnitureCell
  ((ThemeFurnitureCell.super).Ctor)(self, ...)
end

ThemeFurnitureCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._buyNum = self:GetChild("Num")
  self._icon = self:GetChild("Icon")
  self._price = self:GetChild("Price")
end

ThemeFurnitureCell.OnDestroy = function(self)
  -- function num : 0_2
end

ThemeFurnitureCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  local id = (data.furnitureItem):GetID()
  local serverData = ((((self._delegate)._delegate)._furnitures)[id]).serverData
  if ((self._delegate)._cellData).type == ((self._delegate)._delegate)._haveFurnitureType then
    (self._icon):SetActive(false)
    ;
    (self._price):SetActive(false)
    local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(id) - (((self._delegate)._delegate)._themeInfo).haveNum * ((((self._delegate)._delegate)._themeInfo).furnitures)[id]
    ;
    (self._buyNum):SetText(haveNum)
  else
    do
      ;
      (self._icon):SetActive(true)
      ;
      (self._price):SetActive(true)
      local costCurrencyItem = (Item.Create)(serverData.moneyType)
      do
        local imageRecord = costCurrencyItem:GetIcon()
        ;
        (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self:RefreshNumAndPrice()
        ;
        (self._name):SetText((data.furnitureItem):GetName())
      end
    end
  end
end

ThemeFurnitureCell.RefreshNumAndPrice = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local id = ((self._cellData).furnitureItem):GetID()
  local serverData = ((((self._delegate)._delegate)._furnitures)[id]).serverData
  local price = serverData.discountPrice
  local buyNum = 0
  local themeNeedNum = ((((self._delegate)._delegate)._themeInfo).furnitures)[id]
  local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(id) - (((self._delegate)._delegate)._themeInfo).haveNum * themeNeedNum
  if haveNum < ((self._delegate)._delegate)._buyNum * themeNeedNum then
    buyNum = ((self._delegate)._delegate)._buyNum * themeNeedNum - haveNum
  end
  ;
  (self._buyNum):SetText(buyNum)
  ;
  (self._price):SetText((buyNum) * price)
end

return ThemeFurnitureCell

