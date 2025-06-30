-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/shopmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local CLimitShopExhibit = (BeanManager.GetTableByName)("recharge.climitshopexhibit")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local ShopTypeMap = (DataCommon.Lover).Shop
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activityvalentines"
ShopMainDialog.AssetName = "ActivityValentinesShop"
ShopMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMainDialog, _ENV
  ((ShopMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._shopMapData = {}
  self._currencyList = {DataCommon.LoveTownCurrency, DataCommon.LoveChocolate}
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.LoverActivityManagerID)
  self._init = false
end

ShopMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ShopTypeMap, _ENV, CShopTypeConfig, TabFrame, TableFrame, CanvasStaticFunctions
  self._switchBtns = {
[ShopTypeMap.TownCurrency] = {btn = self:GetChild("Cutbtn1"), btnText = self:GetChild("Cutbtn1/_Text")}
, 
[ShopTypeMap.Chocolate] = {btn = self:GetChild("Cutbtn2"), btnText = self:GetChild("Cutbtn2/_Text"), redDot = self:GetChild("Cutbtn2/RedDot")}
}
  for k,v in pairs(self._switchBtns) do
    do
      local record = CShopTypeConfig:GetRecorder(k)
      ;
      (v.btnText):SetText((TextManager.GetText)(record.NameTextID))
      ;
      (v.btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    self:OnSwitchTypeBtnClicked(k)
  end
)
    end
  end
  self._timeTxt = self:GetChild("UI/ShopArea/Refresh/Txt")
  ;
  (self._timeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1696))
  self._tabPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._tabPanelBlack = self:GetChild("UI/ShopArea/CellFrameBlack")
  self._tabPanelBlackTxt = self:GetChild("UI/ShopArea/CellFrameBlack/Text")
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._anchorMinX = (self._currencyPanel):GetAnchorAndOffset()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._title = self:GetChild("Title")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1699))
  ;
  (CanvasStaticFunctions.SetCanvasPixelPerfect)((self._rootWindow)._uiObject, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetTabPanelBlackActive, Common.n_LoverRefreshShopDisplay, nil)
end

ShopMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
  ;
  (self._tabFrame):Destroy()
end

ShopMainDialog.RefreshCurrencyPanel = function(self)
  -- function num : 0_3
  (self._currencyFrame):ReloadAllCell()
  local totalLength = (self._currencyFrame):GetTotalLength()
  ;
  (self._currencyPanel):SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMaxX - totalLength, self._offsetMinY, self._offsetMaxX, self._offsetMaxY)
  ;
  (self._currencyFrame):ReloadAllCell()
end

local RefreshByTab = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:SetTabPanelBlackActive()
  for k,v in pairs(self._switchBtns) do
    (v.btn):SetSelected(k == self._selectShopId)
  end
  local tabCell = (self._tabFrame):ToPage(self._selectShopId)
  tabCell:RefreshTabCell((self._shopMapData)[self._selectShopId])
  if self._init then
    self._init = true
    self:RefreshCurrencyPanel()
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

ShopMainDialog.OnBuyShopGood = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local shopId = (notification.userInfo).shopId
  for k,v in pairs((DataCommon.Lover).Shop) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    if v == shopId then
      (self._shopMapData)[shopId] = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(shopId)
      local tabCell = (self._tabFrame):GetCellAtIndex(shopId)
      tabCell:RefreshTabCell((self._shopMapData)[shopId], true)
      break
    end
  end
end

ShopMainDialog.SetShopId = function(self, shopId)
  -- function num : 0_6 , upvalues : _ENV, RefreshByTab, CStringres
  self._selectShopId = shopId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._shopMapData)[shopId] = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(shopId)
  RefreshByTab(self)
  local str = (TextManager.GetText)((CStringres:GetRecorder(1719)).msgTextID)
  ;
  (self._tabPanelBlackTxt):SetText(str)
end

ShopMainDialog.OnSwitchTypeBtnClicked = function(self, shopId)
  -- function num : 0_7 , upvalues : ShopTypeMap, _ENV, RefreshByTab
  if shopId == ShopTypeMap.Chocolate and not ((NekoData.BehaviorManager).BM_Shop):GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) and (self._bm):GetRedPointWithLocalKey(((self._bm).RedPointKey).ShopChocolateTab) then
    (((self._switchBtns)[ShopTypeMap.Chocolate]).redDot):SetActive(false)
    ;
    (self._bm):SetRedPointWithLocalKey(((self._bm).RedPointKey).ShopChocolateTab)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_LoverRefreshRedPoint, nil, ((self._bm).RedPointKey).Shop)
  end
  if self._selectShopId ~= shopId then
    if not (self._shopMapData)[shopId] then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
      protocol.shopId = shopId
      protocol:Send()
      return 
    else
      do
        self._selectShopId = shopId
        RefreshByTab(self)
      end
    end
  end
end

ShopMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._currencyList
end

ShopMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._currencyFrame then
    return "activity.lover.lovermoneynumcell"
  else
    if frame == self._tabFrame then
      return "activity.lover.shoptabcell"
    end
  end
end

ShopMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._currencyList)[index]
end

ShopMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

ShopMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ShopMainDialog.SetTabPanelBlackActive = function(self)
  -- function num : 0_13 , upvalues : ShopTypeMap, _ENV
  if self._selectShopId == ShopTypeMap.Chocolate and ((NekoData.BehaviorManager).BM_Shop):GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) then
    (self._tabPanelBlack):SetActive(true)
  else
    ;
    (self._tabPanelBlack):SetActive(false)
  end
  if ((NekoData.BehaviorManager).BM_Shop):GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) then
    (((self._switchBtns)[ShopTypeMap.Chocolate]).redDot):SetActive(false)
  else
    ;
    (((self._switchBtns)[ShopTypeMap.Chocolate]).redDot):SetActive((self._bm):GetRedPointWithLocalKey(((self._bm).RedPointKey).ShopChocolateTab))
  end
end

return ShopMainDialog

