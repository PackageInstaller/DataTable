local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CCommissaryShow = BeanManager.GetTableByName("recharge.ccommissaryshow")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BottomToTop = 3
local ColumnNum = 4
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activitysummer"
ShopMainDialog.AssetName = "ActivitySummerShop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._currencyData = {}
  self._shopData = {}
end

function ShopMainDialog:OnCreate()
  self._roleLive2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._roleName = self:GetChild("UI/DetailArea/Name")
  self._roleJob = self:GetChild("UI/DetailArea/JobTxt")
  self._roleRank = self:GetChild("UI/DetailArea/Rank")
  self._shopLimitText = self:GetChild("UI/ShopArea/Refresh/Txt")
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._goodsPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._scrollBar = self:GetChild("UI/ShopArea/Scrollbar")
  self._levelUpTip = self:GetChild("UI/ShopArea/Tip")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false, true)
  self._goodsFrame = GridFrame.Create(self._goodsPanel, self, true, ColumnNum, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
end

function ShopMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._goodsFrame:Destroy()
end

function ShopMainDialog:SetData(shopID)
  if DataCommon.SwimSuitActivity.Shop.ShopID == shopID then
    self._shopID = shopID
    local dialogName = "activity.swimsuit.buydialog"
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      self._shopLevel = dialog._shopLevel
    end
    if self._shopLevel and self._shopLevel == 1 or self._shopLevel == 2 then
      self._levelUpTip:SetActive(true)
      self._levelUpTip:SetText(TextManager.GetText(701473))
    else
      self._levelUpTip:SetActive(false)
    end
    self:RefreshRoleData()
    self:RefreshCurrencyData()
    self:RefreshGoodsData()
  end
end

function ShopMainDialog:RefreshRoleData()
  local roleID = CCommissaryShow:GetRecorder(1).roleID
  local fashionID = CCommissaryShow:GetRecorder(1).fashionID
  local role = Role.Create(roleID)
  role:SetFashionId(fashionID)
  if self._live2DHandler then
    self._roleLive2D:Release(self._live2DHandler)
    self._live2DHandler = nil
  end
  local live2dRecord = role:GetShapeLive2DRecord()
  if role:IsFashionLive2D() and Live2DManager.CanUse() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
    self._rolePhoto:SetActive(false)
    self._live2DHandler = self._roleLive2D:AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
    self._roleLive2D:SetLive2DAnimatorInteger(self._live2DHandler, "isLoop", 1)
  else
    local lihuiImage = role:GetShapeLiHuiImageRecord()
    self._rolePhoto:SetActive(true)
    self._rolePhoto:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = role:GetPhotoScale()
    self._rolePhoto:SetLocalScale(scale, scale, scale)
    local photoPos = role:GetPhotoPosition()
    self._rolePhoto:SetAnchoredPosition(photoPos[1], photoPos[2])
  end
  self._roleName:SetText(role:GetRoleName())
  self._roleJob:SetText(role:GetVocationName())
  local rankRecord = role:GetRoleInfoRarityImageRecord()
  self._roleRank:SetSprite(rankRecord.assetBundle, rankRecord.assetName)
end

function ShopMainDialog:RefreshCurrencyData()
  for key, _ in pairs(self._currencyData) do
    self._currencyData[key] = nil
  end
  table.insert(self._currencyData, DataCommon.SwimSuitCoinConch)
  table.insert(self._currencyData, DataCommon.SwimSuitCoinPearl)
  table.insert(self._currencyData, DataCommon.SwimSuitCoinCoral)
  table.insert(self._currencyData, DataCommon.CatClaw)
  self._currencyFrame:ReloadAllCell()
end

function ShopMainDialog:RefreshGoodsData(notChangePos)
  self._shopData[self._shopID] = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._shopID)
  self._shopLimitText:SetText(TextManager.GetText(CStringRes:GetRecorder(1603).msgTextID))
  local lastPos = self._goodsFrame:GetCurrentPosition()
  self._goodsFrame:ReloadAllCell()
  if notChangePos and lastPos then
    self._goodsFrame:MoveToAssignedPos(lastPos)
  end
end

function ShopMainDialog:OnBuyShopGood(notification)
  if notification.userInfo.shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

function ShopMainDialog:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencyData
  elseif frame == self._goodsFrame then
    return #self._shopData[self._shopID]
  end
end

function ShopMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "activity.swimsuit.shopcurrencycell"
  elseif frame == self._goodsFrame then
    return "activity.swimsuit.shopgoodscell"
  end
end

function ShopMainDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencyData[index]
  elseif frame == self._goodsFrame then
    return self._shopData[self._shopID][index]
  end
end

function ShopMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ShopMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ShopMainDialog:OnCurPosChange(frame, proportion)
  local width, height = self._goodsPanel:GetRectSize()
  local total = self._goodsFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return ShopMainDialog
