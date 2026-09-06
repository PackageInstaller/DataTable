local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local AutoExploreContinueDialog = class("AutoExploreContinueDialog", Dialog)
AutoExploreContinueDialog.AssetBundleName = "ui/layouts.mainline"
AutoExploreContinueDialog.AssetName = "AutoExploreContinue"

function AutoExploreContinueDialog:Ctor(...)
  AutoExploreContinueDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._autoExploreTimes = 0
end

local limit
local MillisecondToDay = 86400000

function AutoExploreContinueDialog:OnCreate()
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

function AutoExploreContinueDialog:OnDestroy()
end

function AutoExploreContinueDialog:SetInfo(data)
  self._copyType = data.copyType
  self._copyID = data.id
  self._spriteCost = data.spirit
  self._spiritNum:SetText(self._spriteCost)
  self._autoExploreTimes = 1
  self._number:SetText(self._autoExploreTimes)
  self._minusBtn:SetInteractable(false)
  self:SetRedDot()
end

function AutoExploreContinueDialog:OnBackBtnClicked()
  self:Destroy()
end

function AutoExploreContinueDialog:OnConfirmBtnClicked()
  if self._copyType == "AutoExploreMainline" then
    local mainLineFloorDialog = DialogManager.GetDialog("mainline.mainline.newmainlinefloordialog")
    if mainLineFloorDialog then
      mainLineFloorDialog._auto = true
    end
  elseif self._copyType == "AutoExploreResource" then
    local resourceFloorDialog = DialogManager.GetDialog("mainline.resource.resourcefloordialog")
    if resourceFloorDialog then
      resourceFloorDialog._auto = true
    end
  end
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    dialog:SetCopyInfo(self._copyType, self._copyID)
  end
  local csend = LuaNetManager.CreateProtocol("protocol.battle.cclickautoexplore")
  if csend then
    csend.zoneId = self._copyID
    csend:Send()
  end
  local data = {
    current = 0,
    totle = self._autoExploreTimes
  }
  NekoData.DataManager.DM_Game:SetAutoExploreTimes(data)
  self:Destroy()
end

function AutoExploreContinueDialog:OnAddBtnClicked()
  local tempTimes = self._autoExploreTimes + 1
  if tempTimes * self._spriteCost > self._spirit then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100013)
    if not self._tipShowing then
      self._tipAnim:SetTrigger("showTip")
      self._tipShowing = true
    end
    return
  end
  self._autoExploreTimes = tempTimes
  self._number:SetText(self._autoExploreTimes)
  self._spiritNum:SetText(self._spriteCost * self._autoExploreTimes)
  if self._autoExploreTimes > 1 then
    self._minusBtn:SetInteractable(true)
  end
end

function AutoExploreContinueDialog:OnMaxBtnClicked()
  local tempTimes = math.floor(self._spirit / self._spriteCost)
  self._autoExploreTimes = tempTimes
  self._number:SetText(self._autoExploreTimes)
  self._spiritNum:SetText(self._spriteCost * self._autoExploreTimes)
  if self._autoExploreTimes > 1 then
    self._minusBtn:SetInteractable(true)
  end
end

function AutoExploreContinueDialog:OnMinusBtnClicked()
  local tempTimes = self._autoExploreTimes - 1
  self._autoExploreTimes = tempTimes
  self._number:SetText(self._autoExploreTimes)
  self._spiritNum:SetText(self._spriteCost * self._autoExploreTimes)
  if tempTimes == 1 then
    self._minusBtn:SetInteractable(false)
  end
end

function AutoExploreContinueDialog:OnAddVITBtnClicked()
  if self._tipShowing then
    return
  end
  NekoData.BehaviorManager.BM_Currency:RequestOpenAddCurrencyDlg(DataCommon.SpiritID)
  local dialog = DialogManager.GetDialog("guide.guidedialog")
  if dialog then
    dialog:Destroy()
  end
end

function AutoExploreContinueDialog:RefreshSpirit(notification)
  self._spirit = notification.userInfo.spirit
  self._vitNum:SetText(NumberManager.GetShowNumber(self._spirit) .. "/" .. NumberManager.GetShowNumber(limit))
end

function AutoExploreContinueDialog:HaveSpiritItemSoonExpire()
  local spiritItems = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(DataCommon.SpiritItemType)
  for i, v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - ServerGameTimer.GetServerTime() < MillisecondToDay then
      return true
    end
  end
  return false
end

function AutoExploreContinueDialog:OnAnimationStateExit(handler, stateName, normalizedTime)
  if stateName == "ShowTip" then
    self._tipShowing = false
  end
end

function AutoExploreContinueDialog:SetRedDot()
  self._vitRedDot:SetActive(self:HaveSpiritItemSoonExpire())
end

return AutoExploreContinueDialog
