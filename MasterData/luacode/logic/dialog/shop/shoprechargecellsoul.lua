local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ShopRechargeCellSoul = class("ShopRechargeCellSoul", Dialog)
ShopRechargeCellSoul.AssetBundleName = "ui/layouts.baseshop"
ShopRechargeCellSoul.AssetName = "RechargeShopCellSoul"

function ShopRechargeCellSoul:Ctor(...)
  ShopRechargeCellSoul.super.Ctor(self, ...)
end

function ShopRechargeCellSoul:OnCreate()
  self._effect = self:GetChild("CellBack/Effect")
  self._img = self:GetChild("CellBack/MonthCardImg")
  self._name = self:GetChild("CellBack/ItemName")
  self._giveBoard = self:GetChild("CellBack/Give")
  self._giveTxt = self:GetChild("CellBack/Give/Text")
  self._giveImage = self:GetChild("CellBack/Give/Image")
  self._giveNum = self:GetChild("CellBack/Give/Num")
  self._giveTxt:SetText(TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1176).msgTextID))
  self._priceType = self:GetChild("CellBack/Price/RMB")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._show = {}
  for i = 1, 4 do
    self._show[i] = {}
    if i == 1 then
      self._show[i].image = self:GetChild("CellBack/Show/Image")
      self._show[i].num = self:GetChild("CellBack/Show/Text")
      self._show[i].board = self:GetChild("CellBack/Show")
    else
      self._show[i].image = self:GetChild("CellBack/Show" .. i .. "/Image")
      self._show[i].num = self:GetChild("CellBack/Show" .. i .. "/Text")
      self._show[i].board = self:GetChild("CellBack/Show" .. i)
    end
  end
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopRechargeCellSoul:OnDestroy()
  if self._visiualEffectHandler then
    self._effect:ReleaseEffect(self._visiualEffectHandler)
    self._visiualEffectHandler = nil
  end
end

function ShopRechargeCellSoul:RefreshCell(data)
  self._data = data
  self._soldOut:SetActive(self._data.iteminfo.goodRemain == 0)
  if self._data.iteminfo.moneyType ~= DataCommon.DiamodID then
    LogErrorFormat("ShopRechargeCellSoul", "灵魂现在只可用钻石购买，发现其它的货币类型！[goodId=%d, moneyType=%d]", self._data.iteminfo.goodId, self._data.iteminfo.moneyType)
  end
  if self._data.iteminfo.itemSum[2] and 0 < self._data.iteminfo.itemSum[2] then
    self._giveBoard:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(10716)
    self._giveImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._giveNum:SetText(self._data.iteminfo.itemSum[2])
  else
    self._giveBoard:SetActive(false)
  end
  self._priceNum:SetText(self._data.iteminfo.discountPrice)
  local imageRecord = CImagePathTable:GetRecorder(self._data.iteminfo.pictureId)
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(self._data.iteminfo.goodName))
  imageRecord = CImagePathTable:GetRecorder(10716)
  for i = 1, 4 do
    local le = string.len(tostring(self._data.iteminfo.itemSum[1]))
    self._show[i].board:SetActive(le == i)
    self._show[i].num:SetText(self._data.iteminfo.itemSum[1])
    self._show[i].image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  if self._visiualEffectHandler then
    self._effect:ReleaseEffect(self._visiualEffectHandler)
    self._visiualEffectHandler = nil
  end
  local effectID = self._data.iteminfo.visiualEffect
  if effectID ~= 0 then
    self._visiualEffectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(effectID))
  end
end

function ShopRechargeCellSoul:OnCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("shop.itembuy2dialog")
  if dialog then
    dialog:SetData(self._data.iteminfo, self._delegate._delegate._selectShopID)
  end
end

return ShopRechargeCellSoul
