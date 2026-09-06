local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local Role = require("logic.manager.experimental.types.role")
local ShopTypeMap = DataCommon.Anniversary.Shop
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
ShopMainDialog.AssetName = "Activity1YearAnniversaryShop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._shopMapData = {}
  self._currencyList = {}
  self._bm = NekoData.BehaviorManager.BM_Anniversary
  self._init = false
end

function ShopMainDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._jobTxt = self:GetChild("UI/DetailArea/JobTxt")
  self._name = self:GetChild("UI/DetailArea/Name")
  self._rank = self:GetChild("UI/DetailArea/Rank")
  self._timePanel = self:GetChild("UI/DetailArea/Time")
  self._timePanel_txt = self:GetChild("UI/DetailArea/Time/Time")
  self._switchBtns = {}
  self._switchBtns = {
    [ShopTypeMap.Easy] = self:GetChild("UI/DetailArea/TypeBtn"),
    [ShopTypeMap.Hard] = self:GetChild("UI/DetailArea/TypeBtn2")
  }
  for k, v in pairs(self._switchBtns) do
    v:Subscribe_PointerClickEvent(function()
      self:OnSwitchTypeBtnClicked(k)
    end)
  end
  self._timeTxt = self:GetChild("UI/ShopArea/Refresh/Time")
  self._tabPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX, self._offsetMaxY = self._currencyPanel:GetAnchorAndOffset()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._easy_background = self:GetChild("Background")
  self._easy_back = self:GetChild("Back1")
  self._easy_detailBack = self:GetChild("UI/DetailArea/Back2")
  self._hard_background = self:GetChild("BackgroundHard")
  self._hard_back = self:GetChild("Back1Hard")
  self._hard_detailBack = self:GetChild("UI/DetailArea/Back2Hard")
  self._title = self:GetChild("UI/DetailArea/Title")
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2014))
  self._timeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2015))
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2000))
  self:GetChild("UI/ShopArea/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2073))
  self:GetChild("UI/DetailArea/TypeBtn/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2016))
  self:GetChild("UI/DetailArea/TypeBtn2/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2017))
end

function ShopMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._tabFrame:Destroy()
end

function ShopMainDialog:RefreshCurrencyPanel()
  while self._currencyList[#self._currencyList] do
    table.remove(self._currencyList, #self._currencyList)
  end
  if self._selectShopId == ShopTypeMap.Hard then
    table.insert(self._currencyList, DataCommon.AnniversaryCoin_Hard)
  else
    table.insert(self._currencyList, DataCommon.AnniversaryCoin_Easy)
  end
  self._currencyFrame:ReloadAllCell()
  local totalLength = self._currencyFrame:GetTotalLength()
  self._currencyPanel:SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMaxX - totalLength, self._offsetMinY, self._offsetMaxX, self._offsetMaxY)
  self._currencyFrame:ReloadAllCell()
end

local function RefreshByTab(self)
  self._timePanel:SetActive(false)
  if self._selectShopId == ShopTypeMap.Easy then
    self._easy_background:SetActive(true)
    self._easy_back:SetActive(true)
    self._easy_detailBack:SetActive(true)
    self._hard_background:SetActive(false)
    self._hard_back:SetActive(false)
    self._hard_detailBack:SetActive(false)
    self._switchBtns[ShopTypeMap.Easy]:SetSelected(true)
    self._switchBtns[ShopTypeMap.Hard]:SetSelected(false)
  elseif self._selectShopId == ShopTypeMap.Hard then
    self._easy_background:SetActive(false)
    self._easy_back:SetActive(false)
    self._easy_detailBack:SetActive(false)
    self._hard_background:SetActive(true)
    self._hard_back:SetActive(true)
    self._hard_detailBack:SetActive(true)
    self._switchBtns[ShopTypeMap.Easy]:SetSelected(false)
    self._switchBtns[ShopTypeMap.Hard]:SetSelected(true)
  end
  local tabCell = self._tabFrame:ToPage(self._selectShopId)
  tabCell:RefreshTabCell(self._shopMapData[self._selectShopId])
  if self._init then
    self._rootWindow:PlayAnimation("shopSwitch")
    tabCell._panel:PlayAnimation("shopCellSwitch")
  else
    self._init = true
  end
  local record = CShopTypeConfig:GetRecorder(self._selectShopId)
  if not self._roleId or self._roleId ~= record.Giftdollid then
    self._roleId = record.Giftdollid
    self._rolePanel:SetAnimatorTrigger("loadReady")
    if self._handler then
      self._live2D:Release(self._handler)
      self._handler = nil
    end
    local role = Role.Create(record.Giftdollid)
    local record = role:GetShapeLive2DRecord()
    if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
      self._photo:SetActive(false)
      self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      self._photo:SetActive(true)
      local recorder = role:GetShapeLiHuiImageRecord()
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local photoScale = role:GetPhotoScale()
      self._photo:SetLocalScale(photoScale, photoScale, photoScale)
      local photoPos = role:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
    self._jobTxt:SetText(role:GetVocationName())
    self._name:SetText(role:GetRoleName())
    self._rank:SetSprite(role:GetRoleInfoRarityImageRecord().assetBundle, role:GetRoleInfoRarityImageRecord().assetName)
  end
  self:RefreshCurrencyPanel()
end

function ShopMainDialog:OnBuyShopGood(notification)
  local shopId = notification.userInfo.shopId
  for k, v in pairs(DataCommon.Anniversary.Shop) do
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

function ShopMainDialog:OnSwitchTypeBtnClicked(type)
  if self._selectShopId == type then
    return
  end
  if type == ShopTypeMap.Hard and self._bm:IsUnlockFunctionById(DataCommon.Anniversary.Function.Hard) ~= 1 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100491)
    return
  end
  if self._selectShopId == ShopTypeMap.Easy then
    if not self._shopMapData[ShopTypeMap.Hard] then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = ShopTypeMap.Hard
      protocol:Send()
      return
    else
      self._selectShopId = ShopTypeMap.Hard
    end
  elseif self._selectShopId == ShopTypeMap.Hard then
    if not self._shopMapData[ShopTypeMap.Easy] then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = ShopTypeMap.Easy
      protocol:Send()
      return
    else
      self._selectShopId = ShopTypeMap.Easy
    end
  end
  RefreshByTab(self)
end

function ShopMainDialog:NumberOfCell(frame, index)
  return #self._currencyList
end

function ShopMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.anniversary.currencycell"
  elseif frame == self._tabFrame then
    return "activity.anniversary.shoptabcell"
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
