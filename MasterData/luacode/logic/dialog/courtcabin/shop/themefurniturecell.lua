local Item = require("logic.manager.experimental.types.item")
local ThemeFurnitureCell = class("ThemeFurnitureCell", Dialog)
ThemeFurnitureCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureCell.AssetName = "FurnitureThemeBuyFrameCell"

function ThemeFurnitureCell:Ctor(...)
  ThemeFurnitureCell.super.Ctor(self, ...)
end

function ThemeFurnitureCell:OnCreate()
  self._name = self:GetChild("Name")
  self._buyNum = self:GetChild("Num")
  self._icon = self:GetChild("Icon")
  self._price = self:GetChild("Price")
end

function ThemeFurnitureCell:OnDestroy()
end

function ThemeFurnitureCell:RefreshCell(data)
  local id = data.furnitureItem:GetID()
  if self._delegate._delegate._furnitures[id] then
    local serverData = self._delegate._delegate._furnitures[id].serverData
    if self._delegate._cellData.type == self._delegate._delegate._haveFurnitureType then
      self._icon:SetActive(false)
      self._price:SetActive(false)
      local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(id) - self._delegate._delegate._themeInfo.haveNum * self._delegate._delegate._themeInfo.furnitures[id]
      self._buyNum:SetText(haveNum)
    else
      self._icon:SetActive(true)
      self._price:SetActive(true)
      local costCurrencyItem = Item.Create(serverData.moneyType)
      local imageRecord = costCurrencyItem:GetIcon()
      self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self:RefreshNumAndPrice()
    end
    self._name:SetText(data.furnitureItem:GetName())
  else
    local b = 1
  end
end

function ThemeFurnitureCell:RefreshNumAndPrice()
  local id = self._cellData.furnitureItem:GetID()
  local serverData = self._delegate._delegate._furnitures[id].serverData
  local price = serverData.discountPrice
  local buyNum = 0
  local themeNeedNum = self._delegate._delegate._themeInfo.furnitures[id]
  local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(id) - self._delegate._delegate._themeInfo.haveNum * themeNeedNum
  if haveNum < self._delegate._delegate._buyNum * themeNeedNum then
    buyNum = self._delegate._delegate._buyNum * themeNeedNum - haveNum
  end
  self._buyNum:SetText(buyNum)
  self._price:SetText(buyNum * price)
end

return ThemeFurnitureCell
