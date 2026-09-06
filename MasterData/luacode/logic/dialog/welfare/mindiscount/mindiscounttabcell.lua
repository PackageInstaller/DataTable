local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MinDiscountTabCell = class("MinDiscountTabCell", Dialog)
local CStringRes = BeanManager.GetTableByName("message.cstringres")
MinDiscountTabCell.AssetBundleName = "ui/layouts.welfare"
MinDiscountTabCell.AssetName = "MinDiscount"

function MinDiscountTabCell:Ctor(...)
  MinDiscountTabCell.super.Ctor(self, ...)
  self._init = false
  self._cellData = {}
  self._activityClose = false
  self._activityTask = nil
  self._activityId = DataCommon.Activities.MinDiscount
end

function MinDiscountTabCell:OnCreate()
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = GridFrame.Create(self._panel, self, true, 3, false)
  self._timeTxt = self:GetChild("BackImage/Time/Time")
  self._buyBtn = self:GetChild("BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.BuyBtnClick, self)
  self._buyBtn_Text = self:GetChild("BuyBtn/Text")
  self._priceTextDelete = self:GetChild("BuyBtn/TextDelete")
  self._priceTextDeleteLine = self:GetChild("BuyBtn/TextDelete/Line")
  self._saleImage = self:GetChild("BuyBtn/Image")
  self._priceNum = self:GetChild("BuyBtn/Text1")
  local cmd = LuaNetManager.CreateProtocol("protocol.activity.cminidiscountactivityinfo")
  if cmd then
    cmd:Send()
  end
end

function MinDiscountTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function MinDiscountTabCell:RefreshTabCell(refresh, notChangeSlidePos)
  if not self._init or refresh then
    local data = NekoData.BehaviorManager.BM_Welfare:GetMinDiscoundtWelfareInfo()
    if not data then
      self._activityClose = true
    end
    if self._activityClose then
      if self._activityTask then
        GameTimer.RemoveTask(self._activityTask)
        self._activityTask = nil
      end
      self._timeTxt:SetActive(false)
      self._buyBtn:SetActive(false)
    else
      self._leftTime = data.leftTime
      self:RefreshTime()
      if not self._activityTask then
        self._activityTask = GameTimer.AddTask(0, 60, function()
          self:RefreshTime()
        end)
      end
      if data.cellData then
        self._cellData = data.cellData
        self._frame:ReloadAllCell()
      end
      if data.goodInfo then
        self._data = data.goodInfo
        self._priceNum:SetText(tostring(SdkManager.GetPrice(self._data.discountPrice)))
        if self._data.discountPrice == self._data.price then
          self._priceTextDelete:SetActive(false)
        else
          self._priceTextDelete:SetActive(true)
          self._priceTextDelete:SetText(tostring(SdkManager.GetPrice(self._data.price)))
        end
        if self._data.discount == 0 then
          self._saleImage:SetActive(false)
        elseif self._data.discount == -1 then
          self._saleImage:SetActive(false)
        else
          self._saleImage:SetActive(true)
          local imageRecord = NekoData.BehaviorManager.BM_Shop:GetDiscountAsset(self._data.discount)
          self._saleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        end
      end
    end
  end
end

function MinDiscountTabCell:RefreshTime()
  if self._leftTime then
    local time = self._leftTime / 1000
    local day = math.floor(time / 86400)
    local hour = math.floor((time - day * 24 * 60 * 60) / 3600)
    local min = math.floor((time - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
    local sec = math.floor(time - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
    local str = ""
    if 0 < day then
      self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2242, {day, hour}))
    elseif 0 < hour then
      self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2243, {hour}))
    else
      self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2244, {min}))
    end
  end
end

function MinDiscountTabCell:NumberOfCell(frame)
  return #self._cellData
end

function MinDiscountTabCell:CellAtIndex(frame, index)
  return "welfare.mindiscount.mindiscountcell"
end

function MinDiscountTabCell:DataAtIndex(frame, index)
  return self._cellData[index]
end

function MinDiscountTabCell:BuyBtnClick()
  if self._data.goodId and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.MinDiscount) and NekoData.BehaviorManager.BM_Welfare:IsShowMinDiscount() then
    local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
    cmd.goodId = self._data.goodId
    cmd:Send()
  end
end

return MinDiscountTabCell
