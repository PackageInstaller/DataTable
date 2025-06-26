-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprecommendpagedetailcell3.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CMonthCard = (BeanManager.GetTableByName)("topup.cmonthcard")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ShopRecommendPageDetailCell3 = class("ShopRecommendPageDetailCell3", Dialog)
ShopRecommendPageDetailCell3.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDetailCell3.AssetName = "RecommendShopPage5"
ShopRecommendPageDetailCell3.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRecommendPageDetailCell3
  ((ShopRecommendPageDetailCell3.super).Ctor)(self, ...)
  self._itemsData1 = {}
  self._itemsData2 = {}
end

ShopRecommendPageDetailCell3.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._animationPanel = self._rootWindow
  self._itemsPanel1 = self:GetChild("Cell1/Frame1")
  self._itemsPanel2 = self:GetChild("Cell1/Frame2")
  self._price = self:GetChild("Cell1/Text")
  self._price2 = self:GetChild("Cell1/Sale/TextDelete")
  self._sale = self:GetChild("Cell1/Sale/Sale")
  self._time = self:GetChild("Cell1/Sale/Time")
  self._timeT = self:GetChild("Cell1/Sale/Time/TimeTxt")
  self._itemsFrame1 = (TableFrame.Create)(self._itemsPanel1, self, false, false, false)
  self._itemsFrame2 = (TableFrame.Create)(self._itemsPanel2, self, false, false, false)
  self._buyBtn = self:GetChild("Cell1/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnClick, self)
end

ShopRecommendPageDetailCell3.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemsFrame1):Destroy()
  ;
  (self._itemsFrame2):Destroy()
end

ShopRecommendPageDetailCell3.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CMonthCard
  if data then
    for _,value in pairs(data) do
      if value.goodType == 16 then
        self._data = value
        break
      end
    end
  end
  do
    if self._data then
      (self._price):SetText((SdkManager.GetPrice)((self._data).discountPrice))
      if (self._data).discount == -1 or (self._data).discount == 10 then
        (self._price2):SetActive(false)
        ;
        (self._sale):SetActive(false)
      else
        ;
        (self._price2):SetActive(true)
        ;
        (self._price2):SetText((SdkManager.GetPrice)((self._data).price))
        ;
        (self._sale):SetActive(true)
        local imageRecord = ((NekoData.BehaviorManager).BM_Shop):GetDiscountAsset((self._data).discount)
        ;
        (self._sale):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      end
      do
        if (self._data).endTime and (self._data).endTime > 0 then
          (self._time):SetActive(true)
          ;
          (self._timeT):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._data).endTime))
        else
          ;
          (self._time):SetActive(false)
        end
        self._itemsData1 = {}
        self._itemsData2 = {}
        local recorder = CMonthCard:GetRecorder(1)
        for i,v in ipairs(recorder.items) do
          local temp = {}
          temp.id = v
          temp.count = (recorder.nums)[i]
          ;
          (table.insert)(self._itemsData1, temp)
        end
        -- DECOMPILER ERROR at PC123: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self._itemsData2).id = recorder.itemShow
        -- DECOMPILER ERROR at PC126: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self._itemsData2).count = recorder.numShow
        ;
        (self._itemsFrame1):ReloadAllCell()
        ;
        (self._itemsFrame2):ReloadAllCell()
      end
    end
  end
end

ShopRecommendPageDetailCell3.OnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self._delegate)._delegate):SetJumpMonthCardFlag(2)
  ;
  ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(50)
end

ShopRecommendPageDetailCell3.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._itemsFrame1 then
    return #self._itemsData1
  else
    return 1
  end
end

ShopRecommendPageDetailCell3.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "shop.recommendshoppageitemcell"
end

ShopRecommendPageDetailCell3.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._itemsFrame1 then
    return (self._itemsData1)[index]
  else
    return self._itemsData2
  end
end

ShopRecommendPageDetailCell3.PlayShowAnimation = function(self)
  -- function num : 0_8
  (self._animationPanel):PlayAnimation("RecommendShopPage1")
end

return ShopRecommendPageDetailCell3

