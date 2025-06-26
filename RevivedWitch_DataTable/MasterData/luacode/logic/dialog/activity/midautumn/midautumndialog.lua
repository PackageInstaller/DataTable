-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/midautumn/midautumndialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local catShapeRecorder = ((BeanManager.GetTableByName)("npc.cnpcshape")):GetRecorder(9)
local ActivityJackpot = (BeanManager.GetTableByName)("item.cactivityjackpot")
local CMidAutumnLines = (BeanManager.GetTableByName)("dialog.cmidautumnlines")
local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local timeofword = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(88)).Value)
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MoonCakeMinNum = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(111)).Value)
local MidAutumnDialog = class("MidAutumnDialog", Dialog)
MidAutumnDialog.AssetBundleName = "ui/layouts.activitymidautumn"
MidAutumnDialog.AssetName = "ActivityMidAutumnMain"
MidAutumnDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MidAutumnDialog
  ((MidAutumnDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._normalLines = {}
  self._conditionLines = {}
  self._itemList = {}
end

MidAutumnDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, catShapeRecorder, CImagePathTable, TableFrame
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._model = self:GetChild("UI/ModelBack/Model/Char_CatUI")
  self._bubble = self:GetChild("UI/ModelBack/ModelPop/NPCBubbleUI")
  self._animator_cat = ((self._model):GetUIObject()):GetComponent("Animator")
  self._animator = ((self._bubble):GetUIObject()):GetComponent("Animator")
  if (Live2DManager.CanUse)() and catShapeRecorder.live2DAssetBundleName and catShapeRecorder.live2DAssetBundleName ~= "" and catShapeRecorder.live2DPrefabName and catShapeRecorder.live2DPrefabName ~= "" then
    (self._photo):SetActive(false)
    ;
    (self._live2D):AddLive2D(catShapeRecorder.live2DAssetBundleName, catShapeRecorder.live2DPrefabName, catShapeRecorder.live2DScale)
  else
    ;
    (self._photo):SetActive(true)
    if not CImagePathTable:GetRecorder(catShapeRecorder.lihuiID) then
      local recorder = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(recorder.assetBundle, recorder.assetName)
  end
  do
    ;
    (self._animator_cat):Play("IdleLeftUI")
    self._dialogPanel = self:GetChild("UI/Dialog")
    self._dialogPanel_txt = self:GetChild("UI/Dialog/Text")
    self._dialogPanel_width = (self._dialogPanel):GetDeltaSize()
    self._dialogPanel_txt_width = (self._dialogPanel_txt):GetDeltaSize()
    ;
    (self._dialogPanel):SetActive(false)
    ;
    (self._dialogPanel):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
    ;
    (self:GetChild("Role")):Subscribe_PointerClickEvent(self.OnCatClicked, self)
    self._moonCakeNumTxt = self:GetChild("TopGroupCell/Num0/Text")
    self._moonCakeBtn = self:GetChild("TopGroupCell/Num0/Icon")
    self._moonCakeAddBtn = self:GetChild("TopGroupCell/Num0/Add (1)")
    ;
    (self:GetChild("TopGroupCell/Num0/Add")):SetActive(false)
    self._goBtn = self:GetChild("UI/GoBtn")
    self._itemPanel = self:GetChild("UI/Frame/Panel")
    self._exchangeBtn = self:GetChild("UI/Frame/GetBtn")
    self._recycleBtn = self:GetChild("UI/Frame/BtnHS")
    self._backBtn = self:GetChild("BackBtn")
    self._menuBtn = self:GetChild("MenuBtn")
    self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, true, false)
    ;
    (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
    ;
    (self._exchangeBtn):Subscribe_PointerClickEvent(self.OnExchangeBtnClicked, self)
    ;
    (self._recycleBtn):Subscribe_PointerClickEvent(self.OnRecycleBtnClicked, self)
    ;
    (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
    ;
    (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
    ;
    (self._moonCakeBtn):Subscribe_PointerClickEvent(self.OnMoonCakeBtnClick, self)
    ;
    (self._moonCakeNumTxt):Subscribe_PointerClickEvent(self.OnMoonCakeBtnClick, self)
    ;
    (self._moonCakeAddBtn):Subscribe_PointerClickEvent(self.OnMoonCakeAddBtnClick, self)
    self._goBtn_text = self:GetChild("UI/GoBtn/_Text")
    self._tips = self:GetChild("UI/Tips")
    self._maybe_text = self:GetChild("UI/Frame/Text")
    self._startTime_text = self:GetChild("UI/Time/StartTime")
    self._endTime_text = self:GetChild("UI/Time/EndTime")
    self._exchange_text = self:GetChild("UI/Frame/GetBtn/_Text")
    self._recycleBtn_text = self:GetChild("UI/Frame/BtnHS/_Text")
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMidAutumnLeftTime, Common.n_RefreshMidAutumnLeftTime, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  end
end

MidAutumnDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._itemFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.midautumn.exchangedialog")
  if self._contentTimer then
    (GameTimer.RemoveTask)(self._contentTimer)
    self._contentTimer = nil
  end
end

local RefreshBtn = function(self)
  -- function num : 0_3 , upvalues : _ENV, MoonCakeMinNum
  local tag = ((NekoData.BehaviorManager).BM_Activity):GetMidAutumnLeftTime() > 0
  ;
  (self._moonCakeAddBtn):SetActive(tag)
  ;
  (self._goBtn):SetInteractable(tag)
  local currencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId)
  tag = not tag and currencyNum < MoonCakeMinNum
  ;
  (self._recycleBtn):SetActive(tag)
  ;
  (self._exchangeBtn):SetActive(not tag)
  ;
  (self._moonCakeNumTxt):SetNumber(currencyNum)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local RefreshBubbleAnimation = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tag = ((NekoData.BehaviorManager).BM_Activity):GetMidAutumnLeftTime() > 0
  if tag then
    (self._animator):Play("dots")
    ;
    (self._animator):SetInteger("New Int", 0)
  else
    (self._animator):Play("sleep")
    ;
    (self._animator):SetInteger("New Int", 1)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

local SetLines = function(self, lineId)
  -- function num : 0_5 , upvalues : CMidAutumnLines, _ENV, timeofword
  if self._contentTimer then
    return 
  end
  ;
  (self._dialogPanel):SetActive(true)
  ;
  (self._dialogPanel):PlayAnimation("CharDataMainDialogShow")
  local recorder = CMidAutumnLines:GetRecorder(lineId)
  local str = (TextManager.GetText)(recorder.textId)
  ;
  (self._dialogPanel_txt):SetText(str)
  local _, textheight = (self._dialogPanel_txt):GetPreferredSize()
  if self._dialogPanel_txt_height < textheight then
    (self._dialogPanel_txt):SetDeltaSize(self._dialogPanel_txt_width, textheight)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    ;
    (self._dialogPanel_txt):SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    ;
    (self._dialogPanel):SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  local text = (string.trim)(str)
  self._contentTimer = (GameTimer.AddTask)((utf8.len)(text) * timeofword / 1000, -1, function()
    -- function num : 0_5_0 , upvalues : self
    (self._dialogPanel):PlayAnimation("CharDataMainDialogHide")
  end
)
end

MidAutumnDialog.SetRecord = function(self, record)
  -- function num : 0_6 , upvalues : _ENV, Item, CMidAutumnLines, ActivityJackpot
  self._record = record
  self._activityId = (self._record).id
  LogInfoFormat("MidAutumnDialog", "activityId = %s", self._activityId)
  self._item = (Item.Create)((self._record).MoneyId)
  ;
  (self._goBtn_text):SetText((TextManager.GetText)(((self._record).WordId)[1]))
  ;
  (self._tips):SetText((string.gsub)((TextManager.GetText)(((self._record).WordId)[2]), "%$parameter1%$", (self._item):GetName()))
  ;
  (self._maybe_text):SetText((TextManager.GetText)(((self._record).WordId)[3]))
  ;
  (self._startTime_text):SetText((TextManager.GetText)(((self._record).WordId)[4]))
  ;
  (self._endTime_text):SetText((TextManager.GetText)(((self._record).WordId)[5]))
  ;
  (self._exchange_text):SetText((TextManager.GetText)(((self._record).WordId)[6]))
  ;
  (self._recycleBtn_text):SetText((TextManager.GetText)(((self._record).WordId)[11]))
  local imageRecord = (self._item):GetIcon()
  ;
  (self._moonCakeBtn):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local allIds = CMidAutumnLines:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CMidAutumnLines:GetRecorder(allIds[i])
    if record.activityid == self._activityId then
      if record.type == 1 then
        (table.insert)(self._normalLines, record.id)
      else
        -- DECOMPILER ERROR at PC120: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self._conditionLines)[record.type] = record.id
      end
    end
  end
  allIds = ActivityJackpot:GetAllIds()
  len = #allIds
  for i = 1, len do
    local record = ActivityJackpot:GetRecorder(allIds[i])
    if record.activityId == self._activityId then
      self._activityJackpotRecord = record
      break
    end
  end
  do
    self:Init()
  end
end

MidAutumnDialog.Init = function(self)
  -- function num : 0_7 , upvalues : RefreshBtn, RefreshBubbleAnimation, _ENV, Item, SetLines
  RefreshBtn(self)
  RefreshBubbleAnimation(self)
  local map = {}
  local temp1 = (string.split)((self._activityJackpotRecord).interfaceItems, ",")
  for i,v in ipairs(temp1) do
    local itemId = tonumber(v)
    if not map[itemId] then
      map[itemId] = true
      local item = (Item.Create)(itemId)
      if item then
        (table.insert)(self._itemList, item)
      end
    end
  end
  ;
  (table.sort)(self._itemList, function(a, b)
    -- function num : 0_7_0
    if b:GetID() >= a:GetID() then
      do return a:GetPinJiID() ~= b:GetPinJiID() end
      do return b:GetPinJiID() < a:GetPinJiID() end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (self._itemFrame):ReloadAllCell()
  local localTipsKey = "OpenMidAutumnDialog_" .. self._activityId
  local moonCakeNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId)
  if ((NekoData.BehaviorManager).BM_Activity):GetMidAutumnLeftTime() <= 0 then
    SetLines(self, (self._conditionLines)[4])
  else
    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips)[localTipsKey]) and moonCakeNum > 0 then
      SetLines(self, (self._conditionLines)[3])
    else
      if moonCakeNum > 0 then
        SetLines(self, (self._conditionLines)[3])
      else
        if moonCakeNum <= 0 then
          SetLines(self, (self._conditionLines)[2])
        end
      end
    end
  end
end

MidAutumnDialog.OnRefreshMidAutumnLeftTime = function(self, notification)
  -- function num : 0_8 , upvalues : RefreshBtn, RefreshBubbleAnimation
  RefreshBtn(self)
  RefreshBubbleAnimation(self)
end

MidAutumnDialog.OnRefreshCurrency = function(self)
  -- function num : 0_9 , upvalues : RefreshBtn
  RefreshBtn(self)
end

MidAutumnDialog.OnGoBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100379)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Activity):GetMidAutumnLeftTime() > 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
    do
      if dialog then
        local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
        dialog:Init(sceneController)
        dialog:ItemTipsJump({gainType = (DataCommon.GainTypeEnum).ResourceMain})
      end
      self:Destroy()
    end
  end
end

MidAutumnDialog.OnExchangeBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.midautumn.exchangedialog")):SetRecord(self._record)
end

MidAutumnDialog.OnRecycleBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV, CActivityExchange
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._record).MoneyId) > 0 then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivityexchange")
    protocol.activityId = self._activityId
    protocol.exchangeType = CActivityExchange.RECYCLE
    protocol:Send()
    LogInfoFormat("MidAutumnDialog", "activityId = %s, exchangeType = %s", protocol.activityId, protocol.exchangeType)
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100378, {(self._item):GetName()})
    end
  end
end

MidAutumnDialog.OnMoonCakeBtnClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self._moonCakeBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._moonCakeBtn):GetLocalPointInUiRootPanel())
  end
end

MidAutumnDialog.OnMoonCakeAddBtnClick = function(self)
  -- function num : 0_14
  self:OnGoBtnClicked()
end

MidAutumnDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

MidAutumnDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

MidAutumnDialog.OnAnimationStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_17 , upvalues : _ENV
  if stateName == "CharDataMainDialogHide" then
    (self._dialogPanel):SetActive(false)
    if self._contentTimer then
      (GameTimer.RemoveTask)(self._contentTimer)
      self._contentTimer = nil
    end
  end
end

MidAutumnDialog.OnCatClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV, SetLines
  if self._contentTimer then
    return 
  end
  local len = #self._normalLines
  if len > 0 then
    local index = (math.random)(1, len)
    SetLines(self, (self._normalLines)[index])
  end
end

MidAutumnDialog.NumberOfCell = function(self, frame)
  -- function num : 0_19
  return #self._itemList
end

MidAutumnDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_20
  return "activity.midautumn.midautumnitemcell"
end

MidAutumnDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_21
  return (self._itemList)[index]
end

return MidAutumnDialog

