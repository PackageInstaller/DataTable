local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local FurnitureCell = class("FurnitureCell", Dialog)
FurnitureCell.AssetBundleName = "ui/layouts.yard"
FurnitureCell.AssetName = "FurnitureItemCell"

function FurnitureCell:Ctor(...)
  FurnitureCell.super.Ctor(self, ...)
end

function FurnitureCell:OnCreate()
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
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function FurnitureCell:OnDestroy()
end

function FurnitureCell:RefreshCell(data)
  local furnitureId = data.serverData.itemId
  local furnitureItem = FurnitureItem.Create(furnitureId)
  local imageRecord = furnitureItem:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(furnitureItem:GetName())
  imageRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  self._comfortIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._comfortNum:SetText(furnitureItem:GetComfort())
  if self._delegate._dialogName == "courtcabin.shop.themedetaildialog" then
    local totalNeedNum = self._delegate._themeInfo.furnitures[furnitureId]
    local needNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) - self._delegate._themeInfo.haveNum * totalNeedNum
    self._num:SetText(needNum .. "/" .. totalNeedNum)
  else
    local haveNum = data.serverData.maxRemain - data.serverData.goodRemain
    self._num:SetText(haveNum .. "/" .. data.serverData.maxRemain)
  end
  self._new:SetActive(CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.CabinGoodsType.Furniture .. tostring(data.serverData.goodId), DataCommon.CabinGoodsStatus.Default) == DataCommon.CabinGoodsStatus.NewAdd)
  self._description:SetText(furnitureItem:GetDestribe())
  local costCurrencyItem = Item.Create(data.serverData.moneyType)
  imageRecord = costCurrencyItem:GetIcon()
  self._costCurrencyIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._costCurrencyPrice:SetText(data.serverData.discountPrice)
  self._soldOut:SetActive(data.serverData.goodRemain == 0)
end

function FurnitureCell:OnCellClicked()
  if self._cellData.serverData.goodRemain > 0 then
    DialogManager.CreateSingletonDialog("courtcabin.shop.buyfurnituredialog"):SetData(self._cellData.serverData.goodId)
    NekoData.BehaviorManager.BM_Shop:SetChecked(DataCommon.CabinGoodsType.Furniture, self._cellData.serverData.goodId)
  end
end

function FurnitureCell:OnEvent(eventName, args)
  if eventName == "FurnitureChecked" and args == self._cellData.serverData.goodId then
    self._new:SetActive(CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. DataCommon.CabinGoodsType.Furniture .. tostring(args), DataCommon.CabinGoodsStatus.Default) == DataCommon.CabinGoodsStatus.NewAdd)
  end
end

return FurnitureCell
