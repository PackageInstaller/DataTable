local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local OfflineSweepAccountDialog = class("OfflineSweepAccountDialog", Dialog)
OfflineSweepAccountDialog.AssetBundleName = "ui/layouts.dungeon"
OfflineSweepAccountDialog.AssetName = "DungeonFinish2"

function OfflineSweepAccountDialog:Ctor(...)
  OfflineSweepAccountDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._bm = NekoData.BehaviorManager.BM_OfflineSweep
  self._data = {}
end

function OfflineSweepAccountDialog:OnCreate()
  self._itemField = self:GetChild("ItemFrame")
  self._getMoney = self:GetChild("NumFrame/Num1")
  self._getMoney:SetText(0)
  self._totalMoney = self:GetChild("NumFrame/Num2")
  self._nextBtn = self:GetChild("ConfirmButton")
  self._emptyTips = self:GetChild("EmptyTips")
  self._nextBtn:Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self._itemFrame = GridFrame.Create(self._itemField, self, true, 6)
  self._itemFrame:SetMargin(30, 0)
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
  self:Init()
end

function OfflineSweepAccountDialog:OnDestroy()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

local function SortItemByPinji(self)
  local function gettempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  table.sort(self._data, function(a, b)
    return gettempFun(a.item, b.item)
  end)
end

function OfflineSweepAccountDialog:Init()
  local bagList = self._bm:GetAccountBag()
  local money = self._bm:GetMoneyData()
  local restituteReward = self._bm:GetRestituteReward()
  self._data = {}
  for i, v in ipairs(bagList) do
    table.insert(self._data, v)
  end
  SortItemByPinji(self)
  local moneyData = {}
  for k, v in pairs(money) do
    local item = Item.Create(k)
    table.insert(moneyData, {item = item, num = v})
  end
  if restituteReward then
    for k, v in pairs(restituteReward) do
      local item = Item.Create(k)
      table.insert(moneyData, {item = item, num = v})
    end
  end
  table.sort(moneyData, function(a, b)
    local aId, bId = a.item:GetID(), b.item:GetID()
    if aId == 35003 then
      return false
    elseif bId == 35003 then
      return true
    else
      return aId > bId
    end
  end)
  for _, v in ipairs(moneyData) do
    table.insert(self._data, 1, v)
  end
  if #self._data ~= 0 then
    self._emptyTips:SetActive(false)
  else
    self._emptyTips:SetActive(true)
    local str = TextManager.GetText(CStringRes:GetRecorder(1106).msgTextID)
    self._emptyTips:SetText(str)
  end
  self._itemFrame:ReloadAllCell()
  self._getMoney:SetNumber(money[DataCommon.ManaID] or 0)
  self._totalMoney:SetNumber(NekoData.BehaviorManager.BM_Currency:GetMoney())
end

function OfflineSweepAccountDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._data
  end
end

function OfflineSweepAccountDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "dungeon.dungeonaccountcell"
  end
end

function OfflineSweepAccountDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame and #self._data ~= 0 then
    return self._data[index]
  end
end

function OfflineSweepAccountDialog:OnNextClicked()
  self:Destroy()
end

function OfflineSweepAccountDialog:OnTipsDestroy(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._itemFrame:FireEvent("SetItemSelectedState", nil)
  end
end

function OfflineSweepAccountDialog:SetSelectedID(args)
  self._itemFrame:FireEvent("SetItemSelectedState", args)
end

function OfflineSweepAccountDialog:SetNotSelect()
  self._itemFrame:FireEvent("SetItemSelectedState", nil)
end

return OfflineSweepAccountDialog
