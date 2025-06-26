-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shopgeneralcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local RoleTypeId = 27
local EmojiTypeId = 106
local ShopGeneralCell = class("ShopGeneralCell", Dialog)
ShopGeneralCell.AssetBundleName = "ui/layouts.baseshop"
ShopGeneralCell.AssetName = "GeneralShopCell"
ShopGeneralCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGeneralCell
  ((ShopGeneralCell.super).Ctor)(self, ...)
end

ShopGeneralCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("CellBack/Item")
  self._img_char = self:GetChild("CellBack/Char")
  self._name = self:GetChild("CellBack/ItemName")
  self._back = self:GetChild("CellBack/Back")
  self._price = self:GetChild("CellBack/Price")
  self._priceImg = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._priceDeleteNum = self:GetChild("CellBack/Price/TextDelete")
  self._price2 = self:GetChild("CellBack/Price2")
  self._price2Img = self:GetChild("CellBack/Price2/Image")
  self._price2Num = self:GetChild("CellBack/Price2/Text")
  self._leftNum = self:GetChild("CellBack/Num/Num")
  self._sale = self:GetChild("CellBack/Sale")
  self._limit = self:GetChild("CellBack/Limit")
  self._limitT = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGeneralCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGeneralCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable, Item, RoleTypeId, CRoleItem, RoleConfigTable, CNPCShape, CStringRes
  self._data = data
  if (data.iteminfo).goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._leftNum):SetText(0)
  else
    ;
    (self._soldOut):SetActive(false)
    if (data.iteminfo).goodRemain == -1 then
      (self._leftNum):SetText(tostring(99 .. "+"))
    else
      ;
      (self._leftNum):SetText(tostring((data.iteminfo).goodRemain))
    end
  end
  if not (data.iteminfo).beginTime or not (data.iteminfo).endTime or (data.iteminfo).beginTime == 0 or (data.iteminfo).endTime == 0 then
    (self._limit):SetActive(false)
  else
    ;
    (self._limit):SetActive(true)
    ;
    (self._limitT):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((data.iteminfo).endTime))
  end
  if (data.iteminfo).discount == 0 then
    (self._price):SetActive(false)
    ;
    (self._price2):SetActive(true)
    ;
    (self._sale):SetActive(false)
  else
    if (data.iteminfo).discount == -1 then
      (self._price):SetActive(false)
      ;
      (self._price2):SetActive(true)
      ;
      (self._sale):SetActive(false)
    else
      ;
      (self._price):SetActive(true)
      ;
      (self._price2):SetActive(false)
      ;
      (self._sale):SetActive(true)
      local imageRecord = CImagePathTable:GetRecorder(10 - (data.iteminfo).discount + 11392)
      ;
      (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  do
    local item = ((Item.Create)((data.iteminfo).itemId))
    -- DECOMPILER ERROR at PC135: Overwrote pending register: R3 in 'AssignReg'

    local imageRecord = .end
    local isRole = item:GetItemTypeId() == RoleTypeId
    self._itemtype = item:GetItemTypeId()
    ;
    (self._img_char):SetActive(isRole)
    ;
    (self._img):SetActive(not isRole)
    if isRole then
      local roleid = (CRoleItem:GetRecorder((data.iteminfo).itemId)).roleid
      local roleRecorder = RoleConfigTable:GetRecorder(roleid)
      local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
      imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
      ;
      (self._img_char):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      imageRecord = item:GetIcon()
      ;
      (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    imageRecord = item:GetShopPinJiBackGroundImage()
    ;
    (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", item:GetName())
    str = (string.gsub)(str, "%$parameter2%$", (data.iteminfo).itemSum)
    ;
    (self._name):SetText(str)
    item = (Item.Create)((data.iteminfo).moneyType)
    imageRecord = item:GetIcon()
    if (data.iteminfo).discount == 0 or (data.iteminfo).discount == -1 then
      (self._price2Img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._price2Num):SetText(tostring((data.iteminfo).discountPrice))
    else
      (self._priceImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._priceNum):SetText(tostring((data.iteminfo).discountPrice))
      ;
      (self._priceDeleteNum):SetText(tostring((data.iteminfo).price))
    end
    if (data.iteminfo).discountPrice == (data.iteminfo).price then
      (self._priceDeleteNum):SetActive(false)
    else
      (self._priceDeleteNum):SetActive(true)
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

ShopGeneralCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : EmojiTypeId, _ENV
  if ((self._data).iteminfo).goodRemain == 0 then
    return 
  end
  if self._itemtype == EmojiTypeId then
    ((DialogManager.CreateSingletonDialog)("shop.emojibuydialog")):SetData((self._data).iteminfo, ((self._delegate)._delegate)._selectShopID)
  else
    ;
    ((DialogManager.CreateSingletonDialog)("shop.itembuydialog")):SetData((self._data).iteminfo, ((self._delegate)._delegate)._selectShopID)
  end
end

ShopGeneralCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV, CImagePathTable
  if eventName == "BuyGoodRefresh" then
    local info = (arg.goodInfo)[((self._data).iteminfo).goodId]
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    if info then
      (self._data).iteminfo = info
      if ((self._data).iteminfo).goodRemain == 0 then
        (self._soldOut):SetActive(true)
        ;
        (self._leftNum):SetText(0)
      else
        ;
        (self._soldOut):SetActive(false)
        if ((self._data).iteminfo).goodRemain == -1 then
          (self._leftNum):SetText(tostring(99 .. "+"))
        else
          ;
          (self._leftNum):SetText(tostring(((self._data).iteminfo).goodRemain))
        end
      end
      if ((self._data).iteminfo).discount == 0 then
        (self._sale):SetActive(false)
      else
        if ((self._data).iteminfo).discount == -1 then
          (self._sale):SetActive(false)
        else
          ;
          (self._sale):SetActive(true)
          local imageRecord = CImagePathTable:GetRecorder(10 - ((self._data).iteminfo).discount + 11392)
          ;
          (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        end
      end
      do
        ;
        (self._priceNum):SetText(tostring(((self._data).iteminfo).discountPrice))
        ;
        (self._priceDeleteNum):SetText(tostring(((self._data).iteminfo).price))
      end
    end
  end
end

return ShopGeneralCell

