local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local CLimitShopExhibit = BeanManager.GetTableByName("recharge.climitshopexhibit")
local Role = require("logic.manager.experimental.types.role")
local ShopTypeMap = DataCommon.StarMirage.Shop
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activitystar"
ShopMainDialog.AssetName = "ActivityStarShop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._shopMapData = {}
  self._currencyList = {}
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.StarMirageManagerID)
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
    [ShopTypeMap.EasyId] = self:GetChild("UI/DetailArea/TypeBtn"),
    [ShopTypeMap.HardId] = self:GetChild("UI/DetailArea/TypeBtn2")
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
  if self._selectShopId == ShopTypeMap.HardId then
    table.insert(self._currencyList, DataCommon.RedStarCoin)
  else
    table.insert(self._currencyList, DataCommon.StarCoin)
  end
  self._currencyFrame:ReloadAllCell()
  local totalLength = self._currencyFrame:GetTotalLength()
  self._currencyPanel:SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMaxX - totalLength, self._offsetMinY, self._offsetMaxX, self._offsetMaxY)
  self._currencyFrame:ReloadAllCell()
end

local function RefreshByTab(self)
  self._timePanel:SetActive(false)
  if self._selectShopId == ShopTypeMap.EasyId then
    self._switchBtns[ShopTypeMap.EasyId]:SetActive(false)
    self._switchBtns[ShopTypeMap.HardId]:SetActive(true)
  elseif self._selectShopId == ShopTypeMap.HardId then
    self._switchBtns[ShopTypeMap.EasyId]:SetActive(true)
    self._switchBtns[ShopTypeMap.HardId]:SetActive(false)
  end
  if self._selectShopId == ShopTypeMap.EasyId then
    self._easy_background:SetActive(true)
    self._easy_back:SetActive(true)
    self._easy_detailBack:SetActive(true)
    self._hard_background:SetActive(false)
    self._hard_back:SetActive(false)
    self._hard_detailBack:SetActive(false)
  elseif self._selectShopId == ShopTypeMap.HardId then
    self._easy_background:SetActive(false)
    self._easy_back:SetActive(false)
    self._easy_detailBack:SetActive(false)
    self._hard_background:SetActive(true)
    self._hard_back:SetActive(true)
    self._hard_detailBack:SetActive(true)
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
  self._timeTxt:SetText(string.gsub(TextManager.GetText(1900583), "%$parameter1%$", record.CloseTime))
  local rolePosRecord = CLimitShopExhibit:GetRecorder(self._selectShopId)
  self._title:SetText(TextManager.GetText(rolePosRecord.shoptitletxt))
  if not self._roleId or self._roleId ~= record.Giftdollid then
    self._roleId = record.Giftdollid
    self._rolePanel:SetAnimatorTrigger("loadReady")
    if self._handler then
      self._live2D:Release(self._handler)
      self._handler = nil
    end
    local role = Role.Create(record.Giftdollid)
    local list = string.split(rolePosRecord.rolepos, ",")
    self._rolePanel:SetAnchoredPosition(tonumber(list[1]), tonumber(list[2]))
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
  for k, v in pairs(DataCommon.StarMirage.Shop) do
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

function ShopMainDialog:OnSwitchTypeBtnClicked()
  if self._selectShopId == ShopTypeMap.EasyId then
    if not self._shopMapData[ShopTypeMap.HardId] then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = ShopTypeMap.HardId
      protocol:Send()
      return
    else
      self._selectShopId = ShopTypeMap.HardId
    end
  elseif self._selectShopId == ShopTypeMap.HardId then
    if not self._shopMapData[ShopTypeMap.EasyId] then
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
      protocol.shopId = ShopTypeMap.EasyId
      protocol:Send()
      return
    else
      self._selectShopId = ShopTypeMap.EasyId
    end
  end
  RefreshByTab(self)
end

function ShopMainDialog:NumberOfCell(frame, index)
  return #self._currencyList
end

function ShopMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.starmirage.currencycell"
  elseif frame == self._tabFrame then
    return "activity.starmirage.shoptabcell"
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
