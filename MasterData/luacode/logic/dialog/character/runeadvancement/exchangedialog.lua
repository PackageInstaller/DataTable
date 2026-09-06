local Item = require("logic.manager.experimental.types.item")
local ExchangeTable = BeanManager.GetTableByName("role.croleadvanceditemexchange")
local ExchangeDialog = class("ExchangeDialog", Dialog)
ExchangeDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ExchangeDialog.AssetName = "CharUpgradeMixSecondConfirm"

function ExchangeDialog:Ctor(...)
  ExchangeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._exchangeIdStacks = {}
  self._exchangeId = nil
  self._canClickCancleBtn = false
  self._canClickConfirmBtn = false
  self._costNum = 0
  self._limitNum = 0
end

function ExchangeDialog:OnCreate()
  self:GetChild("BackImage/Item1/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2050))
  self:GetChild("BackImage/Item2/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2051))
  self:GetChild("BackImage/CancelButton/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2))
  self:GetChild("BackImage/ConfirmButton/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1))
  self._title = self:GetChild("BackImage/TitleBack/Title")
  self._leftItem_icon = self:GetChild("BackImage/Item1/ItemCell/_BackGround/Icon")
  self._leftItem_curNum = self:GetChild("BackImage/Item1/ItemCell/_Count")
  self._leftItem_costNum = self:GetChild("BackImage/Item1/Num2")
  self._rightItem_icon = self:GetChild("BackImage/Item2/ItemCell/_BackGround/Icon")
  self._rightItem_curNum = self:GetChild("BackImage/Item2/ItemCell/_Count")
  self._rightItem_addNum = self:GetChild("BackImage/Item2/Num2")
  self._buyNumText = self:GetChild("BackImage/Num/Num")
  self._reduceBtn = self:GetChild("BackImage/Num/MinusBtn")
  self._addBtn = self:GetChild("BackImage/Num/AddBtn")
  self._minBtn = self:GetChild("BackImage/Num/MinBtn")
  self._maxBtn = self:GetChild("BackImage/Num/MaxBtn")
  self._txt = self:GetChild("BackImage/Txt")
  self._cancelBtn = self:GetChild("BackImage/CancelButton")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._minBtn:Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._leftItem_icon:Subscribe_PointerClickEvent(function()
    self:OnCellClicked(1)
  end, self)
  self._rightItem_icon:Subscribe_PointerClickEvent(function()
    self:OnCellClicked(2)
  end)
end

function ExchangeDialog:OnDestroy()
end

local function GetString(self, str, params)
  for i, v in ipairs(params) do
    str = string.gsub(str, "%$parameter" .. i .. "%$", v)
  end
  return str
end

local function RefreshOperatePanel(self)
  self._rightItem_addNum:SetText(math.ceil(self._costNum * self._rate))
  self._leftItem_costNum:SetText(GetString(self, TextManager.GetText(1100048), {
    self._costNum
  }))
  self._buyNumText:SetText(self._costNum)
  self._txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2048, {
    self._leftItem:GetName(),
    self._rightItem:GetName()
  }))
  self._reduceBtn:SetInteractable(self._costNum > self._costNumRate)
  self._addBtn:SetInteractable(self._costNum < self._limitNum)
  self._minBtn:SetInteractable(self._costNum > self._costNumRate)
  self._maxBtn:SetInteractable(self._costNum < self._limitNum)
  self._needJump = self._costNum > self._limitNum
end

function ExchangeDialog:Refresh()
  if table.nums(self._exchangeIdStacks) == 0 then
    self:Destroy()
    return
  end
  self._exchangeId = self._exchangeIdStacks[1]
  local record = ExchangeTable:GetRecorder(self._exchangeId)
  local leftItem = Item.Create(record.nowItem)
  local rightItem = Item.Create(record.exchangeItem)
  self._leftItem = leftItem
  self._rightItem = rightItem
  self._rate = record.exchangeNum / record.itemNum
  self._costNumRate = record.itemNum
  self._costNum = self._costNumRate
  local str = NekoData.BehaviorManager.BM_Message:GetString(2047)
  self._title:SetText(str)
  local imageRecord = leftItem:GetIcon()
  self._leftItem_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = rightItem:GetIcon()
  self._rightItem_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local haveNum1, haveNum2
  haveNum1 = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(record.nowItem)
  self._limitNum = math.floor(haveNum1 / self._costNumRate) * self._costNumRate
  haveNum2 = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(record.exchangeItem)
  self._leftItem_curNum:SetText(NumberManager.GetShowNumber(haveNum1))
  self._rightItem_curNum:SetText(NumberManager.GetShowNumber(haveNum2))
  RefreshOperatePanel(self)
  self._canClickCancleBtn = true
  self._canClickConfirmBtn = true
end

function ExchangeDialog:PushDialogSetting(id)
  local repeatId
  for i, v in ipairs(self._exchangeIdStacks) do
    if v == id then
      repeatId = id
      break
    end
  end
  if repeatId then
    LogErrorFormat("ExchangeDialog", "Duplicate with existing ID: %s", repeatId)
  end
  table.insert(self._exchangeIdStacks, id)
  self:Refresh()
end

function ExchangeDialog:OnReduceBtnClicked()
  self._costNum = self._costNum - self._costNumRate
  RefreshOperatePanel(self)
end

function ExchangeDialog:OnAddBtnClicked()
  self._costNum = self._costNum + self._costNumRate
  RefreshOperatePanel(self)
end

function ExchangeDialog:OnMinBtnClicked()
  self._costNum = self._costNumRate
  RefreshOperatePanel(self)
end

function ExchangeDialog:OnMaxBtnClicked()
  self._costNum = self._limitNum
  RefreshOperatePanel(self)
end

function ExchangeDialog:OnBackBtnClicked()
  if not self._canClickCancleBtn then
    return
  end
  self._canClickCancleBtn = false
  table.remove(self._exchangeIdStacks, 1)
  self:Refresh()
end

function ExchangeDialog:OnConfirmBtnClicked()
  if not self._canClickConfirmBtn then
    return
  end
  if self._needJump then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100483, {
      self._leftItem:GetName()
    })
  else
    self._canClickConfirmBtn = false
    local cmd = LuaNetManager.CreateProtocol("protocol.login.cdustsynthesis")
    cmd.dustId = self._exchangeIdStacks[1]
    cmd.num = math.ceil(self._costNum * self._rate)
    cmd:Send()
    table.remove(self._exchangeIdStacks, 1)
    self:Refresh()
  end
end

function ExchangeDialog:OnCellClicked(id)
  local item
  if id == 1 then
    item = self._leftItem
  elseif id == 2 then
    item = self._rightItem
  end
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = item})
  end
end

return ExchangeDialog
