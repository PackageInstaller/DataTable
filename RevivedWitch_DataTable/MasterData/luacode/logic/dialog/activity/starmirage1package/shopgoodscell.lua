-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1package/shopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activitystar2"
ShopGoodsCell.AssetName = "ActivityStar2OtherShopCell"
local SkinTypeId = 91
ShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGoodsCell
  ((ShopGoodsCell.super).Ctor)(self, ...)
end

ShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._back = {self:GetChild("CellBack/BackG"), self:GetChild("CellBack/BackR"), self:GetChild("CellBack/BackB")}
  self._rmtImage2 = self:GetChild("CellBack/Price2/Rmt")
  self._price2 = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._price2Free = self:GetChild("CellBack/Price2/FreeText")
  self._textRmt = self:GetChild("CellBack/Price2/RmtText")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self._sale = self:GetChild("CellBack/Sale")
  self._redDot = self:GetChild("CellBack/Dot")
  self._itemNameBack = self:GetChild("CellBack/ItemNameBack")
  self._fashionBtn = self:GetChild("CellBack/FashionBtn")
  self:GetChild("CellBack/FashionBtn/Text")
  ;
  (self._fashionBtn):Subscribe_PointerClickEvent(self.OnFashionBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, SkinTypeId, CSkinItem, RoleSkin, CImagePathTable, CSugarShopOpen, CCurrencySymbol, CStringRes
  self._data = data
  self._shopId = (self._delegate)._shopId
  self._state = 1
  self._skinId = nil
  for i = 1, 3 do
    ((self._back)[i]):SetActive(false)
  end
  ;
  (self._fashionBtn):SetActive(false)
  if (self._data).isrmt == 0 then
    self._state = 1
  else
    local isSkin = false
    local skillId = nil
    for _,id in ipairs(((self._data).iteminfo).itemId) do
      local item = (Item.Create)(id)
      isSkin = item:GetItemTypeId() == SkinTypeId
      if isSkin then
        self._skinId = id
        break
      end
    end
    if self._skinId then
      (self._fashionBtn):SetActive(true)
      local skinIDCfg = CSkinItem:GetRecorder(self._skinId)
      local skinItem = (RoleSkin.Create)(skinIDCfg.Skinid)
      self._hasSkin = ((NekoData.BehaviorManager).BM_SkinList):IsUnLockSkin(skinItem:GetSkinId())
      self._state = 3
    else
      self._state = 2
    end
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
  if not ((self._data).iteminfo).beginTime or not ((self._data).iteminfo).endTime or ((self._data).iteminfo).beginTime == 0 or ((self._data).iteminfo).endTime == 0 then
    (self._limit):SetActive(false)
  else
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(((self._data).iteminfo).endTime))
  end
  ;
  (self._price2):SetActive(true)
  if (self._data).isrmt == 1 then
    if SdkManager.IsOverseas then
      (self._rmtImage2):SetActive(false)
      ;
      (self._textRmt):SetActive(true)
      ;
      (self._textRmt):SetText((CCurrencySymbol:GetRecorder(((self._data).iteminfo).moneyType)).symbol)
    else
      (self._rmtImage2):SetActive(true)
      ;
      (self._textRmt):SetActive(false)
    end
    ;
    (self._price2Img):SetActive(false)
  else
    (self._rmtImage2):SetActive(false)
    ;
    (self._textRmt):SetActive(false)
    ;
    (self._price2Img):SetActive(true)
    item = (Item.Create)(((self._data).iteminfo).moneyType)
    imageRecord = item:GetIcon()
    ;
    (self._price2Img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._price2Num):SetText(tostring((SdkManager.GetPrice)(((self._data).iteminfo).discountPrice)))
  if ((self._data).iteminfo).discountPrice == ((self._data).iteminfo).price then
    (self._sale):SetActive(false)
  else
    (self._sale):SetActive(true)
    imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset(((self._data).iteminfo).discount)
    ;
    (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local isFree = ((self._data).iteminfo).discountPrice == 0
  ;
  (self._price2Free):SetActive(isFree)
  ;
  (self._price2Num):SetActive(not isFree)
  if ((self._data).iteminfo).discountPrice == 0 then
    (self._price2Free):SetText((TextManager.GetText)((CStringRes:GetRecorder(1848)).msgTextID))
    ;
    (self._price2Img):SetActive(false)
  elseif self._skinId and self._hasSkin then
    (self._price2Num):SetText((TextManager.GetText)((CStringRes:GetRecorder(2083)).msgTextID))
    ;
    (self._price2Img):SetActive(false)
    ;
    (self._rmtImage2):SetActive(false)
  end
  if ((self._data).iteminfo).goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(0)
    ;
    (self._price2):SetActive(false)
    ;
    (self._itemNameBack):SetActive(false)
    ;
    (self._redDot):SetActive(false)
  else
    (self._itemNameBack):SetActive(true)
    ;
    (self._soldOut):SetActive(false)
    if ((self._data).iteminfo).goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      (self._num):SetText(tostring(((self._data).iteminfo).goodRemain))
    end
    ;
    (self._redDot):SetActive(false)
    if ((self._data).iteminfo).discountPrice == 0 then
      (self._redDot):SetActive(true)
    end
  end
  ;
  ((self._back)[self._state]):SetActive(true)
  -- DECOMPILER ERROR: 24 unprocessed JMP targets
end

ShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item, SkinTypeId, CSkinItem, RoleSkin
  if ((self._data).iteminfo).goodRemain ~= 0 then
    if (self._data).isrmt == 0 then
      ((DialogManager.CreateSingletonDialog)("activity.children.shopbuydialogfree")):SetData((self._data).iteminfo, self._shopId)
    else
      if ((self._data).iteminfo).optionId ~= 0 then
        ((DialogManager.CreateSingletonDialog)("activity.springfestival.itembuydialog")):SetData((self._data).iteminfo, self._shopId)
        return 
      end
      local item = nil
      local isSkin = false
      local skinIDCfg = nil
      for _,id in ipairs(((self._data).iteminfo).itemId) do
        item = (Item.Create)(id)
        isSkin = item:GetItemTypeId() == SkinTypeId
        if isSkin then
          skinIDCfg = CSkinItem:GetRecorder(id)
          break
        end
      end
      if isSkin and skinIDCfg then
        local skinItem = (RoleSkin.Create)(skinIDCfg.Skinid)
        if ((NekoData.BehaviorManager).BM_SkinList):IsUnLockSkin(skinItem:GetSkinId()) then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100486)
          return 
        end
        ;
        ((DialogManager.CreateSingletonDialog)("activity.children.shopbuydialogskin")):SetData((self._data).iteminfo, self._shopId)
      else
        ((DialogManager.CreateSingletonDialog)("activity.children.shopbuydialog6")):SetData((self._data).iteminfo, self._shopId)
      end
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

return ShopGoodsCell

