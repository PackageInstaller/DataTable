local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local CLimitShopExhibit = BeanManager.GetTableByName("recharge.climitshopexhibit")
local Role = require("logic.manager.experimental.types.role")
local ShopTypeMap = DataCommon.Christmas.Shop
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activitychristmas"
ShopMainDialog.AssetName = "ActivityChristmasShop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._shopMapData = {}
  self._currencyList = {
    DataCommon.ChristmasSing,
    DataCommon.ChristmasJump,
    DataCommon.ChristmasExpressiveForce
  }
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
  self._init = false
end

function ShopMainDialog:OnCreate()
  self._switchBtns = {
    [ShopTypeMap.Sing] = {
      btn = self:GetChild("Cutbtn1"),
      btnText = self:GetChild("Cutbtn1/_Text")
    },
    [ShopTypeMap.Jump] = {
      btn = self:GetChild("Cutbtn2"),
      btnText = self:GetChild("Cutbtn2/_Text")
    },
    [ShopTypeMap.ExpressiveForce] = {
      btn = self:GetChild("Cutbtn3"),
      btnText = self:GetChild("Cutbtn3/_Text")
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
  self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1694))
  self._tabPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX, self._offsetMaxY = self._currencyPanel:GetAnchorAndOffset()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._title = self:GetChild("Title")
  self._title:SetText(TextManager.GetText(1901205))
  CanvasStaticFunctions.SetCanvasPixelPerfect(self._rootWindow._uiObject, false)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
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
  for k, v in pairs(DataCommon.Christmas.Shop) do
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
end

function ShopMainDialog:OnSwitchTypeBtnClicked(shopId)
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
    return "activity.starmirage.currencycell"
  elseif frame == self._tabFrame then
    return "activity.christmas.shoptabcell"
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

return ShopMainDialog
