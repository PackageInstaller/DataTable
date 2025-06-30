-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/children/childrenshopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local ChildrenShopGoodsCell = class("ChildrenShopGoodsCell", Dialog)
ChildrenShopGoodsCell.AssetBundleName = "ui/layouts.activitychildrensday"
ChildrenShopGoodsCell.AssetName = "ActivityChildrensDayItemShopCell"
ChildrenShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChildrenShopGoodsCell
  ((ChildrenShopGoodsCell.super).Ctor)(self, ...)
end

ChildrenShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._price = self:GetChild("CellBack/Price")
  self._priceImg = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ChildrenShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChildrenShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CSugarShopOpen, Item
  self._data = data
  self._shopId = (self._delegate)._shopId
  self._state = 1
  if (self._data).isrmt == 0 then
    self._state = 1
  else
    self._state = 2
  end
  local imageRecord = nil
  if (self._data).isrmt == 1 then
    if not CImagePathTable:GetRecorder(((self._data).iteminfo).pictureId) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name):SetText((TextManager.GetText)(((self._data).iteminfo).goodName))
  else
    local good = CSugarShopOpen:GetRecorder(((self._data).iteminfo).goodId)
    local item = (Item.Create)(good.Items)
    imageRecord = item:GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._name):SetText(item:GetName())
  end
  do
    if ((self._data).iteminfo).goodRemain == 0 then
      (self._soldOut):SetActive(true)
      ;
      (self._num):SetText(0)
    else
      ;
      (self._soldOut):SetActive(false)
      if ((self._data).iteminfo).goodRemain == -1 then
        (self._num):SetText(tostring(99 .. "+"))
      else
        ;
        (self._num):SetText(tostring(((self._data).iteminfo).goodRemain))
      end
    end
    if not ((self._data).iteminfo).beginTime or not ((self._data).iteminfo).endTime or ((self._data).iteminfo).beginTime == 0 or ((self._data).iteminfo).endTime == 0 then
      (self._limit):SetActive(false)
    else
      ;
      (self._limit):SetActive(true)
      ;
      (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(((self._data).iteminfo).endTime))
    end
    ;
    (self._priceNum):SetText(tostring(((self._data).iteminfo).discountPrice))
    if ((self._data).iteminfo).discountPrice == 0 then
      (self._price):SetActive(false)
    end
  end
end

ChildrenShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).iteminfo).goodRemain ~= 0 then
    if (self._data).isrmt == 0 then
      ((DialogManager.CreateSingletonDialog)("activity.children.shopbuydialogfree")):SetData((self._data).iteminfo, self._shopId)
    else
      ;
      ((DialogManager.CreateSingletonDialog)("activity.children.shopbuydialog6")):SetData((self._data).iteminfo, self._shopId)
    end
  end
end

return ChildrenShopGoodsCell

