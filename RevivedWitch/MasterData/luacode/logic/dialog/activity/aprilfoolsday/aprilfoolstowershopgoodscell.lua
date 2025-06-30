-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowershopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CClownShopRed = (BeanManager.GetTableByName)("recharge.cclownshopred")
local CClownShopBlue = (BeanManager.GetTableByName)("recharge.cclownshopblue")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local AprilFoolsTowerShopGoodsCell = class("AprilFoolsTowerShopGoodsCell", Dialog)
AprilFoolsTowerShopGoodsCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerShopGoodsCell.AssetName = "ActivityAprilFoolsStoreCell"
AprilFoolsTowerShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerShopGoodsCell
  ((AprilFoolsTowerShopGoodsCell.super).Ctor)(self, ...)
end

AprilFoolsTowerShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("CellBack/Back")
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

AprilFoolsTowerShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

AprilFoolsTowerShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CStringRes, CClownShopRed, CClownShopBlue, Item
  self._data = data
  self._shopId = (self._delegate)._shopId
  self._state = 1
  if (self._data).isrmt == 0 then
    self._state = 1
  else
    self._state = 2
  end
  local imageRecord, item = nil, nil
  if (self._data).isrmt == 1 then
    if not CImagePathTable:GetRecorder(((self._data).iteminfo).pictureId) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", (TextManager.GetText)(((self._data).iteminfo).goodName))
    str = (string.gsub)(str, "%$parameter2%$", ((self._data).iteminfo).itemSum)
    ;
    (self._name):SetText(str)
  else
    do
      local good = nil
      if self._shopId == ((DataCommon.AprilFoolsDayActivity).Shop).RedClownShopID then
        good = CClownShopRed:GetRecorder(((self._data).iteminfo).goodId)
      else
        good = CClownShopBlue:GetRecorder(((self._data).iteminfo).goodId)
      end
      item = (Item.Create)(good.Items)
      imageRecord = item:GetIcon()
      ;
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = item:GetShopPinJiBackGroundImage()
      ;
      (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      do
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", item:GetName())
        str = (string.gsub)(str, "%$parameter2%$", ((self._data).iteminfo).itemSum)
        ;
        (self._name):SetText(str)
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
        item = (Item.Create)(((self._data).iteminfo).moneyType)
        imageRecord = item:GetIcon()
        ;
        (self._priceImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        if ((self._data).iteminfo).discountPrice == 0 then
          (self._price):SetActive(false)
        end
      end
    end
  end
end

AprilFoolsTowerShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).iteminfo).goodRemain ~= 0 then
    ((DialogManager.CreateSingletonDialog)("shop.itembuydialog")):SetData((self._data).iteminfo, self._shopId)
  end
end

return AprilFoolsTowerShopGoodsCell

