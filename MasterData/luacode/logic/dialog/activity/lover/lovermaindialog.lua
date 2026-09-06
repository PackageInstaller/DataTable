local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CLoverInterEntry = BeanManager.GetTableByName("dungeonselect.cvalentineinterentry")
local CLoverInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local CLoverActivityEvent = require("protocols.def.protocol.activity.cloveractivityevent")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local SingletonSlideFrame = require("logic.dialog.activity.starmirage.singletonslideframe")
local SLoverRedPoint = LuaNetManager.GetProtocolDef("protocol.activity.sloverredpoint")
local UIManager = CS.PixelNeko.UI.UIManager
local CurrencyId = {
  DataCommon.LoveChocolate,
  DataCommon.LoveTownCurrency,
  DataCommon.LoveFlowers
}
local ChildDialogs = {
  "activity.lover.loverbattledialog",
  "activity.lover.loverstorybattledialog",
  "activity.lover.loverstorymaindialog",
  "activity.lover.shopmaindialog",
  "activity.lover.loverchocolatedialog",
  "activity.lover.loverstoredialog"
}
local MillisecondToDay = 86400000
local BgmId = 1361
local LoverMainDialog = class("LoverMainDialog", Dialog)
LoverMainDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverMainDialog.AssetName = "ActivityValentinesMain"

local function UpdateData(self)
  local constructions = self._bm:GetConstructions()
  self._constructions = {}
  for _, construction in pairs(constructions) do
    if next(construction.event) ~= nil then
      self._constructions[construction.doorID] = construction
    end
  end
  self._storeBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.DIALOGUE_STORE))
  self._flowersBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.FLOWER_LIST))
  self._chocolateBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.CHOCOLATE))
  self._shopBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.ITEM_SHOP))
end

function LoverMainDialog:Ctor(...)
  LoverMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
  self._constructions = {}
  self._panelPos = 0
end

function LoverMainDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._shop_Text = self:GetChild("ShopBtn/Text")
  self._chocolateBtn_text = self:GetChild("ChocolateBtn/Text")
  self._flowersBtn_text = self:GetChild("FlowerBtn/Text")
  self._storeBtn_text = self:GetChild("StoreBtn/Text")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1697))
  self._shop_Text:SetText(TextManager.GetText(701706))
  self._chocolateBtn_text:SetText(TextManager.GetText(701709))
  self._flowersBtn_text:SetText(TextManager.GetText(701708))
  self._storeBtn_text:SetText(TextManager.GetText(701707))
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._doors = {}
  self._floorPanel = self:GetChild("Frame")
  self._floorPanel:Subscribe_PointerClickEvent(function()
  end, self)
  self._panelWidth, self._panelHeight = self._floorPanel:GetRectSize()
  self._screenWidth, self._screenHeight = self:GetRootWindow():GetRectSize()
  local range = self._panelWidth / 2 - self._screenWidth / 2
  for i = 1, 17 do
    local door = {}
    local name = "Frame/FrameIsland" .. i .. "/ActivityValentinesPointBtn"
    door.cell = self:GetChild(name)
    door.name = self:GetChild(name .. "/Name")
    door.btns = {
      [1] = self:GetChild(name .. "/TrunkStory"),
      [2] = self:GetChild(name .. "/TrunkBattle"),
      [3] = self:GetChild(name .. "/ItemBattle")
    }
    door.itemBack = self:GetChild(name .. "/ItemBack")
    door.itemImg = self:GetChild(name .. "/ItemBack/Item")
    door.itemBack:SetActive(false)
    self._doors[i] = door
    door.cell:SetActive(false)
    local doorId = i
    for _, btn in pairs(door.btns) do
      btn:Subscribe_PointerClickEvent(function()
        if self._constructions[doorId] then
          self._bm:OnDoorClick(self._constructions[doorId].ID)
        end
      end, self)
      btn:SetActive(false)
    end
  end
  self._charFrame = self:GetChild("CharUp/CharFrame")
  self._charUpFrame = TableFrame.Create(self._charFrame, self, false, false)
  self._spiritNum = self:GetChild("TopGroup/Num1/Text")
  self._spiritAddBtn = self:GetChild("TopGroup/Num1/Add")
  self._spiritRedDot = self:GetChild("TopGroup/Num1/RedDot")
  self._spiritPanel = self:GetChild("TopGroup/Num1")
  self._spiritPanel:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._lovercurrency = {}
  for i = 1, 3 do
    local index = i + 1
    self._lovercurrency[i] = {}
    self._lovercurrency[i].panel = self:GetChild("TopGroup/Num" .. index)
    self._lovercurrency[i].count = self:GetChild("TopGroup/Num" .. index .. "/Text")
    self._lovercurrency[i].img = self:GetChild("TopGroup/Num" .. index .. "/Icon")
    self._lovercurrency[i].add = self:GetChild("TopGroup/Num" .. index .. "/Add")
    self._lovercurrency[i].redDot = self:GetChild("TopGroup/Num" .. index .. "/RedDot")
    self._lovercurrency[i].redDot:SetActive(false)
    self._lovercurrency[i].panel:Subscribe_PointerClickEvent(function()
      self:OnMaterialClick(i)
    end, self)
  end
  self._lovercurrency[3].panel:SetActive(false)
  self._tipBtn = self:GetChild("TipBtn")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  self._shopBtn = self:GetChild("ShopBtn")
  self._flowersBtn = self:GetChild("FlowerBtn")
  self._storeBtn = self:GetChild("StoreBtn")
  self._chocolateBtn = self:GetChild("ChocolateBtn")
  self._storeBtnRedDot = self:GetChild("StoreBtn/RedDot")
  self._flowersBtnRedDot = self:GetChild("FlowerBtn/RedDot")
  self._chocolateBtnRedDot = self:GetChild("ChocolateBtn/RedDot")
  self._shopBtnRedDot = self:GetChild("ShopBtn/RedDot")
  self._storeBtnLock = self:GetChild("StoreBtn/Lock")
  self._flowersBtnLock = self:GetChild("FlowerBtn/Lock")
  self._chocolateBtnLock = self:GetChild("ChocolateBtn/Lock")
  self._shopBtnLock = self:GetChild("ShopBtn/Lock")
  self._storeBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.DIALOGUE_STORE))
  self._flowersBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.FLOWER_LIST))
  self._chocolateBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.CHOCOLATE))
  self._shopBtnLock:SetActive(not self._bm:CheckFunctionUnLock(CLoverActivityEvent.ITEM_SHOP))
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.ITEM_SHOP) then
    self._shopBtnRedDot:SetActive(not self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Shop) and self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab) and not NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(DataCommon.Lover.Shop.Chocolate))
  else
    self._shopBtnRedDot:SetActive(false)
  end
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.DIALOGUE_STORE) then
    self._storeBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Store))
  else
    self._storeBtnRedDot:SetActive(false)
  end
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.CHOCOLATE) then
    self._chocolateBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Chocolate) or self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE))
  else
    self._chocolateBtnRedDot:SetActive(false)
  end
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.FLOWER_LIST) then
    self._flowersBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Flower) or self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_FLOWER))
  else
    self._flowersBtnRedDot:SetActive(false)
  end
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._flowersBtn:Subscribe_PointerClickEvent(self.OnFlowersBtnClicked, self)
  self._storeBtn:Subscribe_PointerClickEvent(self.OnStoreBtnClicked, self)
  self._chocolateBtn:Subscribe_PointerClickEvent(self.OnChocolateBtnClicked, self)
  self._spiritAddBtn:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateConstructionEvent, Common.n_OnSUpdateLoverConstructionEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterMianCity, Common.n_EnterMianCity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLoverRefreshRedPoint, Common.n_LoverRefreshRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLoverRefreshShopDisplay, Common.n_LoverRefreshShopDisplay, nil)
  self:Init()
end

local function RefreshDoorByID(self, doorID)
  local door = self._doors[doorID]
  if door then
    local data = self._constructions[doorID]
    if data and #data.event > 0 and CLoverInterfaceFunction:GetRecorder(data.event[1]) then
      local recorder = CLoverInterfaceFunction:GetRecorder(data.event[1])
      local type = recorder.type
      local tagType = recorder.tagType
      local name = ""
      local block = CLoverInterEntry:GetRecorder(data.ID)
      if block then
        name = TextManager.GetText(block.name)
      end
      for _, btn in pairs(door.btns) do
        btn:SetActive(false)
      end
      door.btns[tagType]:SetActive(true)
      door.cell:SetActive(true)
      door.name:SetText(name)
      if recorder.bubbleItem ~= 0 then
        door.itemBack:SetActive(true)
        local item = Item.Create(recorder.bubbleItem)
        door.itemImg:SetSprite(item:GetIconAB())
      else
        door.itemBack:SetActive(false)
      end
    else
      door.cell:SetActive(false)
    end
  end
end

function LoverMainDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function LoverMainDialog:OnDestroy()
  LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
  for _, dialogName in pairs(ChildDialogs) do
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._charUpFrame then
    self._charUpFrame:Destroy()
  end
  if self._singletonSlideFrame then
    self._singletonSlideFrame:Destroy()
  end
end

function LoverMainDialog:Init()
  if self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Banner) then
    self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.Banner)
    LuaNotificationCenter.PostNotification(Common.n_RefreshActivities, nil, nil)
  end
  LuaAudioManager.PlayBGM(BgmId)
  self:RefreshAllConstruction()
  for i, v in ipairs(self._lovercurrency) do
    local item = Item.Create(CurrencyId[i])
    v.img:SetSprite(item:GetIconAB())
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(CurrencyId[i]))
  end
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SpiritID)
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
  self._spiritRedDot:SetActive(self:HaveSpiritItemSoonExpire())
  self._charUpData = {}
  local allIds = CEventBoostRole:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CEventBoostRole:GetRecorder(allIds[i])
    if record.eventid == DataCommon.Activities.Lover then
      table.insert(self._charUpData, record)
    end
  end
  table.sort(self._charUpData, function(a, b)
    return a.sort < b.sort
  end)
  self._charUpFrame:ReloadAllCell()
end

function LoverMainDialog:RefreshAllConstruction()
  UpdateData(self)
  for i = 1, 17 do
    RefreshDoorByID(self, i)
  end
end

function LoverMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverMainDialog:OnShopBtnClicked()
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.ITEM_SHOP) then
    if self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Shop) then
      self._shopBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab) and not NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(DataCommon.Lover.Shop.Chocolate))
      self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.Shop)
    end
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
    protocol.shopId = DataCommon.Lover.Shop.TownCurrency
    protocol:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100447)
  end
end

function LoverMainDialog:OnStoreBtnClicked()
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.DIALOGUE_STORE) then
    if self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Store) then
      self._storeBtnRedDot:SetActive(false)
      self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.Store)
    end
    DialogManager.CreateSingletonDialog("activity.lover.loverstoredialog")
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100448)
  end
end

function LoverMainDialog:OnChocolateBtnClicked()
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.CHOCOLATE) then
    if self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Chocolate) then
      self._chocolateBtnRedDot:SetActive(self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE))
      self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.Chocolate)
    end
    local chocolateEntry = self._bm:GetChocolateEntry()
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cloveractivityevent")
    csend.constructionID = chocolateEntry.constructionID
    csend.eventID = chocolateEntry.eventID
    csend:Send()
  end
end

function LoverMainDialog:OnFlowersBtnClicked()
  if self._bm:CheckFunctionUnLock(CLoverActivityEvent.FLOWER_LIST) then
    if self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Flower) then
      self._flowersBtnRedDot:SetActive(self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_FLOWER))
      self._bm:SetRedPointWithLocalKey(self._bm.RedPointKey.Flower)
    end
    local flowerEntry = self._bm:GetFlowerEntry()
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cloveractivityevent")
    csend.constructionID = flowerEntry.constructionID
    csend.eventID = flowerEntry.eventID
    csend:Send()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100449)
  end
end

function LoverMainDialog:OnSUpdateConstructionEvent(notification)
  local updates = notification.userInfo.updates
  UpdateData(self)
  for _, v in pairs(updates) do
    local recoder = CLoverInterEntry:GetRecorder(v.construction)
    if recoder then
      RefreshDoorByID(self, recoder.posId)
    else
      LogErrorFormat("LoverMainDialog", "CLoverInterEntry No Exist ID:%s", v.construction)
    end
  end
end

function LoverMainDialog:OnSpiritAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function LoverMainDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
end

function LoverMainDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function LoverMainDialog:RefreshMaterials(notification)
  for i, v in ipairs(self._lovercurrency) do
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(CurrencyId[i]))
  end
end

function LoverMainDialog:NumberOfCell(frame)
  if frame == self._charUpFrame then
    return #self._charUpData
  end
end

function LoverMainDialog:CellAtIndex(frame, index)
  if frame == self._charUpFrame then
    return "activity.lover.lovermaincharcell"
  end
end

function LoverMainDialog:DataAtIndex(frame, index)
  if frame == self._charUpFrame then
    return self._charUpData[index]
  end
end

function LoverMainDialog:OnTipBtnClick()
  DialogManager.CreateSingletonDialog("activity.lover.lovertipsdialog"):SetData(CStringres:GetRecorder(1695).msgTextID)
end

function LoverMainDialog:OnNPCChatEnd()
end

function LoverMainDialog:OnEnterMianCity()
  LuaAudioManager.StopBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
  LuaAudioManager.PlayBGM(BgmId)
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Lover) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100452)
    self:OnBackBtnClicked()
  end
end

function LoverMainDialog:OnMaterialClick(index)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(CurrencyId[index])
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function LoverMainDialog:SetSingletonSlideFrame(xMinEdge, xMaxEdge, elasticity)
  xMinEdge = xMinEdge or 0
  xMaxEdge = xMaxEdge or 0
  if self._singletonSlideFrame then
    self._singletonSlideFrame:Destroy()
  end
  self._singletonSlideFrame = SingletonSlideFrame.Create(self._floorPanel, false, xMinEdge, xMaxEdge, elasticity)
end

function LoverMainDialog:OnOthersActivitysTimeOver()
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Lover) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(10452)
    self:OnBackBtnClicked()
  end
end

function LoverMainDialog:OnDialogDestroy(notification)
  local dialogName = notification.userInfo._dialogName
  if dialogName == "npcchat.newnpcchatdialog" or dialogName == "bag.spiritrecoverdialog" then
    self._rootWindow:SetActive(true)
  end
end

function LoverMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function LoverMainDialog:OnLoverRefreshRedPoint(notification)
  if notification.userInfo == self._bm.RedPointKey.Flower then
    self._flowersBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Flower) or self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_FLOWER))
  elseif notification.userInfo == self._bm.RedPointKey.Chocolate then
    self._chocolateBtnRedDot:SetActive(self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Chocolate) or self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE))
  elseif notification.userInfo == self._bm.RedPointKey.Shop then
    self._shopBtnRedDot:SetActive(not self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Shop) and self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab) and not NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(DataCommon.Lover.Shop.Chocolate))
  end
end

function LoverMainDialog:OnLoverRefreshShopDisplay(notification)
  if notification.userInfo.shopType == DataCommon.Lover.Shop.Chocolate then
    self._shopBtnRedDot:SetActive(not self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.Shop) and self._bm:GetRedPointWithLocalKey(self._bm.RedPointKey.ShopChocolateTab) and not NekoData.BehaviorManager.BM_Shop:GetShopItemCanNotUseWithShopType(DataCommon.Lover.Shop.Chocolate))
  end
end

return LoverMainDialog
