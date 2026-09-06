local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local CLimitShopExhibit = BeanManager.GetTableByName("recharge.climitshopexhibit")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local Role = require("logic.manager.experimental.types.role")
local ShopTypeMap = DataCommon.Lover.Shop
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activityvalentines"
ShopMainDialog.AssetName = "ActivityValentinesShop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._shopMapData = {}
  self._currencyList = {
    DataCommon.LoveTownCurrency,
    DataCommon.LoveChocolate
  }
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
  self._init = false
end

function ShopMainDialog:OnCreate()
  self._switchBtns = {
    [ShopTypeMap.TownCurrency] = {
      btn = self:GetChild("Cutbtn1"),
      btnText = self:GetChild("Cutbtn1/_Text")
    },
    [ShopTypeMap.Chocolate] = {
      btn = self:GetChild("Cutbtn2"),
      btnText = self:GetChild("Cutbtn2/_Text"),
      redDot = self:GetChild("Cutbtn2/RedDot")
    }
  }
  for k, v in pairs(self._switchBtns) do
    local record = CShopTypeConfig:GetRecorder(k)
    v.btnText:SetText(TextManager.GetText(record.NameTextID))
    v.btn:Subscribe_PointerClickEvent(function()
      self:OnSwitchTypeBtnClicked(k)
    end)
  end
  self._timeTxt = self:GetChild("UI/ShopArea/Refresh/Txt")
  self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1696))
  self._tabPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._tabPanelBlack = self:GetChild("UI/ShopArea/CellFrameBlack")
  self._tabPanelBlackTxt = self:GetChild("UI/ShopArea/CellFrameBlack/Text")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX, self._offsetMaxY = self._currencyPanel:GetAnchorAndOffset()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._title = self:GetChild("Title")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1699))
  CanvasStaticFunctions.SetCanvasPixelPerfect(self._rootWindow._uiObject, false)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.SetTabPanelBlackActive, Common.n_LoverRefreshShopDisplay, nil)
end

function ShopMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._tabFrame:Destroy()
end

function ShopMainDialog:RefreshCurrencyPanel()
  self._currencyFrame:ReloadAllCell()
  local totalLength = self._currencyFrame:GetTotalLength()
  self._currencyPanel:SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMaxX - totalLength, self._offsetMinY, self._offsetMaxX, self._offsetMaxY)
  self._currencyFrame:ReloadAllCell()
end

local function RefreshByTab(self)
  self:SetTabPanelBlackActive()
  for k, v in pairs(self._switchBtns) do
    v.btn:SetSelected(k == self._selectShopId)
  end
  local tabCell = self._tabFrame:ToPage(self._selectShopId)
  tabCell:RefreshTabCell(self._shopMapData[self._selectShopId])
  if self._init then
  else
    self._init = true
  end
  self:RefreshCurrencyPanel()
end

function ShopMainDialog:OnBuyShopGood(notification)
  local shopId = notification.userInfo.shopId
  for k, v in pairs(DataCommon.Lover.Shop) do
    if v == shopId then
      self._shopMapData[shopId] = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(shopId)
      local tabCell = self._tabFrame:GetCellAtIndex(shopId)
      tabCell:RefreshTabCell(self._shopMapData[shopId], true)
      break
    end
  end
end

function ShopMainDialog:SetShopId(shopId)
  self._selectShopId = shopId
  self._shopMapData[shopId] = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(shopId)
  RefreshByTab(self)
  local str = TextManager.GetText(CStringres:GetRecorder(1719).msgTextID)
  self._tabPanelBlackTxt:SetText(str)
end

function ShopMainDialog:OnSwitchTypeBtnClicked(shopId)
  if shopId == ShopTypeMap.Chocolate and not NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) and self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab) then
    self._switchBtns[ShopTypeMap.Chocolate].redDot:SetActive(false)
    self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab)
    LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, self._bm.RedPointKey.Shop)
  end
  if self._selectShopId ~= shopId then
    if not self._shopMapData[shopId] then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = shopId
      protocol:Send()
      return
    else
      self._selectShopId = shopId
      RefreshByTab(self)
    end
  end
end

function ShopMainDialog:NumberOfCell(frame, index)
  return #self._currencyList
end

function ShopMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.lover.lovermoneynumcell"
  elseif frame == self._tabFrame then
    return "activity.lover.shoptabcell"
  end
end

function ShopMainDialog:DataAtIndex(frame, index)
  return self._currencyList[index]
end

function ShopMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShopMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ShopMainDialog:SetTabPanelBlackActive()
  if self._selectShopId == ShopTypeMap.Chocolate and NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) then
    self._tabPanelBlack:SetActive(true)
  else
    self._tabPanelBlack:SetActive(false)
  end
  if NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(ShopTypeMap.Chocolate) then
    self._switchBtns[ShopTypeMap.Chocolate].redDot:SetActive(false)
  else
    self._switchBtns[ShopTypeMap.Chocolate].redDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab))
  end
end

return ShopMainDialog
