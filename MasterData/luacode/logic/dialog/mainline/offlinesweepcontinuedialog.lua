local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local Item = require("logic.manager.experimental.types.item")
local OfflineSweepContinueDialog = class("OfflineSweepContinueDialog", Dialog)
OfflineSweepContinueDialog.AssetBundleName = "ui/layouts.dispatchbattle"
OfflineSweepContinueDialog.AssetName = "DispatchBattleContinue"

function OfflineSweepContinueDialog:Ctor(...)
  OfflineSweepContinueDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._dispatchTimes = 0
  self._bm = NekoData.BehaviorManager.BM_OfflineSweep
end

local limit
local MillisecondToDay = 86400000

function OfflineSweepContinueDialog:OnCreate()
  limit = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().strengthLimit
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
  self._timesTxt:SetActive(false)
  self.confirmBtn_Text = self:GetChild("Back/ConfirmButton/_Text")
  self.cancelBtn_Text = self:GetChild("Back/CancelButton/_Text")
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(1856))
  self._numtext:SetText(NekoData.BehaviorManager.BM_Message:GetString(1857))
  self._costText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1869))
  self._timesTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1858))
  self.confirmBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1662))
  self.cancelBtn_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1753))
  self._times = self:GetChild("Back/Text2")
  self._times:SetActive(false)
  self._tip = self:GetChild("Back/Tip")
  self._tipAnim = AnimatorStaticFunctions.Get(self:GetRootWindow()._uiObject)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._vitPanel:Subscribe_PointerClickEvent(self.OnAddVITBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._minusBtn:Subscribe_PointerClickEvent(self.OnMinusBtnClicked, self)
  self._spirit = NekoData.BehaviorManager.BM_Currency:GetSpirit()
  self._vitNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  LuaNotificationCenter.AddObserver(self, self.SetRedDot, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.SetRedDot, Common.n_ItemNumModify, nil)
end

function OfflineSweepContinueDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

local function GetDelTimeStr(s)
  return string.format("%s:%s:%s", os.date("!%H", s), os.date("!%M", s), os.date("!%S", s))
end

function OfflineSweepContinueDialog:SetInfo(data)
  self._copyType = data.copyType
  self._copyID = data.id
  self._spriteCost = data.spirit
  self._timelength = data.timelength
  self._times:SetText(GetDelTimeStr(self._timelength))
  self._levelTxt:SetText(data.name)
  if data.littleImgID then
    local imageRecord = CImagePathTable:GetRecorder(data.littleImgID) or DataCommon.DefaultImageAsset
    self._levelIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._levelIcon:SetActive(true)
    self._wordText:SetActive(false)
  elseif data.tagItem then
    local imageRecord = Item.Create(data.tagItem):GetIcon()
    if imageRecord then
      self._levelIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._levelIcon:SetActive(true)
      self._wordText:SetActive(false)
    else
      self._levelIcon:SetActive(false)
      self._wordText:SetActive(true)
      self._wordText:SetText(data.name)
    end
  else
    self._levelIcon:SetActive(false)
    self._wordText:SetActive(true)
    self._wordText:SetText(data.name)
  end
  self._spiritNum:SetText(self._spriteCost)
  self._dispatchTimes = 1
  self._number:SetText(self._dispatchTimes)
  self._minusBtn:SetInteractable(false)
  self:SetRedDot()
end

function OfflineSweepContinueDialog:OnBackBtnClicked()
  self:Destroy()
end

function OfflineSweepContinueDialog:OnConfirmBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo(self._copyType, self._copyID, self._dispatchTimes)
  end
  self:Destroy()
end

function OfflineSweepContinueDialog:OnAddBtnClicked()
  local tempTimes = self._dispatchTimes + 1
  if self._copyType ~= "DispatchAnniversary" then
    local leftNum = self._bm:GetTodayLeftNum()
    if tempTimes > leftNum then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100471)
      return
    end
  end
  if tempTimes * self._spriteCost > self._spirit then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100013)
    if not self._tipShowing then
      self._tipAnim:SetTrigger("showTip")
      self._tipShowing = true
    end
    return
  end
  self._dispatchTimes = tempTimes
  self._number:SetText(self._dispatchTimes)
  self._spiritNum:SetText(self._spriteCost * self._dispatchTimes)
  self._times:SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if self._dispatchTimes > 1 then
    self._minusBtn:SetInteractable(true)
  end
end

function OfflineSweepContinueDialog:OnMaxBtnClicked()
  local tempTimes = math.floor(self._spirit / self._spriteCost)
  if self._copyType ~= "DispatchAnniversary" then
    local leftNum = self._bm:GetTodayLeftNum()
    tempTimes = math.min(tempTimes, leftNum)
  end
  self._dispatchTimes = tempTimes
  self._number:SetText(self._dispatchTimes)
  self._spiritNum:SetText(self._spriteCost * self._dispatchTimes)
  self._times:SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if self._dispatchTimes > 1 then
    self._minusBtn:SetInteractable(true)
  end
end

function OfflineSweepContinueDialog:OnMinusBtnClicked()
  local tempTimes = self._dispatchTimes - 1
  self._dispatchTimes = tempTimes
  self._number:SetText(self._dispatchTimes)
  self._spiritNum:SetText(self._spriteCost * self._dispatchTimes)
  self._times:SetText(GetDelTimeStr(self._timelength * self._dispatchTimes))
  if tempTimes == 1 then
    self._minusBtn:SetInteractable(false)
  end
end

function OfflineSweepContinueDialog:OnAddVITBtnClicked()
  if self._tipShowing then
    return
  end
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  local dialog = DialogManager.GetDialog("guide.guidedialog")
  if dialog then
    dialog:Destroy()
  end
end

function OfflineSweepContinueDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._vitNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
end

function OfflineSweepContinueDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function OfflineSweepContinueDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "ShowTip" then
    self._tipShowing = false
  end
end

function OfflineSweepContinueDialog:SetRedDot()
  self._vitRedDot:SetActive(self:HaveSpiritItemSoonExpire())
end

return OfflineSweepContinueDialog
