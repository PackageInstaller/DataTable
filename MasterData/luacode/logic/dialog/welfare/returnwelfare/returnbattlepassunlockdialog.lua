local Item = require("logic.manager.experimental.types.item")
local UIBackManager = require("framework.ui.uibackmanager")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local UIManager = CS.PixelNeko.UI.UIManager
local CReturnBattlePassCfg = BeanManager.GetTableByName("welfare.creturnbattlepasscfg")
local SpecialRecord = CReturnBattlePassCfg:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass)
local ShowByModalDialogs = {
  "welfare.returnwelfare.roleopstiondialog",
  "mainline.bossrush.checkotherroleinfodialog"
}
local ReturnBattlePassUnlockDialog = class("ReturnBattlePassUnlockDialog", Dialog)
ReturnBattlePassUnlockDialog.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassUnlockDialog.AssetName = "ReturnBattlePassBuy"

function ReturnBattlePassUnlockDialog:Ctor(...)
  ReturnBattlePassUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._handler = nil
  self._modelHandle = nil
  self._roleData = nil
  self._fashionName = ""
  self._roleName = ""
end

function ReturnBattlePassUnlockDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._time = self:GetChild("Time")
  self._price = self:GetChild("BuyBtn/Num")
  self._buyBtn = self:GetChild("BuyBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  local frame = self:GetChild("Frame")
  self._frame = GridFrame.Create(frame, self, true, 4, true)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  self:GetChild("BuyBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2207))
end

function ReturnBattlePassUnlockDialog:OnBackBtnClicked()
  self:Destroy()
end

function ReturnBattlePassUnlockDialog:OnDestroy()
  self._frame:Destroy()
end

local function handleData(items, itemId, num)
  if itemId <= 0 then
    return
  end
  if not items[itemId] then
    items[itemId] = num
  else
    items[itemId] = items[itemId] + num
  end
end

function ReturnBattlePassUnlockDialog:Init(moneyType)
  self._returnBattlePass = NekoData.BehaviorManager.BM_ReturnWelfare:GetReturnBattlePass()
  local d = os.date("*t", self._returnBattlePass.deadline // 1000)
  local mid = BeanManager.GetTableByName("message.cstringres"):GetRecorder(2208).msgTextID
  local str = TextManager.GetText(mid)
  str = string.gsub(str, "%$parameter1%$", d.year)
  str = string.gsub(str, "%$parameter2%$", d.month)
  str = string.gsub(str, "%$parameter3%$", d.day)
  str = string.gsub(str, "%$parameter4%$", string.format("%02d:%02d:%02d", d.hour, d.min, d.sec))
  self._time:SetText(str)
  self._price:SetText(self._returnBattlePass.chargePrice)
  local id = DataCommon.AgCoinActivityID
  local mgr = NekoData.BehaviorManager.BM_Activity:GetManager(id)
  self._info = mgr:GetBaseInfo()
  local items = {}
  for k, v in ipairs(self._returnBattlePass.highCollection) do
    if v.itemId > 0 then
      handleData(items, v.itemId, v.itemNum)
    end
  end
  local itemList = {}
  for k, v in pairs(items) do
    local item = Item.Create(k)
    item:SetCount(v)
    table.insert(itemList, item)
  end
  table.sort(itemList, function(aItem, bItem)
    if aItem:GetPinJiID() == bItem:GetPinJiID() then
      return aItem:GetID() > bItem:GetID()
    else
      return aItem:GetPinJiID() > bItem:GetPinJiID()
    end
  end)
  self._items = itemList
  self._frame:ReloadAllCell()
end

function ReturnBattlePassUnlockDialog:OnBuyBtnClicked()
  local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
  cmd.goodId = self._returnBattlePass.goodId
  cmd:Send()
end

function ReturnBattlePassUnlockDialog:NumberOfCell(frame)
  return #self._items
end

function ReturnBattlePassUnlockDialog:CellAtIndex(frame, index)
  return "welfare.returnwelfare.returnbattlepassunlockitemcell"
end

function ReturnBattlePassUnlockDialog:DataAtIndex(frame, index)
  return self._items[index]
end

function ReturnBattlePassUnlockDialog:AddNewModal(dialog)
  if table.keyof(ShowByModalDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

return ReturnBattlePassUnlockDialog
