local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CMonthCard = BeanManager.GetTableByName("topup.cmonthcard")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local UIManager = CS.PixelNeko.UI.UIManager
local MonthCardBuyDialog = class("MonthCardBuyDialog", Dialog)
MonthCardBuyDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardBuyDialog.AssetName = "MonthCardBuy"

function MonthCardBuyDialog:Ctor(...)
  MonthCardBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MonthCardBuyDialog:OnCreate()
  self._cardImage = self:GetChild("Back/MonthCardImg")
  self._cardName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._priceType = self:GetChild("Back/Frame/RMB")
  self._priceNum = self:GetChild("Back/Frame/Num")
  self._price2Num = self:GetChild("Back/Frame/TextDelete")
  self._priceText = self:GetChild("Back/Frame/Text")
  self._sale = self:GetChild("Sale")
  self._detail = self:GetChild("Back/Frame/Detail")
  self._back2Title = self:GetChild("Back/Frame/Back2")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self._itemsPanel1 = self:GetChild("Back/Frame/ItemFrame1")
  self._itemsPanel2 = self:GetChild("Back/Frame/ItemFrame2")
  self._itemsPanel3 = self:GetChild("Back/Frame/ItemFrame3")
  self._itemsFrame1 = TableFrame.Create(self._itemsPanel1, self, true, true, true)
  self._itemsFrame2 = TableFrame.Create(self._itemsPanel2, self, true, true, true)
  self._itemsFrame3 = TableFrame.Create(self._itemsPanel3, self, true, true, true)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  self:GetChild("Back/Frame/Text3"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2194))
end

function MonthCardBuyDialog:OnDestroy()
  self._itemsFrame1:Destroy()
  self._itemsFrame2:Destroy()
  self._itemsFrame3:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MonthCardBuyDialog:SetData(iteminfo, endTime)
  self._data = iteminfo
  self._endTime = endTime
  self._goodId = self._data.goodId
  local imageRecord = CImagePathTable:GetRecorder(self._data.pictureId)
  self._cardImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._cardName:SetText(TextManager.GetText(self._data.goodName))
  self._priceNum:SetText(self._data.discountPrice)
  if self._data.discount ~= -1 and self._data.discount ~= 10 then
    self._price2Num:SetActive(true)
    self._price2Num:SetText(self._data.price)
    self._sale:SetActive(true)
  else
    self._price2Num:SetActive(false)
    self._sale:SetActive(false)
  end
  if self._endTime then
    if tonumber(self._endTime) == 0 then
      local str = TextManager.GetText(CStringRes:GetRecorder(1167).msgTextID)
      self._timeText:SetText(str)
    else
      local str = TextManager.GetText(CStringRes:GetRecorder(1183).msgTextID)
      str = string.gsub(str, "%$parameter1%$", self._endTime)
      self._timeText:SetText(str)
    end
  end
  local str = TextManager.GetText(CStringRes:GetRecorder(1168).msgTextID)
  self._detail:SetActive(str)
  self._itemsData1 = {}
  self._itemsData2 = {}
  self._itemsData3 = {}
  if self._data.goodType == 13 or self._data.goodType == 17 then
    self._itemsPanel1:SetActive(true)
    self._itemsPanel2:SetActive(true)
    self._itemsPanel3:SetActive(false)
    self._back2Title:SetActive(true)
    local recorder
    if self._data.goodType == 13 then
      recorder = CMonthCard:GetRecorder(1)
    elseif self._data.goodType == 17 then
      recorder = CMonthCard:GetRecorder(4)
    end
    if not recorder then
      LogErrorFormat("MonthCardBuyDialog", "recorder with goodType %s is not exist in cmonthcard", self._data.goodType)
      return
    end
    for i, v in ipairs(recorder.items) do
      local temp = {}
      temp.id = v
      temp.count = recorder.nums[i]
      table.insert(self._itemsData2, temp)
    end
    self._itemsData1.id = recorder.itemShow
    self._itemsData1.count = recorder.numShow
    self._itemsFrame1:ReloadAllCell()
    self._itemsFrame2:ReloadAllCell()
    self._itemsFrame1:MoveToTop()
    self._itemsFrame2:MoveToTop()
  elseif self._data.goodType == 15 then
    self._itemsPanel1:SetActive(true)
    self._itemsPanel2:SetActive(true)
    self._itemsPanel3:SetActive(false)
    self._back2Title:SetActive(true)
    local recorder = CMonthCard:GetRecorder(2)
    for i, v in ipairs(recorder.items) do
      local temp = {}
      temp.id = v
      temp.count = recorder.nums[i]
      table.insert(self._itemsData2, temp)
    end
    self._itemsData1.id = recorder.itemShow
    self._itemsData1.count = recorder.numShow
    self._itemsFrame1:ReloadAllCell()
    self._itemsFrame2:ReloadAllCell()
    self._itemsFrame1:MoveToTop()
    self._itemsFrame2:MoveToTop()
  elseif self._data.goodType == 16 then
    self._itemsPanel1:SetActive(false)
    self._itemsPanel2:SetActive(false)
    self._itemsPanel3:SetActive(true)
    self._back2Title:SetActive(false)
    local recorder = CMonthCard:GetRecorder(3)
    for i, v in ipairs(recorder.items) do
      local temp = {}
      temp.id = v
      temp.count = recorder.nums[i]
      table.insert(self._itemsData3, temp)
    end
    self._itemsData1.id = recorder.itemShow
    self._itemsData1.count = recorder.numShow
    table.insert(self._itemsData3, 1, self._itemsData1)
    self._itemsFrame3:ReloadAllCell()
    self._itemsFrame3:MoveToTop()
  end
end

function MonthCardBuyDialog:OnBuyBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  if protocol then
    protocol.goodId = self._goodId
    protocol:Send()
  end
end

function MonthCardBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function MonthCardBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    return
  end
  self:Destroy()
end

function MonthCardBuyDialog:NumberOfCell(frame)
  if frame == self._itemsFrame2 then
    return #self._itemsData2
  elseif frame == self._itemsFrame3 then
    return #self._itemsData3
  else
    return 1
  end
end

function MonthCardBuyDialog:CellAtIndex(frame, index)
  return "shop.dailygiftbuycell"
end

function MonthCardBuyDialog:DataAtIndex(frame, index)
  if frame == self._itemsFrame2 then
    return self._itemsData2[index]
  elseif frame == self._itemsFrame3 then
    return self._itemsData3[index]
  else
    return self._itemsData1
  end
end

return MonthCardBuyDialog
