-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/monthcardbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CMonthCard = (BeanManager.GetTableByName)("topup.cmonthcard")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local UIManager = ((CS.PixelNeko).UI).UIManager
local MonthCardBuyDialog = class("MonthCardBuyDialog", Dialog)
MonthCardBuyDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardBuyDialog.AssetName = "MonthCardBuy"
MonthCardBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthCardBuyDialog
  ((MonthCardBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MonthCardBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
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
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self._itemsPanel1 = self:GetChild("Back/Frame/ItemFrame1")
  self._itemsPanel2 = self:GetChild("Back/Frame/ItemFrame2")
  self._itemsPanel3 = self:GetChild("Back/Frame/ItemFrame3")
  self._itemsFrame1 = (TableFrame.Create)(self._itemsPanel1, self, true, true, true)
  self._itemsFrame2 = (TableFrame.Create)(self._itemsPanel2, self, true, true, true)
  self._itemsFrame3 = (TableFrame.Create)(self._itemsPanel3, self, true, true, true)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (self:GetChild("Back/Frame/Text3")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2194))
end

MonthCardBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._itemsFrame1):Destroy()
  ;
  (self._itemsFrame2):Destroy()
  ;
  (self._itemsFrame3):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MonthCardBuyDialog.SetData = function(self, iteminfo, endTime)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CStringRes, CMonthCard
  self._data = iteminfo
  self._endTime = endTime
  self._goodId = (self._data).goodId
  local imageRecord = CImagePathTable:GetRecorder((self._data).pictureId)
  ;
  (self._cardImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._cardName):SetText((TextManager.GetText)((self._data).goodName))
  ;
  (self._priceNum):SetText((self._data).discountPrice)
  if (self._data).discount ~= -1 and (self._data).discount ~= 10 then
    (self._price2Num):SetActive(true)
    ;
    (self._price2Num):SetText((self._data).price)
    ;
    (self._sale):SetActive(true)
  else
    ;
    (self._price2Num):SetActive(false)
    ;
    (self._sale):SetActive(false)
  end
  if self._endTime then
    if tonumber(self._endTime) == 0 then
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1167)).msgTextID)
      ;
      (self._timeText):SetText(str)
    else
      do
        do
          local str = (TextManager.GetText)((CStringRes:GetRecorder(1183)).msgTextID)
          str = (string.gsub)(str, "%$parameter1%$", self._endTime)
          ;
          (self._timeText):SetText(str)
          local str = (TextManager.GetText)((CStringRes:GetRecorder(1168)).msgTextID)
          ;
          (self._detail):SetActive(str)
          self._itemsData1 = {}
          self._itemsData2 = {}
          self._itemsData3 = {}
          if (self._data).goodType == 13 or (self._data).goodType == 17 then
            (self._itemsPanel1):SetActive(true)
            ;
            (self._itemsPanel2):SetActive(true)
            ;
            (self._itemsPanel3):SetActive(false)
            ;
            (self._back2Title):SetActive(true)
            local recorder = nil
            if (self._data).goodType == 13 then
              recorder = CMonthCard:GetRecorder(1)
            else
              if (self._data).goodType == 17 then
                recorder = CMonthCard:GetRecorder(4)
              end
            end
            if not recorder then
              LogErrorFormat("MonthCardBuyDialog", "recorder with goodType %s is not exist in cmonthcard", (self._data).goodType)
              return 
            end
            for i,v in ipairs(recorder.items) do
              local temp = {}
              temp.id = v
              temp.count = (recorder.nums)[i]
              ;
              (table.insert)(self._itemsData2, temp)
            end
            -- DECOMPILER ERROR at PC187: Confused about usage of register: R6 in 'UnsetPending'

            ;
            (self._itemsData1).id = recorder.itemShow
            -- DECOMPILER ERROR at PC190: Confused about usage of register: R6 in 'UnsetPending'

            ;
            (self._itemsData1).count = recorder.numShow
            ;
            (self._itemsFrame1):ReloadAllCell()
            ;
            (self._itemsFrame2):ReloadAllCell()
            ;
            (self._itemsFrame1):MoveToTop()
            ;
            (self._itemsFrame2):MoveToTop()
          else
            do
              if (self._data).goodType == 15 then
                (self._itemsPanel1):SetActive(true)
                ;
                (self._itemsPanel2):SetActive(true)
                ;
                (self._itemsPanel3):SetActive(false)
                ;
                (self._back2Title):SetActive(true)
                local recorder = CMonthCard:GetRecorder(2)
                for i,v in ipairs(recorder.items) do
                  local temp = {}
                  temp.id = v
                  temp.count = (recorder.nums)[i]
                  ;
                  (table.insert)(self._itemsData2, temp)
                end
                -- DECOMPILER ERROR at PC246: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (self._itemsData1).id = recorder.itemShow
                -- DECOMPILER ERROR at PC249: Confused about usage of register: R6 in 'UnsetPending'

                ;
                (self._itemsData1).count = recorder.numShow
                ;
                (self._itemsFrame1):ReloadAllCell()
                ;
                (self._itemsFrame2):ReloadAllCell()
                ;
                (self._itemsFrame1):MoveToTop()
                ;
                (self._itemsFrame2):MoveToTop()
              else
                do
                  if (self._data).goodType == 16 then
                    (self._itemsPanel1):SetActive(false)
                    ;
                    (self._itemsPanel2):SetActive(false)
                    ;
                    (self._itemsPanel3):SetActive(true)
                    ;
                    (self._back2Title):SetActive(false)
                    local recorder = CMonthCard:GetRecorder(3)
                    for i,v in ipairs(recorder.items) do
                      local temp = {}
                      temp.id = v
                      temp.count = (recorder.nums)[i]
                      ;
                      (table.insert)(self._itemsData3, temp)
                    end
                    -- DECOMPILER ERROR at PC305: Confused about usage of register: R6 in 'UnsetPending'

                    ;
                    (self._itemsData1).id = recorder.itemShow
                    -- DECOMPILER ERROR at PC308: Confused about usage of register: R6 in 'UnsetPending'

                    ;
                    (self._itemsData1).count = recorder.numShow
                    ;
                    (table.insert)(self._itemsData3, 1, self._itemsData1)
                    ;
                    (self._itemsFrame3):ReloadAllCell()
                    ;
                    (self._itemsFrame3):MoveToTop()
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

MonthCardBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  if protocol then
    protocol.goodId = self._goodId
    protocol:Send()
  end
end

MonthCardBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

MonthCardBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    return 
  end
  self:Destroy()
end

MonthCardBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  if frame == self._itemsFrame2 then
    return #self._itemsData2
  else
    if frame == self._itemsFrame3 then
      return #self._itemsData3
    else
      return 1
    end
  end
end

MonthCardBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "shop.dailygiftbuycell"
end

MonthCardBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._itemsFrame2 then
    return (self._itemsData2)[index]
  else
    if frame == self._itemsFrame3 then
      return (self._itemsData3)[index]
    else
      return self._itemsData1
    end
  end
end

return MonthCardBuyDialog

