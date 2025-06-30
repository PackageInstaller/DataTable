-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/shopgoodscellhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local ShopGoodsCellHelper = class("ShopGoodsCellHelper")
local RoleTypeId = 27
ShopGoodsCellHelper.Ctor = function(self, rootElement)
  -- function num : 0_0 , upvalues : _ENV
  self._rootElement = rootElement
  self._itemName = (self._rootElement):FindChild("CellBack/ItemName")
  self._itemIcon = (self._rootElement):FindChild("CellBack/Item")
  self._charIcon = (self._rootElement):FindChild("CellBack/Char")
  self._goodsNum = (self._rootElement):FindChild("CellBack/Num/Num")
  self._limit = (self._rootElement):FindChild("CellBack/Limit")
  self._limitTxt = (self._rootElement):FindChild("CellBack/Limit/Limit")
  self._soldOutTag = (self._rootElement):FindChild("CellBack/SoldOut")
  self._freeTag = (self._rootElement):FindChild("CellBack/Sale")
  self._priceOnSale = (self._rootElement):FindChild("CellBack/Price")
  self._priceOnSaleOri = (self._rootElement):FindChild("CellBack/Price/TextDelete")
  self._priceOnSaleNow = (self._rootElement):FindChild("CellBack/Price/Text")
  self._priceOnSaleRmbImage = (self._rootElement):FindChild("CellBack/Price/Rmt")
  self._priceOnSaleCurrencyImage = (self._rootElement):FindChild("CellBack/Price/Image")
  self._priceNormal = (self._rootElement):FindChild("CellBack/Price2")
  self._priceNormalNow = (self._rootElement):FindChild("CellBack/Price2/Text")
  self._priceNormalRmbImag = (self._rootElement):FindChild("CellBack/Price2/Rmt")
  self._priceNormalCurrencyImage = (self._rootElement):FindChild("CellBack/Price2/Image")
  self._priceFree = (self._rootElement):FindChild("CellBack/PriceFree")
  self._priceFreeText = (self._rootElement):FindChild("CellBack/PriceFree/Text")
  self._itemNameBack = (self._rootElement):FindChild("CellBack/ItemNameBack")
  self._redDot = (self._rootElement):FindChild("CellBack/Dot")
  ;
  (self._priceOnSale):Subscribe_PointerClickEvent(self.OnBuyClicked, self)
  ;
  (self._priceNormal):Subscribe_PointerClickEvent(self.OnBuyClicked, self)
  ;
  (self._priceFree):Subscribe_PointerClickEvent(self.OnBuyClicked, self)
  ;
  (self._rootElement):Subscribe_PointerClickEvent(self.OnBuyClicked, self)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  ;
  (self._priceFreeText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1848))
end

ShopGoodsCellHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ShopGoodsCellHelper.RefreshCell = function(self, data, shopID, indexNum)
  -- function num : 0_2 , upvalues : _ENV, Item, CImagePathTable, CSugarShopOpen, RoleTypeId, CRoleItem, RoleConfigTable, CNPCShape
  self._data = data
  self._shopID = shopID
  self._indexNum = indexNum
  local item = nil
  if type((self._data).itemId) == "table" then
    item = (Item.Create)((self._data).giftId)
    ;
    (self._itemName):SetText((TextManager.GetText)((self._data).goodName))
    ;
    (self._charIcon):SetActive(false)
    ;
    (self._itemIcon):SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder((self._data).pictureId)
    ;
    (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      item = (Item.Create)((CSugarShopOpen:GetRecorder((self._data).goodId)).Items)
      ;
      (self._itemName):SetText(item:GetName())
      local isRole = item:GetItemTypeId() == RoleTypeId
      ;
      (self._charIcon):SetActive(isRole)
      ;
      (self._itemIcon):SetActive(not isRole)
      if isRole then
        local roleid = (CRoleItem:GetRecorder((self._data).itemId)).roleid
        local roleRecorder = RoleConfigTable:GetRecorder(roleid)
        local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
        local imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
        ;
        (self._charIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      else
        local imageRecord = item:GetIcon()
        ;
        (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      if not (self._data).beginTime or not (self._data).endTime or (self._data).beginTime == 0 or (self._data).endTime == 0 then
        (self._limit):SetActive(false)
      else
        (self._limit):SetActive(true)
        ;
        (self._limitTxt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._data).endTime))
      end
      self._goodType = (self._data).moneyType > 35000
      local noDiscount = (self._data).discount == -1 or (self._data).discount == 10
      if noDiscount and (self._data).discountPrice > 0 then
        (self._priceOnSale):SetActive(false)
        ;
        (self._priceNormal):SetActive(true)
        ;
        (self._priceFree):SetActive(false)
        ;
        (self._priceNormalNow):SetText((SdkManager.GetPrice)((self._data).discountPrice))
        ;
        (self._freeTag):SetActive(false)
        ;
        (self._redDot):SetActive(false)
      elseif noDiscount and (self._data).discountPrice == 0 then
        (self._priceOnSale):SetActive(false)
        ;
        (self._priceNormal):SetActive(false)
        ;
        (self._priceFree):SetActive(true)
        ;
        (self._freeTag):SetActive(true)
        ;
        (self._redDot):SetActive((self._data).goodRemain ~= 0)
      elseif not noDiscount then
        (self._priceOnSale):SetActive(true)
        ;
        (self._priceNormal):SetActive(false)
        ;
        (self._priceFree):SetActive(false)
        ;
        (self._priceOnSaleNow):SetText((SdkManager.GetPrice)((self._data).discountPrice))
        ;
        (self._priceOnSaleOri):SetText((SdkManager.GetPrice)((self._data).price))
        ;
        (self._freeTag):SetActive(false)
        ;
        (self._redDot):SetActive(false)
      else
        LogErrorFormat("ShopGoodsCellHelper", "The discount and discountPrice data error! [discount=%d, discountPrice=%d]", (self._data).discount, (self._data).discountPrice)
      end
      if (self._data).goodRemain == 0 then
        (self._soldOutTag):SetActive(true)
        ;
        (self._goodsNum):SetText(0)
        ;
        (self._itemNameBack):SetActive(false)
        ;
        (self._priceOnSale):SetActive(false)
        ;
        (self._priceNormal):SetActive(false)
        ;
        (self._priceFree):SetActive(false)
      else
        (self._soldOutTag):SetActive(false)
        if (self._data).goodRemain == -1 then
          (self._goodsNum):SetText(tostring(99 .. "+"))
        else
          (self._goodsNum):SetText((NumberManager.GetShowNumber)((self._data).goodRemain))
        end
        ;
        (self._itemNameBack):SetActive(true)
      end
      ;
      (self._priceOnSaleRmbImage):SetActive((self._data).moneyType <= 35000)
      ;
      (self._priceOnSaleCurrencyImage):SetActive((self._data).moneyType > 35000)
      ;
      (self._priceNormalRmbImag):SetActive((self._data).moneyType <= 35000)
      ;
      (self._priceNormalCurrencyImage):SetActive((self._data).moneyType > 35000)
      if (self._data).moneyType > 35000 then
        item = (Item.Create)((self._data).moneyType)
        local imageRecord = item:GetIcon()
        ;
        (self._priceOnSaleCurrencyImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._priceNormalCurrencyImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      -- DECOMPILER ERROR: 22 unprocessed JMP targets
    end
  end
end

ShopGoodsCellHelper.OnBuyClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self._data).goodRemain ~= 0 then
    ((DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.itembuydialog")):SetData(self._data, self._shopID)
  end
end

return ShopGoodsCellHelper

