local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CCommissaryShow = BeanManager.GetTableByName("recharge.ccommissaryshow")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CShopTypeConfig = BeanManager.GetTableByName("recharge.cshoptypeconfig")
local Type2Record = CShopTypeConfig:GetRecorder(DataCommon.SummerEchoesShopID3)
local BottomToTop = 3
local ColumnNum = 4
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
ShopMainDialog.AssetName = "ActivitySummer2Shop"

function ShopMainDialog:Ctor(...)
  ShopMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._currencyData = {}
  self._shopData = {}
end

function ShopMainDialog:OnCreate()
  self._roleLive2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._shopLimitText = self:GetChild("UI/ShopArea/Refresh/Txt")
  self._title = self:GetChild("Title")
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
  self._cutbtn1 = self:GetChild("UI/Cutbtn1")
  self._cutbtn2 = self:GetChild("UI/Cutbtn2")
  self._cutbtn2_text = self:GetChild("UI/Cutbtn2/_Text")
  self._cutbtn1:Subscribe_PointerClickEvent(function()
    self:ShopBtnClicked(1)
  end, self)
  self._cutbtn2:Subscribe_PointerClickEvent(function()
    self:ShopBtnClicked(2)
  end, self)
  LuaNotificationCenter.AddObserver(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2145))
end

function ShopMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  self._goodsFrame:Destroy()
end

local function GetDateMap(str)
  local strList1 = string.split(str, " ")
  local dateList = string.split(strList1[1], "-")
  local timeList = string.split(strList1[2], ":")
  return {
    year = dateList[1],
    month = dateList[2],
    day = dateList[3],
    hour = timeList[1],
    min = timeList[2],
    sec = timeList[3]
  }
end

function ShopMainDialog:ShopBtnClicked(shopType)
  local shopAdditionData = self._bm:GetShopAdditionData()
  if shopAdditionData then
    if shopType == 1 then
      local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
      if csend then
        csend.constructionID = shopAdditionData.constructionID
        csend.eventID = shopAdditionData.functionIDs[1]
        csend:Send()
      end
    else
      local openTime = os.time(GetDateMap(Type2Record.OpenTime))
      local curTime = os.time(ServerGameTimer.GetDateForecast())
      local shopAdditionData = self._bm:GetShopAdditionData()
      local eventIds = shopAdditionData.functionIDs
      if not eventIds[2] or openTime > curTime then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100494)
        return
      end
      local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
      if csend then
        csend.constructionID = shopAdditionData.constructionID
        csend.eventID = shopAdditionData.functionIDs[2]
        csend:Send()
      end
    end
  end
end

function ShopMainDialog:SetData(shopID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID)
  if DataCommon.SummerEchoesShopID2 == shopID or DataCommon.SummerEchoesShopID3 == shopID then
    self._shopID = shopID
    self._cutbtn1:SetSelected(DataCommon.SummerEchoesShopID2 == shopID)
    self._cutbtn2:SetSelected(DataCommon.SummerEchoesShopID3 == shopID)
    self:RefreshRoleData()
    self:RefreshCurrencyData()
    self:RefreshGoodsData()
    self:RefreshTabData()
  end
end

function ShopMainDialog:RefreshTabData()
  local shopAdditionData = self._bm:GetShopAdditionData()
  local eventIds = shopAdditionData.functionIDs
  if not eventIds[2] then
    self._cutbtn2_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2152))
  else
    self._cutbtn2_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2144))
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
end

function ShopMainDialog:RefreshCurrencyData()
  for key, _ in pairs(self._currencyData) do
    self._currencyData[key] = nil
  end
  table.insert(self._currencyData, DataCommon.SummerEchoesCurrency1)
  table.insert(self._currencyData, DataCommon.SummerEchoesCurrency2)
  self._currencyFrame:ReloadAllCell()
end

function ShopMainDialog:RefreshGoodsData(notChangePos)
  self._shopData[self._shopID] = NekoData.BehaviorManager.BM_Shop:GetShopGoodInfoByID(self._shopID)
  self._shopLimitText:SetText(TextManager.GetText(CStringRes:GetRecorder(2151).msgTextID))
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
    return "activity.swimsuitechoes.shopcurrencycell"
  elseif frame == self._goodsFrame then
    return "activity.swimsuitechoes.shopgoodscell"
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
