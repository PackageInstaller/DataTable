local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cinterentry")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local CChrisfinal = BeanManager.GetTableByName("dungeonselect.cchrisfinal")
local CChriscorresponding = BeanManager.GetTableByName("dungeonselect.cchriscorresponding")
local UIManager = CS.PixelNeko.UI.UIManager
local CurrencyId = {
  DataCommon.ChristmasExpressiveForce,
  DataCommon.ChristmasJump,
  DataCommon.ChristmasSing
}
local ChildDialogs = {
  "activity.christmas.christmasbagdialog",
  "activity.christmas.christmasbattledialog",
  "activity.christmas.christmasfoodstallsdialog",
  "activity.christmas.christmasfoodstallsshowdialog",
  "activity.christmas.christmasstorybattledialog",
  "activity.christmas.christmasstorymaindialog",
  "activity.christmas.christmasstorybranchdialog",
  "activity.christmas.shopmaindialog",
  "activity.christmas.reminddialog"
}
local levelText = {
  [1] = 701718,
  [2] = 701719,
  [3] = 701720
}
local doors = {
  "FrameDoor1-1",
  "FrameDoor1-2",
  "FrameDoor1-3",
  "FrameDoor1-4",
  "FrameDoor1-5",
  "FrameDoor2-1",
  "FrameDoor2-2",
  "FrameDoor2-3",
  "FrameDoor2-4",
  "FrameDoor3-1",
  "FrameDoor3-2",
  "FrameDoor3-3",
  "FrameDoor3-4",
  "FrameDoor4-1",
  "FrameDoor4-2",
  "FrameDoor4-3",
  "FrameDoor5-1"
}
local doorType = {
  "Trunk",
  "Fight",
  "Food",
  "Top"
}
local MillisecondToDay = 86400000
local ChristmasMainDialog = class("ChristmasMainDialog", Dialog)
ChristmasMainDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasMainDialog.AssetName = "ActivityChristmasMain"

local function UpdateData(self)
  local constructions = self._bm:GetConstructions()
  self._constructions = {}
  for _, construction in pairs(constructions) do
    if next(construction.event) ~= nil then
      self._constructions[construction.doorID] = construction
    end
  end
end

function ChristmasMainDialog:Ctor(...)
  ChristmasMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID)
  self._constructions = {}
  self._panelPos = 0
  self._frist = false
end

function ChristmasMainDialog:OnCreate()
  self._doors = {}
  self._title = self:GetChild("Title")
  self._shopText = self:GetChild("ShopBtn/Text")
  self._bagText = self:GetChild("BagBtn/Text")
  self._mailText = self:GetChild("MailBtn/Text")
  self._powerName = self:GetChild("PowerBack/PowerName")
  self._remindBtn_text = self:GetChild("RemindBtn/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  for i, v in ipairs(doors) do
    local door = {}
    local name = "Frame/" .. v .. "/ActivityFrameDoorCell"
    door.cell = self:GetChild(name)
    door.types = {}
    name = name .. "/TypeBtn"
    for _, type in pairs(doorType) do
      door.types[type] = {}
      local btnName = name .. type
      door.types[type].btn = self:GetChild(btnName)
      door.types[type].text = self:GetChild(btnName .. "/Text")
      door.types[type].img = self:GetChild(btnName .. "/Img")
      door.types[type].effect = self:GetChild(btnName .. "/Effect")
      if type == "Fight" then
        door.types[type].level = {}
        door.types[type].level.cell = self:GetChild(btnName .. "/Level")
        door.types[type].level.back = {}
        door.types[type].level.back[1] = self:GetChild(btnName .. "/Level/back1")
        door.types[type].level.back[2] = self:GetChild(btnName .. "/Level/back2")
        door.types[type].level.back[3] = self:GetChild(btnName .. "/Level/back3")
        door.types[type].level.text = self:GetChild(btnName .. "/Level/Text")
        if door.types[type].level.cell then
          door.types[type].level.cell:SetActive(false)
        end
      end
      if door.types[type].effect then
        door.types[type].effect:SetActive(false)
      end
      door.types[type].img:SetActive(false)
      local doorId = i
      door.types[type].btn:Subscribe_PointerClickEvent(function()
        if self._constructions[doorId] then
          self._bm:OnDoorClick(self._constructions[doorId].ID)
        end
      end)
    end
    self._doors[i] = door
    door.cell:SetActive(false)
  end
  self._remindBtn = self:GetChild("RemindBtn")
  self._shopBtn = self:GetChild("ShopBtn")
  self._bagBtn = self:GetChild("BagBtn")
  self._mailBtn = self:GetChild("MailBtn")
  self._mailBtn_RedDot = self:GetChild("MailBtn/RedDot")
  self._remindBtn:Subscribe_PointerClickEvent(self.OnRemindBtnClick, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnClicked, self)
  self._bagBtn:Subscribe_PointerClickEvent(self.OnBagBtnClick, self)
  self._mailBtn:Subscribe_PointerClickEvent(self.OnMailBtnClick, self)
  self._topGroup = self:GetChild("TopGroup")
  self._charFrame = self:GetChild("CharUp/CharFrame")
  self._charUpFrame = TableFrame.Create(self._charFrame, self, false, false)
  self._spiritNum = self:GetChild("TopGroup/Num1/Text")
  self._spiritAddBtn = self:GetChild("TopGroup/Num1/Add")
  self._spiritRedDot = self:GetChild("TopGroup/Num1/RedDot")
  self._spiritPanel = self:GetChild("TopGroup/Num1")
  self._spiritPanel:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  self._christmascurrency = {}
  for i = 1, 3 do
    local index = i + 1
    self._christmascurrency[i] = {}
    self._christmascurrency[i].panel = self:GetChild("TopGroup/Num" .. index)
    self._christmascurrency[i].count = self:GetChild("TopGroup/Num" .. index .. "/Text")
    self._christmascurrency[i].img = self:GetChild("TopGroup/Num" .. index .. "/Icon")
    self._christmascurrency[i].add = self:GetChild("TopGroup/Num" .. index .. "/Add")
    self._christmascurrency[i].redDot = self:GetChild("TopGroup/Num" .. index .. "/RedDot")
    self._christmascurrency[i].redDot:SetActive(false)
    self._christmascurrency[i].panel:Subscribe_PointerClickEvent(function()
      self:OnMaterialClick(i)
    end, self)
  end
  self._scores = {}
  self._scores[DataCommon.ChristmasSing] = {
    name = self:GetChild("PowerBack/PowerTextA"),
    scoreTxt = self:GetChild("PowerBack/NumA")
  }
  self._scores[DataCommon.ChristmasJump] = {
    name = self:GetChild("PowerBack/PowerTextB"),
    scoreTxt = self:GetChild("PowerBack/NumB")
  }
  self._scores[DataCommon.ChristmasExpressiveForce] = {
    name = self:GetChild("PowerBack/PowerTextC"),
    scoreTxt = self:GetChild("PowerBack/NumC")
  }
  self._scoreBtn = self:GetChild("PowerBack/PowerBtn")
  self._scoreBtn_RedDot = self:GetChild("PowerBack/PowerBtn/Img")
  self._scoreBtn_Text = self:GetChild("PowerBack/PowerBtn/Text")
  self._scoreBtn:Subscribe_PointerClickEvent(self.OnScoreBtnClick, self)
  for k, v in pairs(self._scores) do
    local currencyItem = Item.Create(k)
    v.name:SetText(currencyItem:GetName())
  end
  self._tipBtn = self:GetChild("TipBtn")
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  self._floorPanel = self:GetChild("Frame")
  self._floorPanel:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._floorPanel:Subscribe_DragEvent(self.OnDrag, self)
  self._floorPanel:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._floorPanel:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self._spiritAddBtn:Subscribe_PointerClickEvent(self.OnSpiritAddBtnClick, self)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnOthersActivitysTimeOver, Common.n_OthersActivitysTimeOver, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateConstructionEvent, Common.n_OnSUpdateChristmasConstructionEvent, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshFoodStallRot, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshChristmasMailRedDot, Common.n_RefreshChristmasMailRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshScorePanel, Common.n_RefreshChristmasScore, nil)
  LuaNotificationCenter.AddObserver(self, self.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLateUpdate, Common.n_LateUpdate, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshMaterials, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEnterMianCity, Common.n_EnterMianCity, nil)
end

local function RefreshDoorByID(self, doorID)
  local door = self._doors[doorID]
  if door then
    local data = self._constructions[doorID]
    if data and #data.event > 0 then
      local type = CInterfaceFunction:GetRecorder(data.event[1]).type
      local tagType = CInterfaceFunction:GetRecorder(data.event[1]).tagType
      local level = tagType - 4
      if 0 < level then
        tagType = 2
      end
      local name = ""
      local block = CInterEntry:GetRecorder(data.ID)
      if block then
        name = TextManager.GetText(block.name)
      end
      for _, type in pairs(doorType) do
        door.types[type].btn:SetActive(false)
      end
      if doorType[tagType] then
        door.types[doorType[tagType]].btn:SetActive(true)
        door.types[doorType[tagType]].text:SetText(name)
        if door.types[doorType[tagType]].level and door.types[doorType[tagType]].level.cell then
          if 0 < level then
            door.types[doorType[tagType]].level.cell:SetActive(true)
            for i = 1, 3 do
              door.types[doorType[tagType]].level.back[i]:SetActive(false)
              if i == level then
                door.types[doorType[tagType]].level.back[i]:SetActive(true)
                door.types[doorType[tagType]].level.text:SetText(TextManager.GetText(levelText[level]))
              end
            end
          else
            door.types[doorType[tagType]].level.cell:SetActive(false)
          end
        end
        if type == CChristmasActivityEvent.MAINLINE_PLOT or type == CChristmasActivityEvent.MAINLINE_BATTLE then
          if door.types[doorType[tagType]].effect then
            door.types[doorType[tagType]].effect:SetActive(true)
          end
        elseif type == CChristmasActivityEvent.TOP_LEVEL then
          if self._bm:GetCanEnterSecond() == 1 then
            if door.types[doorType[tagType]].effect then
              door.types[doorType[tagType]].effect:SetActive(true)
            end
          elseif door.types[doorType[tagType]].effect then
            door.types[doorType[tagType]].effect:SetActive(false)
          end
        elseif door.types[doorType[tagType]].effect then
          door.types[doorType[tagType]].effect:SetActive(false)
        end
        if type == CChristmasActivityEvent.CHRISTMAS_DINNER then
          door.types[doorType[tagType]].img:SetActive(self._bm:GetSnacRedpoint())
        elseif type == CChristmasActivityEvent.BRANCH_PLOT then
          if #data.event == 3 then
            door.types[doorType[tagType]].img:SetActive(true)
          else
            door.types[doorType[tagType]].img:SetActive(false)
          end
        elseif type == CChristmasActivityEvent.END_PLOT then
          local rec = CChriscorresponding:GetRecorder(data.ID)
          local recorder = CChrisfinal:GetRecorder(data.event[1])
          if rec and self._bm:GetScoreByType(rec.itemId) >= rec.itemNum and recorder.type == 1 then
            door.types[doorType[tagType]].img:SetActive(true)
          else
            door.types[doorType[tagType]].img:SetActive(false)
          end
        else
          door.types[doorType[tagType]].img:SetActive(false)
        end
      else
        door.types[doorType[1]].btn:SetActive(true)
        door.types[doorType[1]].text:SetText(name)
        LogErrorFormat("ChristmasMainDialog", "Erro Type%s%s", data.event[1], tagType)
        if door.types[doorType[tagType]].effect then
          door.types[doorType[tagType]].effect:SetActive(false)
        end
      end
      door.cell:SetActive(true)
    else
      door.cell:SetActive(false)
    end
  end
end

function ChristmasMainDialog:AddNewModal(dialog)
  if table.contain(ChildDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function ChristmasMainDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
  LuaAudioManager.PlayBGM(NekoData.BehaviorManager.BM_Game:GetMainCityBgmID())
  LuaAudioManager.StopBGM(1356)
  for _, dialogName in pairs(ChildDialogs) do
    local dialog = DialogManager.GetDialog(dialogName)
    if dialog then
      dialog:Destroy()
    end
  end
  if self._charUpFrame then
    self._charUpFrame:Destroy()
  end
  DialogManager.DestroySingletonDialog("activity.christmas.accumulaterewarddialog")
end

function ChristmasMainDialog:RefreshChristmasMailRedDot()
  self._mailBtn_RedDot:SetActive(self._bm:ShowMailRedDot())
end

function ChristmasMainDialog:RefreshScorePanel()
  self._scoreBtn_RedDot:SetActive(self._bm:ShowScoreRedDot())
  for k, v in pairs(self._scores) do
    v.scoreTxt:SetText(self._bm:GetScoreByType(k))
  end
end

function ChristmasMainDialog:Init(first)
  self:RefreshAllConstruction()
  self:RefreshChristmasMailRedDot()
  self:RefreshScorePanel()
  self._frist = first
  if not first then
    LuaAudioManager.StopBGM(136)
    LuaAudioManager.PlayBGM(1356)
  end
  self._title:SetText(TextManager.GetText(1901211))
  self._powerName:SetText(TextManager.GetText(1901217))
  self._shopText:SetText(TextManager.GetText(1901205))
  self._bagText:SetText(TextManager.GetText(1901204))
  self._mailText:SetText(TextManager.GetText(1901206))
  self._remindBtn_text:SetText(TextManager.GetText(1901216))
  self._scoreBtn_Text:SetText(TextManager.GetText(1901396))
  for i, v in ipairs(self._christmascurrency) do
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
    if record.eventid == DataCommon.Activities.Christmas then
      table.insert(self._charUpData, record)
    end
  end
  table.sort(self._charUpData, function(a, b)
    return a.sort < b.sort
  end)
  self._charUpFrame:ReloadAllCell()
  self._originalX, self._originalOX = self._floorPanel:GetPosition()
  local _
  _, self._panelHeight = self._floorPanel:GetRectSize()
  self._screenWidth, self._screenHeight = self:GetRootWindow():GetRectSize()
end

function ChristmasMainDialog:RefreshAllConstruction()
  local constructions = self._bm:GetConstructions()
  self._constructions = {}
  for _, construction in pairs(constructions) do
    if next(construction.event) ~= nil then
      self._constructions[construction.doorID] = construction
    end
  end
  for i, _ in ipairs(doors) do
    RefreshDoorByID(self, i)
  end
  self._remindBtn:SetActive(self._bm:IsUnlockBook())
  self._shopBtn:SetActive(self._bm:IsUnlockShop())
  self._bagBtn:SetActive(self._bm:IsUnlockBag())
  self._mailBtn:SetActive(self._bm:IsUnlockMail())
end

function ChristmasMainDialog:SetData(data)
end

function ChristmasMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasMainDialog:RefreshFoodStallRot()
  local constructions = self._bm:GetConstructions()
  for _, construction in pairs(constructions) do
    if next(construction.event) ~= nil and CInterfaceFunction:GetRecorder(construction.event[1]).type == CChristmasActivityEvent.CHRISTMAS_DINNER then
      self._doors[construction.doorID].types[doorType[3]].img:SetActive(self._bm:GetSnacRedpoint())
    end
  end
end

function ChristmasMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ChristmasMainDialog:OnShopBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  protocol.shopId = DataCommon.Christmas.Shop.Sing
  protocol:Send()
end

function ChristmasMainDialog:OnBagBtnClick()
  DialogManager.CreateSingletonDialog("activity.christmas.christmasbagdialog"):SetData(self._bm:GetBuffInfo())
end

function ChristmasMainDialog:OnMailBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
  csend.eventID = DataCommon.Christmas.Function.Mail
  csend:Send()
end

function ChristmasMainDialog:OnScoreBtnClick()
  DialogManager.CreateSingletonDialog("activity.christmas.accumulaterewarddialog"):SetType(DataCommon.ChristmasSing)
end

function ChristmasMainDialog:OnSUpdateConstructionEvent(notification)
  local updates = notification.userInfo.updates
  UpdateData(self)
  for _, v in pairs(updates) do
    local recoder = CInterEntry:GetRecorder(v.construction)
    if recoder then
      RefreshDoorByID(self, recoder.posId)
    else
      LogErrorFormat("ChristmasMainDialog", "CInterEntry No Exist ID:%s", v.construction)
    end
  end
end

function ChristmasMainDialog:OnSpiritAddBtnClick()
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
end

function ChristmasMainDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._spiritNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit))
end

function ChristmasMainDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function ChristmasMainDialog:RefreshMaterials(notification)
  for i, v in ipairs(self._christmascurrency) do
    v.count:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(CurrencyId[i]))
  end
end

function ChristmasMainDialog:NumberOfCell(frame)
  if frame == self._charUpFrame then
    return #self._charUpData
  end
end

function ChristmasMainDialog:CellAtIndex(frame, index)
  if frame == self._charUpFrame then
    return "activity.christmas.christmasmaincharcell"
  end
end

function ChristmasMainDialog:DataAtIndex(frame, index)
  if frame == self._charUpFrame then
    return self._charUpData[index]
  end
end

function ChristmasMainDialog:OnBeginDrag(args)
  self._dragSpeed = 0
  self._dragDelta = 0
  self._slideTime = 0.5
  self._needUpdate = false
end

function ChristmasMainDialog:OnDrag(args)
  local pressPosition = args.pressPosition
  local position = args.position
  local _, localPressY = UIManager.ScreenPointToLocalPointInRectangle(self._floorPanel._uiObject, pressPosition.x, pressPosition.y)
  local _, localY = UIManager.ScreenPointToLocalPointInRectangle(self._floorPanel._uiObject, position.x, position.y)
  self._dragSpeed = args.ySpeed / 10
  local currentPosition = self._panelPos
  self._panelPos = currentPosition - self._dragDelta
  self._dragDelta = localY - localPressY
  self._panelPos = self._panelPos + self._dragDelta
  if self._panelPos < -self._panelHeight + self._screenHeight then
    self._panelPos = -self._panelHeight + self._screenHeight
  end
  if self._panelPos > 0 then
    self._panelPos = 0
  end
  if currentPosition ~= self._panelPos then
    self._needUpdate = true
    self:UpdateView(0)
  end
end

function ChristmasMainDialog:OnEndDrag(args)
  self._dragDelta = 0
  local _, original = UIManager.ScreenPointToLocalPointInRectangle(self._floorPanel._uiObject, 0, 0)
  local _, speed = UIManager.ScreenPointToLocalPointInRectangle(self._floorPanel._uiObject, 0, self._dragSpeed)
  speed = original - speed
  self._dragSpeed = speed
  if self._panelPos < -self._panelHeight + self._screenHeight then
    self._panelPos = -self._panelHeight + self._screenHeight
  end
  if 0 < self._panelPos then
    self._panelPos = 0
  end
  self._slideOriPos = self._panelPos
  local first = {spe = speed}
  local last = {spe = 0}
  self._slideTask = Tween.new(self._slideTime, first, last, "linear")
  self._needUpdate = true
end

function ChristmasMainDialog:UpdateView(deltaTime)
  if self._needUpdate and not self._slideTask and not self._moveTask then
    self._needUpdate = false
  end
  if self._panelPos < -self._panelHeight + self._screenHeight then
    self._panelPos = -self._panelHeight + self._screenHeight
  end
  if self._panelPos > 0 then
    self._panelPos = 0
  end
  self._floorPanel:SetPosition(self._originalX, self._originalOX, 0, self._panelPos)
end

function ChristmasMainDialog:OnLateUpdate(notification)
  local deltaTime = notification.userInfo.deltaTime
  if self._needUpdate then
    if self._slideTask then
      if self._slideTask:update(deltaTime) then
        self._panelPos = self._slideOriPos - (self._dragSpeed + self._slideTask.subject.spe) * self._slideTime / 2
        self._slideTask = nil
        self._slideOriPos = nil
      else
        self._panelPos = self._slideOriPos - (self._dragSpeed + self._slideTask.subject.spe) * self._slideTask.clock / 2
      end
      if self._slideTask and (self._panelPos > -self._panelHeight + self._screenHeight or self._panelPos < 0) then
        self._slideTask.clock = self._slideTask.clock + 2 * deltaTime
      end
      if self._panelPos < -self._panelHeight then
        self._panelPos = -self._panelHeight
      end
      if self._panelPos > 0 then
        self._panelPos = 0
      end
    end
    if self._moveTask then
      if self._moveTask:update(deltaTime) then
        self._panelPos = self._moveDesPos
        self._moveTask = nil
        self._moveDesPos = nil
      else
        self._panelPos = self._moveTask.subject.pos
      end
    end
    self:UpdateView(deltaTime)
  end
end

function ChristmasMainDialog:OnRemindBtnClick()
  DialogManager.CreateSingletonDialog("activity.christmas.reminddialog")
end

function ChristmasMainDialog:OnTipBtnClick()
  DialogManager.CreateSingletonDialog("activity.christmas.christmastipsdialog"):SetData(1901376)
end

function ChristmasMainDialog:OnMaterialClick(index)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(CurrencyId[index])
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

function ChristmasMainDialog:OnEnterMianCity()
  LuaAudioManager.StopBGM(136)
  LuaAudioManager.PlayBGM(1356)
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

function ChristmasMainDialog:OnNPCChatEnd()
  if self._frist then
    LuaAudioManager.PlayBGM(1356)
  end
end

function ChristmasMainDialog:OnOthersActivitysTimeOver()
  if not NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
    self:OnBackBtnClicked()
  end
end

function ChristmasMainDialog:OnDialogDestroy(notification)
  local dialogName = notification.userInfo._dialogName
  if dialogName == "npcchat.newnpcchatdialog" or dialogName == "bag.spiritrecoverdialog" then
    self._rootWindow:SetActive(true)
  end
end

return ChristmasMainDialog
