-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/equipboxbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CEquipBox = (BeanManager.GetTableByName)("recharge.cequipbox")
local EquipBoxBuyDialog = class("EquipBoxBuyDialog", Dialog)
EquipBoxBuyDialog.AssetBundleName = "ui/layouts.baseshop"
EquipBoxBuyDialog.AssetName = "TowerLegendBox"
EquipBoxBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBoxBuyDialog
  ((EquipBoxBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._itemData = {}
  self._showEquipMaxLevel = true
end

EquipBoxBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._title = self:GetChild("Name")
  self._detail = self:GetChild("Detail")
  self._itemPanel = self:GetChild("ItemFrame")
  self._boxImg = self:GetChild("Box")
  self._buyBtn = self:GetChild("BuyBtn")
  self._price = self:GetChild("Price/Price")
  self._priceImg = self:GetChild("Price/Image")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._detailBtn = self:GetChild("DetailBtn")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._refreshTime = self:GetChild("Refresh/Time")
  self._stock = self:GetChild("Num")
  self._stockNum = self:GetChild("Num/Num")
  self._topGroup = self:GetChild("TopGroup")
  self._topGroupFrame = (TableFrame.Create)(self._topGroup, self, false, false, true)
  self._frame = (TableFrame.Create)(self._itemPanel, self, false, true)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._detailBtn):Subscribe_PointerClickEvent(self.OnDetailBtnClicked, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnClickLeftBtn, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnClickRightBtn, self)
  ;
  (self._leftArrow):SetActive(false)
  ;
  (self._rightArrow):SetActive(false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyEquipChest, Common.n_BuyEquipChest, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTopGroundFrame, Common.n_RefreshCurrency, nil)
end

EquipBoxBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._topGroupFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
  if dialog then
    dialog:OnGroupBtnClicked(self._shopID)
  end
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

EquipBoxBuyDialog.InitData = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CStringRes, CEquipBox
  self._shopID = 16
  self._data = data
  local item = (Item.Create)((self._data).realBox)
  local imageRecord = item:GetIcon()
  ;
  (self._boxImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._title):SetText(item:GetName())
  ;
  (self._detail):SetText(item:GetDestribe())
  item = (Item.Create)((self._data).currencyType)
  imageRecord = item:GetIcon()
  ;
  (self._priceImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._price):SetText((self._data).price)
  local time = (self._data).ddlTime // 1000
  local day = time // 86400
  time = time % 86400
  local hour = time // 3600
  time = time % 3600
  local min = time // 60
  local str = nil
  str = (TextManager.GetText)((CStringRes:GetRecorder(1126)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", day)
  str = (string.gsub)(str, "%$parameter2%$", hour)
  str = (string.gsub)(str, "%$parameter3%$", min)
  ;
  (self._refreshTime):SetText(str)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  if (self._data).ddlTime ~= 0 then
    self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:CountDown()
  end
, nil)
  end
  ;
  (self._stock):SetActive((self._data).remainChance ~= -1)
  ;
  (self._stockNum):SetText((self._data).remainChance)
  if (self._data).remainChance == 0 then
    (self._buyBtn):SetInteractable(false)
  else
    (self._buyBtn):SetInteractable(true)
  end
  local recorder = CEquipBox:GetRecorder((self._data).realBox)
  self._itemData = recorder.ShowItems
  ;
  (self._frame):ReloadAllCell()
  self._moneyTypeInfo = {
{moneyType = (self._data).currencyType}
}
  ;
  (self._topGroupFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

EquipBoxBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
  if protocol then
    protocol.shopId = 16
    local map = {}
    map[(self._data).chestID] = 1
    protocol.goods = map
    protocol:Send()
  end
end

EquipBoxBuyDialog.OnDetailBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("shop.towerlegenddetaildialog")
  if dialog then
    dialog:SetData((self._data).realBox)
  end
end

EquipBoxBuyDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_6
  self:Destroy()
end

EquipBoxBuyDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

EquipBoxBuyDialog.OnBuyEquipChest = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  local key = (((notification.userInfo).equipments)[1]).id
  ;
  ((DialogManager.CreateSingletonDialog)("shop.towerlegendboxbuydialog")):Init(key)
  ;
  (self._stockNum):SetText((notification.userInfo).remain)
end

EquipBoxBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._topGroupFrame then
    return #self._moneyTypeInfo
  else
    return #self._itemData
  end
end

EquipBoxBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._topGroupFrame then
    return "shop.shoptopgroupcell"
  else
    return "shop.equipboxitemcell"
  end
end

EquipBoxBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._topGroupFrame then
    return (self._moneyTypeInfo)[index]
  else
    return (self._itemData)[index]
  end
end

EquipBoxBuyDialog.CountDown = function(self)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).ddlTime = (self._data).ddlTime - 1000
  if (self._data).ddlTime < 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetequipchestinfo")
    if protocol then
      protocol.chestID = (self._data).chestID
      protocol:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

EquipBoxBuyDialog.RefreshTopGroundFrame = function(self)
  -- function num : 0_13
  (self._topGroupFrame):ReloadAllCell()
end

return EquipBoxBuyDialog

