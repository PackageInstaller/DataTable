-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/itembuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CCurrencySymbol = (BeanManager.GetTableByName)("topup.ccurrencysymbol")
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.activitynewyear"
ItemBuyDialog.AssetName = "ActivityNewYearBuy"
ItemBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemBuyDialog
  ((ItemBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

ItemBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._back = self:GetChild("Image")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._priceNum = self:GetChild("Back/Price2/Num")
  self._priceNumDelete = self:GetChild("Back/Price2/TextDelete")
  self._moneyType = self:GetChild("Back/Price2/Rmb")
  self._limit = self:GetChild("Back/TimeImg")
  self._limitTxt = self:GetChild("Back/Time")
  self._sale = self:GetChild("Back/Sale")
  ;
  (self._sale):SetActive(false)
  self._buyDetail = self:GetChild("Back/Frame")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._cellFrame = (TableFrame.Create)(self._buyDetail, self, true, true, true)
  ;
  (self._cellFrame):SetMargin(30, 0)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
end

ItemBuyDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

ItemBuyDialog.SetData = function(self, iteminfo, shopid)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV, CCurrencySymbol
  self._itemInfo = iteminfo
  self._shopID = shopid
  local imageRecord = CImagePathTable:GetRecorder((self._itemInfo).pictureId)
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText((TextManager.GetText)((self._itemInfo).goodName))
  ;
  (self._moneyType):SetText((CCurrencySymbol:GetRecorder((self._itemInfo).moneyType)).symbol)
  if (self._itemInfo).discount == 0 or (self._itemInfo).discount == -1 or (self._itemInfo).discount == 10 then
    (self._priceNum):SetText(tostring((self._itemInfo).discountPrice))
    ;
    (self._priceNumDelete):SetActive(false)
  else
    ;
    (self._priceNum):SetText(tostring((self._itemInfo).discountPrice))
    ;
    (self._priceNumDelete):SetActive(true)
    ;
    (self._priceNumDelete):SetText(tostring((self._itemInfo).price))
  end
  if not (self._itemInfo).beginTime or not (self._itemInfo).endTime or (self._itemInfo).beginTime == 0 or (self._itemInfo).endTime == 0 then
    (self._limit):SetActive(false)
    ;
    (self._limitTxt):SetActive(false)
  else
    ;
    (self._limit):SetActive(true)
    ;
    (self._limitTxt):SetActive(true)
    ;
    (self._limitTxt):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._itemInfo).endTime))
  end
  self._cellData = {}
  if (self._itemInfo).optionId ~= 0 then
    (table.insert)(self._cellData, {type = "Gift", id = (self._itemInfo).optionId, option = nil})
  end
  for i,v in ipairs((self._itemInfo).itemId) do
    (table.insert)(self._cellData, {type = "Item", id = ((self._itemInfo).itemId)[i], count = ((self._itemInfo).itemSum)[i]})
  end
  ;
  (self._cellFrame):ReloadAllCell()
  ;
  (self._cellFrame):MoveToTop()
end

ItemBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._cellData
end

ItemBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if ((self._cellData)[index]).type == "Item" then
    return "shop.dailygiftbuycell"
  else
    return "activity.springfestival.optiongiftbuycell"
  end
end

ItemBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._cellData)[index]
end

ItemBuyDialog.OnSelect = function(self, id)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self._cellData)[1]).option = id
  ;
  (self._cellFrame):ReloadCellsAtIndex({1})
end

ItemBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if ((self._cellData)[1]).option or (self._itemInfo).optionId == 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.charge.cbuyoptionalitem")
    if protocol then
      protocol.goodId = (self._itemInfo).goodId
      local option = ((self._cellData)[1]).option or 0
      protocol.option = {option}
      protocol:Send()
    end
    do
      do
        self:Destroy()
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100444)
      end
    end
  end
end

ItemBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (DialogManager.GetDialog)("activity.springfestival.roleopstiondialog") then
    return 
  end
  self:Destroy()
end

ItemBuyDialog.AddNewModal = function(self)
  -- function num : 0_10
end

return ItemBuyDialog

