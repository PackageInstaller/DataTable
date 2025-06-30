-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/birthday/shopgoodscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local ShopGoodsCell = class("ShopGoodsCell", Dialog)
ShopGoodsCell.AssetBundleName = "ui/layouts.activitylogin"
ShopGoodsCell.AssetName = "ActivityLoginShopCell"
local RoleTypeId = 27
ShopGoodsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopGoodsCell
  ((ShopGoodsCell.super).Ctor)(self, ...)
end

ShopGoodsCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("CellBack/Back")
  self._icon = self:GetChild("CellBack/Item")
  self._charIcon = self:GetChild("CellBack/Char")
  self._name = self:GetChild("CellBack/ItemName")
  self._priceIcon = self:GetChild("CellBack/Price/Image")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._num = self:GetChild("CellBack/Num/Num")
  self._limit = self:GetChild("CellBack/Limit")
  self._limit_txt = self:GetChild("CellBack/Limit/Limit")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ShopGoodsCell.OnDestroy = function(self)
  -- function num : 0_2
end

ShopGoodsCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, RoleTypeId, CRoleItem, RoleConfigTable, CNPCShape, CImagePathTable, _ENV, CStringRes
  self._data = data
  self._shopID = (self._delegate)._shopID
  ;
  (self._priceNum):SetText((self._data).discountPrice)
  local item = (Item.Create)((self._data).itemId)
  local imageRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local isRole = item:GetItemTypeId() == RoleTypeId
  ;
  (self._charIcon):SetActive(isRole)
  ;
  (self._icon):SetActive(not isRole)
  if isRole then
    local roleid = (CRoleItem:GetRecorder((self._data).itemId)).roleid
    local roleRecorder = RoleConfigTable:GetRecorder(roleid)
    local npcshaperecord = CNPCShape:GetRecorder(roleRecorder.shapeID)
    imageRecord = CImagePathTable:GetRecorder(npcshaperecord.skillHeadID)
    ;
    (self._charIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    imageRecord = item:GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1169)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", item:GetName())
  str = (string.gsub)(str, "%$parameter2%$", (self._data).itemSum)
  ;
  (self._name):SetText(str)
  item = (Item.Create)((self._data).moneyType)
  imageRecord = item:GetIcon()
  ;
  (self._priceIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if (self._data).goodRemain == 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._num):SetText(0)
  else
    (self._soldOut):SetActive(false)
    if (self._data).goodRemain == -1 then
      (self._num):SetText(tostring(99 .. "+"))
    else
      (self._num):SetText(tostring((self._data).goodRemain))
    end
  end
  if not (self._data).beginTime or not (self._data).endTime or (self._data).beginTime == 0 or (self._data).endTime == 0 then
    (self._limit):SetActive(false)
  else
    (self._limit):SetActive(true)
    ;
    (self._limit_txt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._data).endTime))
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

ShopGoodsCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).goodRemain ~= 0 then
    ((DialogManager.CreateSingletonDialog)("shop.itembuydialog")):SetData(self._data, self._shopID)
  end
end

return ShopGoodsCell

