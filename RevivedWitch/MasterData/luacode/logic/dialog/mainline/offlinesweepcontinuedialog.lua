-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinesweepcontinuedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local OfflineSweepContinueDialog = class("OfflineSweepContinueDialog", Dialog)
OfflineSweepContinueDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepContinueDialog.AssetName = "DispatchBattleContinue"
OfflineSweepContinueDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflineSweepContinueDialog, _ENV
  ((OfflineSweepContinueDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._dispatchTimes = 0
  self._bm = (NekoData.BehaviorManager).BM_OfflineSweep
end

local limit = nil
local MillisecondToDay = 86400000
OfflineSweepContinueDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : limit, _ENV, AnimatorStaticFunctions
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._number = self:GetChild("Back/Num/Num")
  self._addBtn = self:GetChild("Back/Num/AddBtn")
  self._maxBtn = self:GetChild("Back/Num/MaxBtn")
  self._minusBtn = self:GetChild("Back/Num/MinusBtn")
  self._spiritNum = self:GetChild("Back/CostBack/Txt2")
  self._vit = self:GetChild("Back/TopGroup/VIT")
  self._vitNum = self:GetChild("Back/TopGroup/VIT/Text")
  self._addVIT = self:GetChild("Back/TopGroup/VIT/Add")
  self._vitRedDot = self:GetChild("Back/TopGroup/VIT/RedDot")
  self._vitPanel = self:GetChild("Back/TopGroup/VIT")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  self._wordText = self:GetChild("Back/WordText")
  self._levelTxt = self:GetChild("Back/Icon/Text")
  self._levelIcon = self:GetChild("Back/Icon")
  self._title = self:GetChild("Back/Title")
  self._numtext = self:GetChild("Back/Num/Text")
  self._costText = self:GetChild("Back/CostBack/Txt1")
  self._timesTxt = self:GetChild("Back/Text1")
  ;
  (self._timesTxt):SetActive(false)
  self.confirmBtn_Text = self:GetChild("Back/ConfirmButton/_Text")
  self.cancelBtn_Text = self:GetChild("Back/CancelButton/_Text")
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1856))
  ;
  (self._numtext):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1857))
  ;
  (self._costText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1869))
  ;
  (self._timesTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1858))
  ;
  (self.confirmBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1662))
  ;
  (self.cancelBtn_Text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1753))
  self._times = self:GetChild("Back/Text2")
  ;
  (self._times):SetActive(false)
  self._tip = self:GetChild("Back/Tip")
  self._tipAnim = (AnimatorStaticFunctions.Get)((self:GetRootWindow())._uiObject)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._vitPanel):Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._minusBtn):Subscribe_PointerClickEvent(self.OnMinusBtnClicked, self)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.SetRedDot, Common.n_ItemNumModify, nil)
end

OfflineSweepContinueDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

local GetDelTimeStr = function(s)
  -- function num : 0_3 , upvalues : _ENV
  return (string.format)("%s:%s:%s", (os.date)("!%H", s), (os.date)("!%M", s), (os.date)("!%S", s))
end

OfflineSweepContinueDialog.SetInfo = function(self, data)
  -- function num : 0_4 , upvalues : GetDelTimeStr, CImagePathTable, _ENV
  self._copyType = data.copyType
  self._copyID = data.id
  self._spriteCost = data.spirit
  self._timelength = data.timelength
  ;
  (self._times):SetText(GetDelTimeStr(self._timelength))
  ;
  (self._levelTxt):SetText(data.name)
  if data.littleImgID then
    if not CImagePathTable:GetRecorder(data.littleImgID) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._levelIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._levelIcon):SetActive(true)
    ;
    (self._wordText):SetActive(false)
  else
    do
      ;
      (self._levelIcon):SetActive(false)
      ;
      (self._wordText):SetActive(true)
      ;
      (self._wordText):SetText(data.name)
      ;
      (self._spiritNum):SetText(self._spriteCost)
      self._dispatchTimes = 1
      ;
      (self._number):SetText(self._dispatchTimes)
      ;
      (self._minusBtn):SetInteractable(false)
      self:SetRedDot()
    end
  end
end

OfflineSweepContinueDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

OfflineSweepContinueDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo(self._copyType, self._copyID, self._dispatchTimes)
  end
  self:Destroy()
end

OfflineSweepContinueDialog.OnAddBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, GetDelTimeStr
  local tempTimes = self._dispatchTimes + 1
  local limit = (self._bm):GetTodayLeftNum()
  if limit < tempTimes then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100471)
    return 
  end
  if self._spirit < tempTimes * self._spriteCost then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100013)
    if not self._tipShowing then
      (self._tipAnim):SetTrigger("showTip")
      self._tipShowing = true
    end
    return 
  end
  self._dispatchTimes = tempTimes
  ;
  (self._number):SetText(self._dispatchTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._dispatchTimes)
  ;
  (self._times):SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if self._dispatchTimes > 1 then
    (self._minusBtn):SetInteractable(true)
  end
end

OfflineSweepContinueDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, GetDelTimeStr
  local tempTimes = (math.floor)(self._spirit / self._spriteCost)
  local limit = (self._bm):GetTodayLeftNum()
  local tempTimes = (math.min)(tempTimes, limit)
  self._dispatchTimes = tempTimes
  ;
  (self._number):SetText(self._dispatchTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._dispatchTimes)
  ;
  (self._times):SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if self._dispatchTimes > 1 then
    (self._minusBtn):SetInteractable(true)
  end
end

OfflineSweepContinueDialog.OnMinusBtnClicked = function(self)
  -- function num : 0_9 , upvalues : GetDelTimeStr
  local tempTimes = self._dispatchTimes - 1
  self._dispatchTimes = tempTimes
  ;
  (self._number):SetText(self._dispatchTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._dispatchTimes)
  ;
  (self._times):SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if tempTimes == 1 then
    (self._minusBtn):SetInteractable(false)
  end
end

OfflineSweepContinueDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if self._tipShowing then
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_Currency):RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  local dialog = (DialogManager.GetDialog)("guide.guidedialog")
  if dialog then
    dialog:Destroy()
  end
end

OfflineSweepContinueDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_11 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
end

OfflineSweepContinueDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_12 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

OfflineSweepContinueDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_13
  if stateName == "ShowTip" then
    self._tipShowing = false
  end
end

OfflineSweepContinueDialog.SetRedDot = function(self)
  -- function num : 0_14
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

return OfflineSweepContinueDialog

