-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/shopitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GoodInfo = (LuaNetManager.GetBeanDef)("protocol.shop.goodinfo")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ShopTypeMap = ((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Shop
local ShopItemCell = class("ShopItemCell", Dialog)
ShopItemCell.AssetBundleName = "ui/layouts.activitystar2"
ShopItemCell.AssetName = "ActivityStar2ShopCell"
ShopItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopItemCell
  ((ShopItemCell.super).Ctor)(self, ...)
end

ShopItemCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._hard_back = self:GetChild("CellBack/CellBackHard")
  self._back = self:GetChild("CellBack/Back")
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._priceIcon = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._cannotBuy = self:GetChild("CellBack/SoldOut")
  self._cannotBuy_soldOut = self:GetChild("CellBack/SoldOut/Image")
  self._cannotBuy_own = self:GetChild("CellBack/SoldOut/Txt")
  ;
  (self._cannotBuy_own):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2128))
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CStringRes, GoodInfo, ShopTypeMap
  self._data = data
  local item = (Item.Create)(data.itemId)
  local imageRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", item:GetName())
  str = (string.gsub)(str, "%$parameter2%$", data.itemSum)
  ;
  (self._name):SetText(str)
  item = (Item.Create)(data.moneyType)
  imageRecord = item:GetIcon()
  ;
  (self._priceIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._priceNum):SetText(tostring(data.discountPrice))
  if data.goodRemain == 0 then
    (self._cannotBuy):SetActive(true)
    ;
    (self._cannotBuy_soldOut):SetActive(true)
    ;
    (self._cannotBuy_own):SetActive(false)
    ;
    (self._num):SetText(0)
  else
    if data.status == GoodInfo.OVER_LIMIT then
      (self._cannotBuy):SetActive(true)
      ;
      (self._cannotBuy_soldOut):SetActive(false)
      ;
      (self._cannotBuy_own):SetActive(true)
    else
      ;
      (self._cannotBuy):SetActive(false)
    end
    if data.goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      ;
      (self._num):SetText(tostring(data.goodRemain))
    end
  end
  if not data.beginTime or not data.endTime or data.beginTime == 0 or data.endTime == 0 then
    (self._limit):SetActive(false)
  else
    ;
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(data.endTime))
  end
  ;
  (self._hard_back):SetActive(((self._delegate)._delegate)._selectShopId == ShopTypeMap.Hard)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ShopItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : GoodInfo, _ENV
  if (self._data).goodRemain == 0 or (self._data).status == GoodInfo.OVER_LIMIT then
    return 
  end
  ;
  ((DialogManager.CreateSingletonDialog)("shop.itembuydialog")):SetData(self._data, ((self._delegate)._delegate)._selectShopId)
end

return ShopItemCell

