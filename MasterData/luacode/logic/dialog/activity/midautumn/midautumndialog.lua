local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local catShapeRecorder = BeanManager.GetTableByName("npc.cnpcshape"):GetRecorder(9)
local ActivityJackpot = BeanManager.GetTableByName("item.cactivityjackpot")
local CMidAutumnLines = BeanManager.GetTableByName("dialog.cmidautumnlines")
local CActivityExchange = require("protocols.def.protocol.activity.cactivityexchange")
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MoonCakeMinNum = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(111).Value)
local MidAutumnDialog = class("MidAutumnDialog", Dialog)
MidAutumnDialog.AssetBundleName = "ui/layouts.activitymidautumn"
MidAutumnDialog.AssetName = "ActivityMidAutumnMain"

function MidAutumnDialog:Ctor(...)
  MidAutumnDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._normalLines = {}
  self._conditionLines = {}
  self._itemList = {}
end

function MidAutumnDialog:OnCreate()
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._model = self:GetChild("UI/ModelBack/Model/Char_CatUI")
  self._bubble = self:GetChild("UI/ModelBack/ModelPop/NPCBubbleUI")
  self._animator_cat = self._model:GetUIObject():GetComponent("Animator")
  self._animator = self._bubble:GetUIObject():GetComponent("Animator")
  if Live2DManager.CanUse() and catShapeRecorder.live2DAssetBundleName and catShapeRecorder.live2DAssetBundleName ~= "" and catShapeRecorder.live2DPrefabName and catShapeRecorder.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._live2D:AddLive2D(catShapeRecorder.live2DAssetBundleName, catShapeRecorder.live2DPrefabName, catShapeRecorder.live2DScale)
  else
    self._photo:SetActive(true)
    local recorder = CImagePathTable:GetRecorder(catShapeRecorder.lihuiID) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
  end
  self._animator_cat:Play("IdleLeftUI")
  self._dialogPanel = self:GetChild("UI/Dialog")
  self._dialogPanel_txt = self:GetChild("UI/Dialog/Text")
  self._dialogPanel_width, self._dialogPanel_height = self._dialogPanel:GetDeltaSize()
  self._dialogPanel_txt_width, self._dialogPanel_txt_height = self._dialogPanel_txt:GetDeltaSize()
  self._dialogPanel:SetActive(false)
  self._dialogPanel:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  self:GetChild("Role"):Subscribe_PointerClickEvent(self.OnCatClicked, self)
  self._moonCakeNumTxt = self:GetChild("TopGroupCell/Num0/Text")
  self._moonCakeBtn = self:GetChild("TopGroupCell/Num0/Icon")
  self._moonCakeAddBtn = self:GetChild("TopGroupCell/Num0/Add (1)")
  self:GetChild("TopGroupCell/Num0/Add"):SetActive(false)
  self._goBtn = self:GetChild("UI/GoBtn")
  self._itemPanel = self:GetChild("UI/Frame/Panel")
  self._exchangeBtn = self:GetChild("UI/Frame/GetBtn")
  self._recycleBtn = self:GetChild("UI/Frame/BtnHS")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, true, false)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._exchangeBtn:Subscribe_PointerClickEvent(self.OnExchangeBtnClicked, self)
  self._recycleBtn:Subscribe_PointerClickEvent(self.OnRecycleBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._moonCakeBtn:Subscribe_PointerClickEvent(self.OnMoonCakeBtnClick, self)
  self._moonCakeNumTxt:Subscribe_PointerClickEvent(self.OnMoonCakeBtnClick, self)
  self._moonCakeAddBtn:Subscribe_PointerClickEvent(self.OnMoonCakeAddBtnClick, self)
  self._goBtn_text = self:GetChild("UI/GoBtn/_Text")
  self._tips = self:GetChild("UI/Tips")
  self._maybe_text = self:GetChild("UI/Frame/Text")
  self._startTime_text = self:GetChild("UI/Time/StartTime")
  self._endTime_text = self:GetChild("UI/Time/EndTime")
  self._exchange_text = self:GetChild("UI/Frame/GetBtn/_Text")
  self._recycleBtn_text = self:GetChild("UI/Frame/BtnHS/_Text")
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMidAutumnLeftTime, Common.n_RefreshMidAutumnLeftTime, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
end

function MidAutumnDialog:OnDestroy()
  self._itemFrame:Destroy()
  DialogManager.DestroySingletonDialog("activity.midautumn.exchangedialog")
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
end

local function RefreshBtn(self)
  local tag = NekoData.BehaviorManager.BM_Activity:GetMidAutumnLeftTime() > 0
  self._moonCakeAddBtn:SetActive(tag)
  self._goBtn:SetInteractable(tag)
  local currencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId)
  tag = not tag and currencyNum < MoonCakeMinNum
  self._recycleBtn:SetActive(tag)
  self._exchangeBtn:SetActive(not tag)
  self._moonCakeNumTxt:SetNumber(currencyNum)
end

local function RefreshBubbleAnimation(self)
  local tag = NekoData.BehaviorManager.BM_Activity:GetMidAutumnLeftTime() > 0
  if tag then
    self._animator:Play("dots")
    self._animator:SetInteger("New Int", 0)
  else
    self._animator:Play("sleep")
    self._animator:SetInteger("New Int", 1)
  end
end

local function SetLines(self, lineId)
  if self._contentTimer then
    return
  end
  self._dialogPanel:SetActive(true)
  self._dialogPanel:PlayAnimation("CharDataMainDialogShow")
  local recorder = CMidAutumnLines:GetRecorder(lineId)
  local str = TextManager.GetText(recorder.textId)
  self._dialogPanel_txt:SetText(str)
  local _, textheight = self._dialogPanel_txt:GetPreferredSize()
  if textheight > self._dialogPanel_txt_height then
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, textheight)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  local text = string.trim(str)
  self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
    self._dialogPanel:PlayAnimation("CharDataMainDialogHide")
  end)
end

function MidAutumnDialog:SetRecord(record)
  self._record = record
  self._activityId = self._record.id
  LogInfoFormat("MidAutumnDialog", "activityId = %s", self._activityId)
  self._item = Item.Create(self._record.MoneyId)
  self._goBtn_text:SetText(TextManager.GetText(self._record.WordId[1]))
  self._tips:SetText(string.gsub(TextManager.GetText(self._record.WordId[2]), "%$parameter1%$", self._item:GetName()))
  self._maybe_text:SetText(TextManager.GetText(self._record.WordId[3]))
  self._startTime_text:SetText(TextManager.GetText(self._record.WordId[4]))
  self._endTime_text:SetText(TextManager.GetText(self._record.WordId[5]))
  self._exchange_text:SetText(TextManager.GetText(self._record.WordId[6]))
  self._recycleBtn_text:SetText(TextManager.GetText(self._record.WordId[11]))
  local imageRecord = self._item:GetIcon()
  self._moonCakeBtn:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local allIds = CMidAutumnLines:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CMidAutumnLines:GetRecorder(allIds[i])
    if record.activityid == self._activityId then
      if record.type == 1 then
        table.insert(self._normalLines, record.id)
      else
        self._conditionLines[record.type] = record.id
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
  self:Init()
end

function MidAutumnDialog:Init()
  RefreshBtn(self)
  RefreshBubbleAnimation(self)
  local map = {}
  local temp1 = string.split(self._activityJackpotRecord.interfaceItems, ",")
  for i, v in ipairs(temp1) do
    local itemId = tonumber(v)
    if not map[itemId] then
      map[itemId] = true
      local item = Item.Create(itemId)
      if item then
        table.insert(self._itemList, item)
      end
    end
  end
  table.sort(self._itemList, function(a, b)
    if a:GetPinJiID() == b:GetPinJiID() then
      return a:GetID() > b:GetID()
    else
      return a:GetPinJiID() > b:GetPinJiID()
    end
  end)
  self._itemFrame:ReloadAllCell()
  local localTipsKey = "OpenMidAutumnDialog_" .. self._activityId
  local moonCakeNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId)
  if NekoData.BehaviorManager.BM_Activity:GetMidAutumnLeftTime() <= 0 then
    SetLines(self, self._conditionLines[4])
  elseif NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips[localTipsKey]) and 0 < moonCakeNum then
    SetLines(self, self._conditionLines[3])
  elseif 0 < moonCakeNum then
    SetLines(self, self._conditionLines[3])
  elseif moonCakeNum <= 0 then
    SetLines(self, self._conditionLines[2])
  end
end

function MidAutumnDialog:OnRefreshMidAutumnLeftTime(notification)
  RefreshBtn(self)
  RefreshBubbleAnimation(self)
end

function MidAutumnDialog:OnRefreshCurrency()
  RefreshBtn(self)
end

function MidAutumnDialog:OnGoBtnClicked()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Resource) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100379)
    return
  end
  if NekoData.BehaviorManager.BM_Activity:GetMidAutumnLeftTime() > 0 then
    local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
      dialog:Init(sceneController)
      dialog:ItemTipsJump({
        gainType = DataCommon.GainTypeEnum.ResourceMain
      })
    end
    self:Destroy()
  end
end

function MidAutumnDialog:OnExchangeBtnClicked()
  DialogManager.CreateSingletonDialog("activity.midautumn.exchangedialog"):SetRecord(self._record)
end

function MidAutumnDialog:OnRecycleBtnClicked()
  if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._record.MoneyId) > 0 then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cactivityexchange")
    protocol.activityId = self._activityId
    protocol.exchangeType = CActivityExchange.RECYCLE
    protocol:Send()
    LogInfoFormat("MidAutumnDialog", "activityId = %s, exchangeType = %s", protocol.activityId, protocol.exchangeType)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100378, {
      self._item:GetName()
    })
  end
end

function MidAutumnDialog:OnMoonCakeBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self._moonCakeBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._moonCakeBtn:GetLocalPointInUiRootPanel())
  end
end

function MidAutumnDialog:OnMoonCakeAddBtnClick()
  self:OnGoBtnClicked()
end

function MidAutumnDialog:OnBackBtnClicked()
  self:Destroy()
end

function MidAutumnDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function MidAutumnDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "CharDataMainDialogHide" then
    self._dialogPanel:SetActive(false)
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
    end
  end
end

function MidAutumnDialog:OnCatClicked()
  if self._contentTimer then
    return
  end
  local len = #self._normalLines
  if 0 < len then
    local index = math.random(1, len)
    SetLines(self, self._normalLines[index])
  end
end

function MidAutumnDialog:NumberOfCell(frame)
  return #self._itemList
end

function MidAutumnDialog:CellAtIndex(frame, index)
  return "activity.midautumn.midautumnitemcell"
end

function MidAutumnDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return MidAutumnDialog
