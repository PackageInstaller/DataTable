-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/shopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CSugarShopOpen = (BeanManager.GetTableByName)("recharge.csugarshopopen")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local timeutils = require("logic.utils.timeutils")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activitynewyear"
ShopGoodsCell.AssetName = "ActivityNewYearShopCell"
local SkinTypeId = 91
local CellState = {G = 1, R = 2, B = 3}
ShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGoodsCell
  ((ShopGoodsCell.super).Ctor)(self, ...)
end

ShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("CellBack/Item")
  self._name = self:GetChild("CellBack/ItemName")
  self._back = {self:GetChild("CellBack/BackG"), self:GetChild("CellBack/BackR"), self:GetChild("CellBack/BackB")}
  self._rmtImage = self:GetChild("CellBack/Price/Rmt")
  self._price = self:GetChild("CellBack/Price")
  self._priceImg = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._priceDeleteNum = self:GetChild("CellBack/Price/TextDelete")
  self._textRmt = self:GetChild("CellBack/Price/RmtText")
  ;
  (self._rmtImage):SetActive(false)
  self._rmtImage2 = self:GetChild("CellBack/Price2/Rmt")
  self._price2 = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self._sale = self:GetChild("CellBack/Sale")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, SkinTypeId, CImagePathTable, CSugarShopOpen, CCurrencySymbol
  self._data = data
  self._shopId = (self._delegate)._shopId
  self._state = 1
  for i = 1, 3 do
    ((self._back)[i]):SetActive(false)
  end
  if (self._data).isrmt == 0 then
    self._state = 1
  else
    local isSkin = false
    for _,id in ipairs(((self._data).iteminfo).itemId) do
      local item = (Item.Create)(id)
      isSkin = item:GetItemTypeId() == SkinTypeId
    end
    if isSkin or isSkin then
      self._state = 3
    else
      self._state = 2
    end
  end
  ;
  ((self._back)[self._state]):SetActive(true)
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
  if ((self._data).iteminfo).goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(0)
  else
    (self._soldOut):SetActive(false)
    if ((self._data).iteminfo).goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      (self._num):SetText(tostring(((self._data).iteminfo).goodRemain))
    end
  end
  if not ((self._data).iteminfo).beginTime or not ((self._data).iteminfo).endTime or ((self._data).iteminfo).beginTime == 0 or ((self._data).iteminfo).endTime == 0 then
    (self._limit):SetActive(false)
  else
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr(((self._data).iteminfo).endTime))
  end
  ;
  (self._sale):SetActive(false)
  if ((self._data).iteminfo).discount == -1 or ((self._data).iteminfo).discount == 0 then
    (self._price):SetActive(false)
    ;
    (self._price2):SetActive(true)
  else
    (self._price):SetActive(true)
    ;
    (self._price2):SetActive(false)
  end
  if (self._data).isrmt == 1 then
    (self._rmtImage2):SetActive(true)
    ;
    (self._priceImg):SetActive(false)
    ;
    (self._price2Img):SetActive(false)
  else
    (self._rmtImage2):SetActive(false)
    ;
    (self._priceImg):SetActive(true)
    ;
    (self._price2Img):SetActive(true)
    item = (Item.Create)(((self._data).iteminfo).moneyType)
    imageRecord = item:GetIcon()
    ;
    (self._price2Img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._priceImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  -- DECOMPILER ERROR at PC287: Unhandled construct in 'MakeBoolean' P1

  if (((self._data).iteminfo).discount == 0 or ((self._data).iteminfo).discount == -1) and ((self._data).iteminfo).discountPrice ~= 0 then
    (self._price2Num):SetText(tostring(((self._data).iteminfo).discountPrice))
  end
  ;
  (self._priceNum):SetText(tostring(((self._data).iteminfo).discountPrice))
  ;
  (self._priceDeleteNum):SetText(tostring(((self._data).iteminfo).price))
  if ((self._data).iteminfo).discountPrice == ((self._data).iteminfo).price then
    (self._priceDeleteNum):SetActive(false)
  else
    (self._priceDeleteNum):SetActive(true)
  end
  if ((self._data).iteminfo).discountPrice == 0 then
    (self._price):SetActive(false)
    ;
    (self._price2):SetActive(true)
    ;
    (self._price2Img):SetActive(false)
    ;
    (self._sale):SetActive(true)
    if not CImagePathTable:GetRecorder(13529) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  ;
  (self._textRmt):SetText((CCurrencySymbol:GetRecorder(((self._data).iteminfo).moneyType)).symbol)
  -- DECOMPILER ERROR: 26 unprocessed JMP targets
end

ShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : timeutils, SpringUnlockRecord, _ENV
  self._endTime = (timeutils.GetConfigFormatTimeStamp)(SpringUnlockRecord.closeTime)
  if self._endTime < (ServerGameTimer.GetServerTime)() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100455)
    return 
  end
  if ((self._data).iteminfo).goodRemain ~= 0 then
    ((DialogManager.CreateSingletonDialog)("activity.springfestival.itembuydialog")):SetData((self._data).iteminfo, self._shopId)
  end
end

return ShopGoodsCell

