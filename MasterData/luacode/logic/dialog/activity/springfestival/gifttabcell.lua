local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GiftTabCell = class("GiftTabCell", Dialog)
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSugarShopOpen = BeanManager.GetTableByName("recharge.csugarshopopen")
local CCurrencySymbol = BeanManager.GetTableByName("topup.ccurrencysymbol")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local SpringUnlockRecord = CTimedActivitySwitch:GetRecorder(25001)
local timeutils = require("logic.utils.timeutils")
local SkinTypeId = 91
GiftTabCell.AssetBundleName = "ui/layouts.activitynewyear"
GiftTabCell.AssetName = "ActivityNewYearShop"

function GiftTabCell:Ctor(...)
  GiftTabCell.super.Ctor(self, ...)
  self._goodData = {}
end

function GiftTabCell:OnCreate()
  self._panel = self:GetChild("FrameShop")
  self._txt = self:GetChild("Txt")
  self._mainName = self:GetChild("MainName")
  self._tipBtn = self:GetChild("Tips")
  self._activeTime = self:GetChild("ActiveTime")
  self._cells = {}
  for i = 1, 2 do
    self._cells[i] = {}
    self._cells[i]._cell_Back = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i)
    self._cells[i]._icon = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Item")
    self._cells[i]._name = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/ItemName")
    self._cells[i]._back = {
      self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/BackG"),
      self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/BackR"),
      self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/BackB")
    }
    self._cells[i]._rmtImage = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price/Rmt")
    self._cells[i]._price = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price")
    self._cells[i]._priceImg = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price/Image")
    self._cells[i]._priceNum = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price/Text")
    self._cells[i]._priceDeleteNum = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price/TextDelete")
    self._cells[i]._textRmt = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price/RmtText")
    self._cells[i]._rmtImage:SetActive(false)
    self._cells[i]._rmtImage2 = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price2/Rmt")
    self._cells[i]._price2 = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price2")
    self._cells[i]._price2Img = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price2/Image")
    self._cells[i]._price2Num = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Price2/Text")
    self._cells[i]._num = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Num/Num")
    self._cells[i]._limit = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Limit")
    self._cells[i]._limit_txt = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Limit/Limit")
    self._cells[i]._soldOut = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/SoldOut")
    self._cells[i]._sale = self:GetChild("FrameShop/ActivityNewYearShopCell" .. i .. "/CellBack/Sale")
    self._cells[i]._cell_Back:Subscribe_PointerClickEvent(function()
      self:OnCellClicked(i)
    end, self)
  end
  for i, cell in ipairs(self._cells) do
    cell._cell_Back:SetActive(false)
  end
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._panelWAnchor, self._panelWWidth = self._panel:GetWidth()
  self._panelPAnchor, self._panelPOffset = self._panel:GetXPosition()
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_RefreshShopInfo, nil)
end

function GiftTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._shopTask then
    GameTimer.RemoveTask(self._shopTask)
    self._shopTask = nil
  end
end

function GiftTabCell:SetData()
  self._activeTime:SetText(TextManager.GetText(701782))
  self._shopId = DataCommon.SpringFestivalActivity.Shop.ShopID
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = self._shopId
    protocol:Send()
  end
end

function GiftTabCell:OnTipBtnClicked()
  DialogManager.CreateSingletonDialog("activity.springfestival.tipsdialog"):SetData(701662)
end

function GiftTabCell:RefreshGoodsData(notChangePos)
  self._shopData = {}
  local shopData = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(DataCommon.SpringFestivalActivity.Shop.ShopID) or {}
  for i = #shopData, 1, -1 do
    local isrmt = 0
    if NekoData.BehaviorManager.BM_Currency:IsRealityCurrency(shopData[i].moneyType) then
      isrmt = 1
    end
    table.insert(self._shopData, {
      isrmt = isrmt,
      iteminfo = shopData[i]
    })
  end
  self:RefreshCells()
  for i, cell in ipairs(self._cells) do
    cell._cell_Back:SetActive(true)
  end
end

function GiftTabCell:RefreshCells()
  for i = 1, #self._shopData do
    local state = 1
    for j = 1, 3 do
      self._cells[i]._back[j]:SetActive(false)
    end
    if self._shopData[i].isrmt == 0 then
      state = 1
    else
      local isSkin = false
      for _, id in ipairs(self._shopData[i].iteminfo.itemId) do
        local item = Item.Create(id)
        isSkin = item:GetItemTypeId() == SkinTypeId
        if isSkin then
          break
        end
      end
      if isSkin then
        state = 3
      else
        state = 2
      end
    end
    self._cells[i]._back[state]:SetActive(true)
    local imageRecord
    if self._shopData[i].isrmt == 1 then
      imageRecord = CImagePathTable:GetRecorder(self._shopData[i].iteminfo.pictureId) or DataCommon.DefaultImageAsset
      self._cells[i]._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._cells[i]._name:SetText(TextManager.GetText(self._shopData[i].iteminfo.goodName))
    else
      local good = CSugarShopOpen:GetRecorder(self._shopData[i].iteminfo.goodId)
      local item = Item.Create(good.Items)
      imageRecord = item:GetIcon()
      self._cells[i]._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._cells[i]._name:SetText(item:GetName())
    end
    if self._shopData[i].iteminfo.goodRemain == 0 then
      self._cells[i]._soldOut:SetActive(true)
      self._cells[i]._num:SetText(0)
    else
      self._cells[i]._soldOut:SetActive(false)
      if self._shopData[i].iteminfo.goodRemain == -1 then
        self._cells[i]._num:SetText(tostring(99 .. "+"))
      else
        self._cells[i]._num:SetText(tostring(self._shopData[i].iteminfo.goodRemain))
      end
    end
    if not (self._shopData[i].iteminfo.beginTime and self._shopData[i].iteminfo.endTime) or self._shopData[i].iteminfo.beginTime == 0 or self._shopData[i].iteminfo.endTime == 0 then
      self._cells[i]._limit:SetActive(false)
    else
      self._cells[i]._limit:SetActive(true)
      self._cells[i]._limit_txt:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._shopData[i].iteminfo.endTime))
    end
    self._cells[i]._sale:SetActive(false)
    if self._shopData[i].iteminfo.discount == -1 or self._shopData[i].iteminfo.discount == 0 then
      self._cells[i]._price:SetActive(false)
      self._cells[i]._price2:SetActive(true)
    else
      self._cells[i]._price:SetActive(true)
      self._cells[i]._price2:SetActive(false)
    end
    if self._shopData[i].isrmt == 1 then
      self._cells[i]._rmtImage2:SetActive(true)
      self._cells[i]._priceImg:SetActive(false)
      self._cells[i]._price2Img:SetActive(false)
    else
      self._cells[i]._rmtImage2:SetActive(false)
      self._cells[i]._priceImg:SetActive(true)
      self._cells[i]._price2Img:SetActive(true)
      item = Item.Create(self._shopData[i].iteminfo.moneyType)
      imageRecord = item:GetIcon()
      self._cells[i]._price2Img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._cells[i]._priceImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    if self._shopData[i].iteminfo.discount == 0 or self._shopData[i].iteminfo.discount == -1 then
      if self._shopData[i].iteminfo.discountPrice ~= 0 then
        self._cells[i]._price2Num:SetText(tostring(self._shopData[i].iteminfo.discountPrice))
      end
    else
      self._cells[i]._priceNum:SetText(tostring(self._shopData[i].iteminfo.discountPrice))
      self._cells[i]._priceDeleteNum:SetText(tostring(self._shopData[i].iteminfo.price))
    end
    self._cells[i]._priceDeleteNum:SetActive(self._shopData[i].iteminfo.discount ~= 10 and self._shopData[i].iteminfo.discount ~= -1)
    if self._shopData[i].iteminfo.discountPrice == 0 then
      self._cells[i]._price:SetActive(false)
      self._cells[i]._price2:SetActive(true)
      self._cells[i]._price2Img:SetActive(false)
      self._cells[i]._sale:SetActive(true)
      local imageRecord = CImagePathTable:GetRecorder(13529) or DataCommon.DefaultImageAsset
      self._cells[i]._sale:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    self._cells[i]._textRmt:SetText(CCurrencySymbol:GetRecorder(self._shopData[i].iteminfo.moneyType).symbol)
  end
end

function GiftTabCell:OnCellClicked(index)
  self._endTime = timeutils.GetConfigFormatTimeStamp(SpringUnlockRecord.closeTime)
  if ServerGameTimer.GetServerTime() > self._endTime then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100455)
    return
  end
  if self._shopData[index].iteminfo.goodRemain ~= 0 then
    DialogManager.CreateSingletonDialog("activity.springfestival.itembuydialog"):SetData(self._shopData[index].iteminfo, self._shopId)
  end
end

function GiftTabCell:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopId then
    self:RefreshGoodsData(true)
  end
end

return GiftTabCell
