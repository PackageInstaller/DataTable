local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CEmojiItem = BeanManager.GetTableByName("item.cemojiitem")
local RoleTypeId = 27
local EmojiBuyDialog = class("EmojiBuyDialog", Dialog)
EmojiBuyDialog.AssetBundleName = "ui/layouts.baseshop"
EmojiBuyDialog.AssetName = "EmojiBuy"

function EmojiBuyDialog:Ctor(...)
  EmojiBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function EmojiBuyDialog:OnCreate()
  self._itemBack = self:GetChild("Back/ItemBack")
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemImage_Char = self:GetChild("Back/Char")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImg = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._price2 = self:GetChild("Back/Price2")
  self._price2:SetActive(false)
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function EmojiBuyDialog:OnDestroy()
  self._itemFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function EmojiBuyDialog:SetData(iteminfo, shopid)
  self._itemInfo = iteminfo
  self._shopID = shopid
  if iteminfo.discount == 0 then
    self._saleImage:SetActive(false)
  elseif iteminfo.discount == -1 then
    self._saleImage:SetActive(false)
  else
    self._saleImage:SetActive(true)
    local imageRecord = CImagePathTable:GetRecorder(10 - iteminfo.discount + 11392)
    self._saleImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
  local allIDs = CEmojiItem:GetAllIds()
  self._itemData = {}
  for i, v in ipairs(allIDs) do
    local record = CEmojiItem:GetRecorder(v)
    if record.itemId == iteminfo.itemId then
      local data = string.split(record.emojiIds, "-")
      local op = tonumber(data[1])
      local ep = tonumber(data[2])
      for i = op, ep do
        table.insert(self._itemData, {id = i})
      end
    end
  end
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
  local item = Item.Create(iteminfo.itemId)
  local imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetShopBuyBackGroudImg()
  self._itemBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  item = Item.Create(iteminfo.moneyType)
  imageRecord = item:GetIcon()
  self._priceTypeImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._priceNum:SetText(tostring(iteminfo.discountPrice))
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._timeText:SetActive(false)
    self._timeImg:SetActive(false)
  else
    self._timeImg:SetActive(true)
    self._timeText:SetActive(true)
    self._timeText:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._currentBuyItemNumber = 1
  self._unitPrice = iteminfo.discountPrice
  self._totalMoney = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(iteminfo.moneyType)
  self._canBuyMaxNum = math.floor(self._totalMoney / self._unitPrice)
  if iteminfo.goodRemain ~= -1 then
    self._canBuyMaxNum = math.min(self._canBuyMaxNum, iteminfo.goodRemain)
  end
end

function EmojiBuyDialog:OnBuyBtnClicked()
  if self._canBuyMaxNum == 0 then
    if self._itemInfo.moneyType == DataCommon.DiamodID then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
        NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
      end, {}, nil, {})
      self:Destroy()
      return
    elseif self._itemInfo.moneyType == DataCommon.SoulDropID then
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(108, nil, function()
        NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(19)
      end, {}, nil, {})
      self:Destroy()
      return
    end
    NekoData.BehaviorManager.BM_Message:SendMessageById(100032, {
      Item.Create(self._itemInfo.moneyType):GetName()
    })
    self:Destroy()
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
  if protocol then
    protocol.shopId = self._shopID
    local map = {}
    map[self._itemInfo.goodId] = self._currentBuyItemNumber
    protocol.goods = map
    protocol:Send()
  end
end

function EmojiBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function EmojiBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function EmojiBuyDialog:NumberOfCell(frame)
  return #self._itemData
end

function EmojiBuyDialog:CellAtIndex(frame, index)
  return "shop.emojibuycell"
end

function EmojiBuyDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return EmojiBuyDialog
