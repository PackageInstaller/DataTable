-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnbattlepassunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local UIBackManager = require("framework.ui.uibackmanager")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CReturnBattlePassCfg = (BeanManager.GetTableByName)("welfare.creturnbattlepasscfg")
local SpecialRecord = CReturnBattlePassCfg:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass)
local ShowByModalDialogs = {"welfare.returnwelfare.roleopstiondialog", "mainline.bossrush.checkotherroleinfodialog"}
local ReturnBattlePassUnlockDialog = class("ReturnBattlePassUnlockDialog", Dialog)
ReturnBattlePassUnlockDialog.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassUnlockDialog.AssetName = "ReturnBattlePassBuy"
ReturnBattlePassUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnBattlePassUnlockDialog
  ((ReturnBattlePassUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._handler = nil
  self._modelHandle = nil
  self._roleData = nil
  self._fashionName = ""
  self._roleName = ""
end

ReturnBattlePassUnlockDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._back = self:GetChild("Back")
  self._time = self:GetChild("Time")
  self._price = self:GetChild("BuyBtn/Num")
  self._buyBtn = self:GetChild("BuyBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  local frame = self:GetChild("Frame")
  self._frame = (GridFrame.Create)(frame, self, true, 4, true)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (self:GetChild("BuyBtn/Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2207))
end

ReturnBattlePassUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

ReturnBattlePassUnlockDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._frame):Destroy()
end

local handleData = function(items, itemId, num)
  -- function num : 0_4
  if itemId <= 0 then
    return 
  end
  if not items[itemId] then
    items[itemId] = num
  else
    items[itemId] = items[itemId] + num
  end
end

ReturnBattlePassUnlockDialog.Init = function(self, moneyType)
  -- function num : 0_5 , upvalues : _ENV, handleData, Item
  self._returnBattlePass = ((NekoData.BehaviorManager).BM_ReturnWelfare):GetReturnBattlePass()
  local d = (os.date)("*t", (self._returnBattlePass).deadline // 1000)
  local mid = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(2208)).msgTextID
  local str = (TextManager.GetText)(mid)
  str = (string.gsub)(str, "%$parameter1%$", d.year)
  str = (string.gsub)(str, "%$parameter2%$", d.month)
  str = (string.gsub)(str, "%$parameter3%$", d.day)
  str = (string.gsub)(str, "%$parameter4%$", (string.format)("%02d:%02d:%02d", d.hour, d.min, d.sec))
  ;
  (self._time):SetText(str)
  ;
  (self._price):SetText((self._returnBattlePass).chargePrice)
  local id = DataCommon.AgCoinActivityID
  local mgr = ((NekoData.BehaviorManager).BM_Activity):GetManager(id)
  self._info = mgr:GetBaseInfo()
  local items = {}
  for k,v in ipairs((self._returnBattlePass).highCollection) do
    if v.itemId > 0 then
      handleData(items, v.itemId, v.itemNum)
    end
  end
  local itemList = {}
  for k,v in pairs(items) do
    local item = (Item.Create)(k)
    item:SetCount(v)
    ;
    (table.insert)(itemList, item)
  end
  ;
  (table.sort)(itemList, function(aItem, bItem)
    -- function num : 0_5_0
    if bItem:GetID() >= aItem:GetID() then
      do return aItem:GetPinJiID() ~= bItem:GetPinJiID() end
      do return bItem:GetPinJiID() < aItem:GetPinJiID() end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  self._items = itemList
  ;
  (self._frame):ReloadAllCell()
end

ReturnBattlePassUnlockDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
  cmd.goodId = (self._returnBattlePass).goodId
  cmd:Send()
end

ReturnBattlePassUnlockDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._items
end

ReturnBattlePassUnlockDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "welfare.returnwelfare.returnbattlepassunlockitemcell"
end

ReturnBattlePassUnlockDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._items)[index]
end

ReturnBattlePassUnlockDialog.AddNewModal = function(self, dialog)
  -- function num : 0_10 , upvalues : _ENV, ShowByModalDialogs
  if (table.keyof)(ShowByModalDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

return ReturnBattlePassUnlockDialog

