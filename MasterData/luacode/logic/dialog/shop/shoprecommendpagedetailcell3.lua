local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CMonthCard = BeanManager.GetTableByName("topup.cmonthcard")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopRecommendPageDetailCell3 = class("ShopRecommendPageDetailCell3", Dialog)
ShopRecommendPageDetailCell3.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDetailCell3.AssetName = "RecommendShopPage5"

function ShopRecommendPageDetailCell3:Ctor(...)
  ShopRecommendPageDetailCell3.super.Ctor(self, ...)
  self._itemsData1 = {}
  self._itemsData2 = {}
end

function ShopRecommendPageDetailCell3:OnCreate()
  self._animationPanel = self._rootWindow
  self._itemsPanel1 = self:GetChild("Cell1/Frame1")
  self._itemsPanel2 = self:GetChild("Cell1/Frame2")
  self._price = self:GetChild("Cell1/Text")
  self._price2 = self:GetChild("Cell1/Sale/TextDelete")
  self._sale = self:GetChild("Cell1/Sale/Sale")
  self._time = self:GetChild("Cell1/Sale/Time")
  self._timeT = self:GetChild("Cell1/Sale/Time/TimeTxt")
  self._itemsFrame1 = TableFrame.Create(self._itemsPanel1, self, false, false, false)
  self._itemsFrame2 = TableFrame.Create(self._itemsPanel2, self, false, false, false)
  self._buyBtn = self:GetChild("Cell1/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnClick, self)
end

function ShopRecommendPageDetailCell3:OnDestroy()
  self._itemsFrame1:Destroy()
  self._itemsFrame2:Destroy()
end

function ShopRecommendPageDetailCell3:RefreshCell(data)
  if data then
    for _, value in pairs(data) do
      if value.goodType == 16 then
        self._data = value
        break
      end
    end
  end
  if self._data then
    self._price:SetText(SdkManager.GetPrice(self._data.discountPrice))
    if self._data.discount == -1 or self._data.discount == 10 then
      self._price2:SetActive(false)
      self._sale:SetActive(false)
    else
      self._price2:SetActive(true)
      self._price2:SetText(SdkManager.GetPrice(self._data.price))
      self._sale:SetActive(true)
      local imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(self._data.discount)
      self._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    if self._data.endTime and self._data.endTime > 0 then
      self._time:SetActive(true)
      self._timeT:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._data.endTime))
    else
      self._time:SetActive(false)
    end
  else
  end
  self._itemsData1 = {}
  self._itemsData2 = {}
  local recorder = CMonthCard:GetRecorder(1)
  for i, v in ipairs(recorder.items) do
    local temp = {}
    temp.id = v
    temp.count = recorder.nums[i]
    table.insert(self._itemsData1, temp)
  end
  self._itemsData2.id = recorder.itemShow
  self._itemsData2.count = recorder.numShow
  self._itemsFrame1:ReloadAllCell()
  self._itemsFrame2:ReloadAllCell()
end

function ShopRecommendPageDetailCell3:OnClick()
  self._delegate._delegate:SetJumpMonthCardFlag(2)
  NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(50)
end

function ShopRecommendPageDetailCell3:NumberOfCell(frame)
  if frame == self._itemsFrame1 then
    return #self._itemsData1
  else
    return 1
  end
end

function ShopRecommendPageDetailCell3:CellAtIndex(frame, index)
  return "shop.recommendshoppageitemcell"
end

function ShopRecommendPageDetailCell3:DataAtIndex(frame, index)
  if frame == self._itemsFrame1 then
    return self._itemsData1[index]
  else
    return self._itemsData2
  end
end

function ShopRecommendPageDetailCell3:PlayShowAnimation()
  self._animationPanel:PlayAnimation("RecommendShopPage1")
end

return ShopRecommendPageDetailCell3
