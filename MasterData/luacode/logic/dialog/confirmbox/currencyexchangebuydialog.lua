local CurrencyExchangeTable = BeanManager.GetTableByName("recharge.ccurrencyexchange")
local CItemClassToLoadTable = BeanManager.GetTableByName("item.citemclasstoload")
local Item = require("logic.manager.experimental.types.item")
local CurrencyExchangeBuyDialog = class("CurrencyExchangeBuyDialog", Dialog)
CurrencyExchangeBuyDialog.AssetBundleName = "ui/layouts.yard"
CurrencyExchangeBuyDialog.AssetName = "FurnitureCoinExchange2"

function CurrencyExchangeBuyDialog:Ctor(...)
  CurrencyExchangeBuyDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._messageStacks = {}
  self._canClickCancleBtn = false
  self._canClickConfirmBtn = false
end

function CurrencyExchangeBuyDialog:OnCreate()
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._txt1 = self:GetChild("BackImage/Txt2")
  self._leftItem_icon = self:GetChild("BackImage/Item1/ItemCell/_BackGround/Icon")
  self._leftItem_curNum = self:GetChild("BackImage/Item1/ItemCell/_Count")
  self._leftItem_costNum = self:GetChild("BackImage/Item1/Num2")
  self._rightItem_icon = self:GetChild("BackImage/Item2/ItemCell/_BackGround/Icon")
  self._rightItem_curNum = self:GetChild("BackImage/Item2/ItemCell/_Count")
  self._rightItem_addNum = self:GetChild("BackImage/Item2/Num2")
  self._txt = self:GetChild("BackImage/Txt")
  self._cancelBtn = self:GetChild("BackImage/CancelButton")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

function CurrencyExchangeBuyDialog:OnDestroy()
end

local function GetString(self, str, params)
  for i, v in ipairs(params) do
    str = string.gsub(str, "%$parameter" .. i .. "%$", v)
  end
  return str
end

function CurrencyExchangeBuyDialog:Refresh()
  if table.nums(self._messageStacks) == 0 then
    self:Destroy()
    return
  end
  self._currentMessage = self._messageStacks[1]
  local record = CurrencyExchangeTable:GetRecorder(self._currentMessage.id)
  local leftItem = Item.Create(record.Currency1)
  local rightItem = Item.Create(record.Currency2)
  self._leftItem = leftItem
  self._rightItem = rightItem
  local str = GetString(self, TextManager.GetText(1100045), {
    rightItem:GetName()
  })
  self._title:SetText(str)
  local imageRecord = leftItem:GetIcon()
  self._leftItem_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = rightItem:GetIcon()
  self._rightItem_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum1, haveNum2
  if string.sub(record.Currency1, 1, 2) == "35" then
    haveNum1 = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(record.Currency1)
  else
    haveNum1 = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(record.Currency1)
  end
  if string.sub(record.Currency2, 1, 2) == "35" then
    haveNum2 = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(record.Currency2)
  else
    haveNum2 = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(record.Currency2)
  end
  self._rate = record.Currencynum / record.Nums
  self._rightItem_curNum:SetText(NumberManager.GetShowNumber(haveNum2))
  local costLeftItemNum = math.ceil(self._currentMessage.lackNum / self._rate)
  self._costNum = costLeftItemNum
  self._leftItem_curNum:SetText(NumberManager.GetShowNumber(haveNum1))
  self._leftItem_costNum:SetText(GetString(self, TextManager.GetText(1100048), {costLeftItemNum}))
  str = GetString(self, TextManager.GetText(1100046), {
    self._currentMessage.lackNum,
    rightItem:GetName(),
    costLeftItemNum,
    leftItem:GetName()
  })
  self._txt1:SetText(str)
  local exchangeNum = math.floor(costLeftItemNum * self._rate)
  self._rightItem_addNum:SetText(exchangeNum)
  if haveNum1 >= costLeftItemNum then
    str = GetString(self, TextManager.GetText(1100047), {
      costLeftItemNum,
      leftItem:GetName(),
      exchangeNum,
      rightItem:GetName()
    })
    self._needJump = false
  else
    str = GetString(self, TextManager.GetText(1100049), {
      leftItem:GetName(),
      rightItem:GetName(),
      leftItem:GetName()
    })
    self._needJump = true
  end
  self._txt:SetText(str)
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

function CurrencyExchangeBuyDialog:PushDialogSetting(id, lackNum)
  local message = {}
  message.id = id
  message.lackNum = lackNum
  local repeatId
  for i, v in ipairs(self._messageStacks) do
    if v.id == id then
      repeatId = id
      break
    end
  end
  if repeatId then
    LogErrorFormat("CurrencyExchangeBuyDialog", "Duplicate with existing ID: %s", repeatId)
  end
  table.insert(self._messageStacks, message)
  self:Refresh()
end

function CurrencyExchangeBuyDialog:OnBackBtnClicked()
  if not self._canClickCancleBtn then
    return
  end
  self._canClickCancleBtn = false
  table.remove(self._messageStacks, 1)
  self:Refresh()
end

function CurrencyExchangeBuyDialog:OnConfirmBtnClicked()
  if not self._canClickConfirmBtn then
    return
  end
  self._canClickConfirmBtn = false
  if self._needJump then
    NekoData.BehaviorManager.BM_Shop:JumpToShopBuyDiamonds()
  else
    local cmd = LuaNetManager.CreateProtocol("protocol.shop.cdiamondexchange")
    cmd.costItem = self._leftItem:GetID()
    cmd.exchangeCurrencyType = self._rightItem:GetID()
    cmd.exchangeCurrencySum = math.ceil(self._costNum * self._rate)
    cmd.costItemSum = self._costNum
    cmd:Send()
  end
  table.remove(self._messageStacks, 1)
  self:Refresh()
end

return CurrencyExchangeBuyDialog
