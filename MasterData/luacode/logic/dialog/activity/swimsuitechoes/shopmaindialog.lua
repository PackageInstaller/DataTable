-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/shopmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CCommissaryShow = (BeanManager.GetTableByName)("recharge.ccommissaryshow")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local Type2Record = CShopTypeConfig:GetRecorder(DataCommon.SummerEchoesShopID3)
local BottomToTop = 3
local ColumnNum = 4
local ShopMainDialog = class("ShopMainDialog", Dialog)
ShopMainDialog.AssetBundleName = "ui/layouts.activitysummer2"
ShopMainDialog.AssetName = "ActivitySummer2Shop"
ShopMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopMainDialog
  ((ShopMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currencyData = {}
  self._shopData = {}
end

ShopMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, GridFrame, ColumnNum, _ENV
  self._roleLive2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  self._shopLimitText = self:GetChild("UI/ShopArea/Refresh/Txt")
  self._title = self:GetChild("Title")
  self._currencyPanel = self:GetChild("UI/TopGroup")
  self._goodsPanel = self:GetChild("UI/ShopArea/CellFrame")
  self._scrollBar = self:GetChild("UI/ShopArea/Scrollbar")
  self._levelUpTip = self:GetChild("UI/ShopArea/Tip")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false, true)
  self._goodsFrame = (GridFrame.Create)(self._goodsPanel, self, true, ColumnNum, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._cutbtn1 = self:GetChild("UI/Cutbtn1")
  self._cutbtn2 = self:GetChild("UI/Cutbtn2")
  self._cutbtn2_text = self:GetChild("UI/Cutbtn2/_Text")
  ;
  (self._cutbtn1):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:ShopBtnClicked(1)
  end
, self)
  ;
  (self._cutbtn2):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:ShopBtnClicked(2)
  end
, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBuyShopGood, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyData, Common.n_RefreshCurrency, nil)
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2145))
end

ShopMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
  ;
  (self._goodsFrame):Destroy()
end

local GetDateMap = function(str)
  -- function num : 0_3 , upvalues : _ENV
  local strList1 = (string.split)(str, " ")
  local dateList = (string.split)(strList1[1], "-")
  local timeList = (string.split)(strList1[2], ":")
  return {year = dateList[1], month = dateList[2], day = dateList[3], hour = timeList[1], min = timeList[2], sec = timeList[3]}
end

ShopMainDialog.ShopBtnClicked = function(self, shopType)
  -- function num : 0_4 , upvalues : _ENV, GetDateMap, Type2Record
  local shopAdditionData = (self._bm):GetShopAdditionData()
  if shopAdditionData then
    if shopType == 1 then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummerechoevent")
      if csend then
        csend.constructionID = shopAdditionData.constructionID
        csend.eventID = (shopAdditionData.functionIDs)[1]
        csend:Send()
      end
    else
      do
        local openTime = (os.time)(GetDateMap(Type2Record.OpenTime))
        local curTime = (os.time)((ServerGameTimer.GetDateForecast)())
        local shopAdditionData = (self._bm):GetShopAdditionData()
        local eventIds = shopAdditionData.functionIDs
        if not eventIds[2] or curTime < openTime then
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100494)
          return 
        end
        local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummerechoevent")
        if csend then
          csend.constructionID = shopAdditionData.constructionID
          csend.eventID = (shopAdditionData.functionIDs)[2]
          csend:Send()
        end
      end
    end
  end
end

ShopMainDialog.SetData = function(self, shopID)
  -- function num : 0_5 , upvalues : _ENV
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)
  if DataCommon.SummerEchoesShopID2 == shopID or DataCommon.SummerEchoesShopID3 == shopID then
    self._shopID = shopID
    ;
    (self._cutbtn1):SetSelected(DataCommon.SummerEchoesShopID2 == shopID)
    ;
    (self._cutbtn2):SetSelected(DataCommon.SummerEchoesShopID3 == shopID)
    self:RefreshRoleData()
    self:RefreshCurrencyData()
    self:RefreshGoodsData()
    self:RefreshTabData()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ShopMainDialog.RefreshTabData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local shopAdditionData = (self._bm):GetShopAdditionData()
  local eventIds = shopAdditionData.functionIDs
  if not eventIds[2] then
    (self._cutbtn2_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2152))
  else
    ;
    (self._cutbtn2_text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2144))
  end
end

ShopMainDialog.RefreshRoleData = function(self)
  -- function num : 0_7 , upvalues : CCommissaryShow, Role, _ENV
  local roleID = (CCommissaryShow:GetRecorder(1)).roleID
  local fashionID = (CCommissaryShow:GetRecorder(1)).fashionID
  local role = (Role.Create)(roleID)
  role:SetFashionId(fashionID)
  if self._live2DHandler then
    (self._roleLive2D):Release(self._live2DHandler)
    self._live2DHandler = nil
  end
  local live2dRecord = role:GetShapeLive2DRecord()
  if role:IsFashionLive2D() and (Live2DManager.CanUse)() and live2dRecord.live2DPrefabName and live2dRecord.live2DAssetBundleName then
    (self._rolePhoto):SetActive(false)
    self._live2DHandler = (self._roleLive2D):AddLive2D(live2dRecord.live2DAssetBundleName, live2dRecord.live2DPrefabName, live2dRecord.live2DScale)
    ;
    (self._roleLive2D):SetLive2DAnimatorInteger(self._live2DHandler, "isLoop", 1)
  else
    local lihuiImage = role:GetShapeLiHuiImageRecord()
    ;
    (self._rolePhoto):SetActive(true)
    ;
    (self._rolePhoto):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = role:GetPhotoScale()
    ;
    (self._rolePhoto):SetLocalScale(scale, scale, scale)
    local photoPos = role:GetPhotoPosition()
    ;
    (self._rolePhoto):SetAnchoredPosition(photoPos[1], photoPos[2])
  end
end

ShopMainDialog.RefreshCurrencyData = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for key,_ in pairs(self._currencyData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._currencyData)[key] = nil
  end
  ;
  (table.insert)(self._currencyData, DataCommon.SummerEchoesCurrency1)
  ;
  (table.insert)(self._currencyData, DataCommon.SummerEchoesCurrency2)
  ;
  (self._currencyFrame):ReloadAllCell()
end

ShopMainDialog.RefreshGoodsData = function(self, notChangePos)
  -- function num : 0_9 , upvalues : _ENV, CStringRes
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  (self._shopData)[self._shopID] = ((NekoData.BehaviorManager).BM_Shop):GetShopGoodInfoByID(self._shopID)
  ;
  (self._shopLimitText):SetText((TextManager.GetText)((CStringRes:GetRecorder(2151)).msgTextID))
  local lastPos = (self._goodsFrame):GetCurrentPosition()
  ;
  (self._goodsFrame):ReloadAllCell()
  if notChangePos and lastPos then
    (self._goodsFrame):MoveToAssignedPos(lastPos)
  end
end

ShopMainDialog.OnBuyShopGood = function(self, notification)
  -- function num : 0_10
  if (notification.userInfo).shopId == self._shopID then
    self:RefreshGoodsData(true)
  end
end

ShopMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_11
  if frame == self._currencyFrame then
    return #self._currencyData
  else
    if frame == self._goodsFrame then
      return #(self._shopData)[self._shopID]
    end
  end
end

ShopMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._currencyFrame then
    return "activity.swimsuitechoes.shopcurrencycell"
  else
    if frame == self._goodsFrame then
      return "activity.swimsuitechoes.shopgoodscell"
    end
  end
end

ShopMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._currencyFrame then
    return (self._currencyData)[index]
  else
    if frame == self._goodsFrame then
      return ((self._shopData)[self._shopID])[index]
    end
  end
end

ShopMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

ShopMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ShopMainDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_16
  local width, height = (self._goodsPanel):GetRectSize()
  local total = (self._goodsFrame):GetTotalLength()
  if height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

return ShopMainDialog

