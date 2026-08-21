-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/furniturecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local FurnitureCell = class("FurnitureCell", Dialog)
FurnitureCell.AssetBundleName = "ui/layouts.yard"
FurnitureCell.AssetName = "FurnitureItemCell"
FurnitureCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureCell
  ((FurnitureCell.super).Ctor)(self, ...)
end

FurnitureCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Panel/Item/Item")
  self._name = self:GetChild("Panel/Item/NameBack/Name")
  self._comfortIcon = self:GetChild("Panel/Item/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Panel/Item/Comfortable/ComfortableNum")
  self._num = self:GetChild("Panel/Item/Num/Num")
  self._new = self:GetChild("Panel/New")
  self._description = self:GetChild("Panel/Detail")
  self._costCurrencyIcon = self:GetChild("Panel/Icon")
  self._costCurrencyPrice = self:GetChild("Panel/Price")
  self._soldOut = self:GetChild("Panel/SoldOut")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

FurnitureCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : FurnitureItem, _ENV, Item
  local furnitureId = (data.serverData).itemId
  local furnitureItem = (FurnitureItem.Create)(furnitureId)
  local imageRecord = furnitureItem:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText(furnitureItem:GetName())
  imageRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  ;
  (self._comfortIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._comfortNum):SetText(furnitureItem:GetComfort())
  if (self._delegate)._dialogName == "courtcabin.shop.themedetaildialog" then
    local totalNeedNum = (((self._delegate)._themeInfo).furnitures)[furnitureId]
    local needNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) - ((self._delegate)._themeInfo).haveNum * totalNeedNum
    ;
    (self._num):SetText(needNum .. "/" .. totalNeedNum)
  else
    do
      do
        local haveNum = (data.serverData).maxRemain - (data.serverData).goodRemain
        ;
        (self._num):SetText(haveNum .. "/" .. (data.serverData).maxRemain)
        ;
        (self._new):SetActive((((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Furniture .. tostring((data.serverData).goodId), (DataCommon.CabinGoodsStatus).Default) == (DataCommon.CabinGoodsStatus).NewAdd)
        ;
        (self._description):SetText(furnitureItem:GetDestribe())
        local costCurrencyItem = (Item.Create)((data.serverData).moneyType)
        imageRecord = costCurrencyItem:GetIcon()
        ;
        (self._costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._costCurrencyPrice):SetText((data.serverData).discountPrice)
        ;
        (self._soldOut):SetActive((data.serverData).goodRemain == 0)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

FurnitureCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._cellData).serverData).goodRemain > 0 then
    ((DialogManager.CreateSingletonDialog)("courtcabin.shop.buyfurnituredialog")):SetData(((self._cellData).serverData).goodId)
    ;
    ((NekoData.BehaviorManager).BM_Shop):SetChecked((DataCommon.CabinGoodsType).Furniture, ((self._cellData).serverData).goodId)
  end
end

FurnitureCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : _ENV
  if (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Furniture .. tostring(args), (DataCommon.CabinGoodsStatus).Default) ~= (DataCommon.CabinGoodsStatus).NewAdd then
    (self._new):SetActive(eventName ~= "FurnitureChecked" or args ~= ((self._cellData).serverData).goodId)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return FurnitureCell

