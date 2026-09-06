local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CCurrencySymbol = BeanManager.GetTableByName("topup.ccurrencysymbol")
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.activitynewyear"
ItemBuyDialog.AssetName = "ActivityNewYearBuy"

function ItemBuyDialog:Ctor(...)
  ItemBuyDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ItemBuyDialog:OnCreate()
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._back = self:GetChild("Image")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._priceNum = self:GetChild("Back/Price2/Num")
  self._priceNumDelete = self:GetChild("Back/Price2/TextDelete")
  self._moneyType = self:GetChild("Back/Price2/Rmb")
  self._limit = self:GetChild("Back/TimeImg")
  self._limitTxt = self:GetChild("Back/Time")
  self._sale = self:GetChild("Back/Sale")
  self._sale:SetActive(false)
  self._buyDetail = self:GetChild("Back/Frame")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._cellFrame = TableFrame.Create(self._buyDetail, self, true, true, true)
  self._cellFrame:SetMargin(30, 0)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
end

function ItemBuyDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function ItemBuyDialog:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopID = shopid
  local imageRecord = CImagePathTable:GetRecorder(self._itemInfo.pictureId)
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(TextManager.GetText(self._itemInfo.goodName))
  self._moneyType:SetText(CCurrencySymbol:GetRecorder(self._itemInfo.moneyType).symbol)
  if self._itemInfo.discount == 0 or self._itemInfo.discount == -1 or self._itemInfo.discount == 10 then
    self._priceNum:SetText(tostring(self._itemInfo.discountPrice))
    self._priceNumDelete:SetActive(false)
  else
    self._priceNum:SetText(tostring(self._itemInfo.discountPrice))
    self._priceNumDelete:SetActive(true)
    self._priceNumDelete:SetText(tostring(self._itemInfo.price))
  end
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._limit:SetActive(false)
    self._limitTxt:SetActive(false)
  else
    self._limit:SetActive(true)
    self._limitTxt:SetActive(true)
    self._limitTxt:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._cellData = {}
  if self._itemInfo.optionId ~= 0 then
    table.insert(self._cellData, {
      type = "Gift",
      id = self._itemInfo.optionId,
      option = nil
    })
  end
  for i, v in ipairs(self._itemInfo.itemId) do
    table.insert(self._cellData, {
      type = "Item",
      id = self._itemInfo.itemId[i],
      count = self._itemInfo.itemSum[i]
    })
  end
  self._cellFrame:ReloadAllCell()
  self._cellFrame:MoveToTop()
end

function ItemBuyDialog:NumberOfCell(frame)
  return #self._cellData
end

function ItemBuyDialog:CellAtIndex(frame, index)
  if self._cellData[index].type == "Item" then
    return "shop.dailygiftbuycell"
  else
    return "activity.springfestival.optiongiftbuycell"
  end
end

function ItemBuyDialog:DataAtIndex(frame, index)
  return self._cellData[index]
end

function ItemBuyDialog:OnSelect(id)
  self._cellData[1].option = id
  self._cellFrame:ReloadCellsAtIndex({1})
end

function ItemBuyDialog:OnBuyBtnClicked()
  if self._cellData[1].option or self._itemInfo.optionId == 0 then
    local protocol = LuaNetManager.CreateProtocol("protocol.charge.cbuyoptionalitem")
    if protocol then
      protocol.goodId = self._itemInfo.goodId
      local option = self._cellData[1].option or 0
      protocol.option = {option}
      protocol:Send()
    end
    self:Destroy()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100444)
  end
end

function ItemBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("activity.springfestival.roleopstiondialog") then
    return
  end
  self:Destroy()
end

function ItemBuyDialog:AddNewModal()
end

return ItemBuyDialog
