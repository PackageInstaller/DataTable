local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CFlowerRechargeTable = BeanManager.GetTableByName("activity.cflowerrecharge")
local ShopRechargeCell = class("ShopRechargeCell", Dialog)
ShopRechargeCell.AssetBundleName = "ui/layouts.baseshop"
ShopRechargeCell.AssetName = "RechargeShopCell"

function ShopRechargeCell:Ctor(...)
  ShopRechargeCell.super.Ctor(self, ...)
end

function ShopRechargeCell:OnCreate()
  self._effect = self:GetChild("CellBack/Effect")
  self._back1 = self:GetChild("CellBack/Back1")
  self._back2 = self:GetChild("CellBack/Back2")
  self._img = self:GetChild("CellBack/MonthCardImg")
  self._name = self:GetChild("CellBack/ItemName")
  self._giveBoard = self:GetChild("CellBack/Give")
  self._giveBack1 = self:GetChild("CellBack/Give/Back1")
  self._giveBack2 = self:GetChild("CellBack/Give/Back2")
  self._giveTxt = self:GetChild("CellBack/Give/Text")
  self._giveImage = self:GetChild("CellBack/Give/Image")
  self._giveNum = self:GetChild("CellBack/Give/Num")
  self._priceType = self:GetChild("CellBack/Price/RMB")
  self._priceNum = self:GetChild("CellBack/Price/Text")
  self._topShow = {}
  for i = 1, 4 do
    self._topShow[i] = {}
    if i == 1 then
      self._topShow[i].image = self:GetChild("CellBack/Show/Image")
      self._topShow[i].num = self:GetChild("CellBack/Show/Text")
      self._topShow[i].board = self:GetChild("CellBack/Show")
    else
      self._topShow[i].image = self:GetChild("CellBack/Show" .. i .. "/Image")
      self._topShow[i].num = self:GetChild("CellBack/Show" .. i .. "/Text")
      self._topShow[i].board = self:GetChild("CellBack/Show" .. i)
    end
  end
  self._doubleBoard = self:GetChild("CellBack/Double")
  self._soldOut = self:GetChild("CellBack/SoldOut")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ShopRechargeCell:OnDestroy()
  if self._visiualEffectHandler then
    self._effect:ReleaseEffect(self._visiualEffectHandler)
    self._visiualEffectHandler = nil
  end
end

function ShopRechargeCell:RefreshCell(data)
  self._data = data
  self._back1:SetActive(self._data.isLastDiamondCell)
  self._back2:SetActive(not self._data.isLastDiamondCell)
  self._giveBack1:SetActive(self._data.isLastDiamondCell)
  self._giveBack2:SetActive(not self._data.isLastDiamondCell)
  self._soldOut:SetActive(self._data.iteminfo.goodRemain == 0)
  if self._data.iteminfo.goodType == 12 then
    self._doubleBoard:SetActive(0 < self._data.iteminfo.freeDiamondSum)
  elseif self._data.iteminfo.goodType == 11 then
    self._doubleBoard:SetActive(false)
  else
    self._doubleBoard:SetActive(false)
    LogErrorFormat("ShopRechargeCell", "钻石购买发现 goodType 为 11、12 之外的值！[goodType=%d]", self._data.iteminfo.goodType)
  end
  if 0 < self._data.iteminfo.freeDiamondSum then
    self._giveBoard:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(11421)
    self._giveImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._giveNum:SetText(self._data.iteminfo.freeDiamondSum)
  else
    local flowerActInfo = NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo()
    if not flowerActInfo then
      self._giveBoard:SetActive(false)
    else
      local giveFlowerCfg = CFlowerRechargeTable:GetRecorder(self._data.iteminfo.goodId)
      if not giveFlowerCfg then
        self._giveBoard:SetActive(false)
      else
        self._giveBoard:SetActive(true)
        local itemRecord = CItemAttrTable:GetRecorder(flowerActInfo.flowerId)
        local imageRecord = CImagePathTable:GetRecorder(itemRecord.icon)
        self._giveImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._giveNum:SetText(giveFlowerCfg.flowernum)
      end
    end
  end
  self._priceNum:SetText(self._data.iteminfo.discountPrice)
  local imageRecord = CImagePathTable:GetRecorder(self._data.iteminfo.pictureId)
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(self._data.iteminfo.goodName))
  imageRecord = CImagePathTable:GetRecorder(11421)
  for i = 1, 4 do
    local le = string.len(tostring(self._data.iteminfo.diamondSum))
    self._topShow[i].board:SetActive(le == i)
    self._topShow[i].num:SetText(self._data.iteminfo.diamondSum)
    self._topShow[i].image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
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

function ShopRechargeCell:OnCellClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  if protocol then
    protocol.goodId = self._data.iteminfo.goodId
    protocol:Send()
  end
end

function ShopRechargeCell:OnEvent(eventName, arg)
  if eventName == "BuyGoodRefresh" then
    if self._data.iteminfo.goodId == arg.goodInfo.goodId then
      self:RefreshCell({
        iteminfo = arg.goodInfo,
        isLastDiamondCell = self._data.isLastDiamondCell
      })
    end
  elseif eventName == "FlowerActEnd" then
    self._giveBoard:SetActive(false)
  end
end

return ShopRechargeCell
