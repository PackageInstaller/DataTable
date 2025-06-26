-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/autoexplorecontinuedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local AutoExploreContinueDialog = class("AutoExploreContinueDialog", Dialog)
AutoExploreContinueDialog.AssetBundleName = "ui/layouts.mainline"
AutoExploreContinueDialog.AssetName = "AutoExploreContinue"
AutoExploreContinueDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AutoExploreContinueDialog
  ((AutoExploreContinueDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._autoExploreTimes = 0
end

local limit = nil
local MillisecondToDay = 86400000
AutoExploreContinueDialog.OnCreate = function(self)
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

AutoExploreContinueDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AutoExploreContinueDialog.SetInfo = function(self, data)
  -- function num : 0_3
  self._copyType = data.copyType
  self._copyID = data.id
  self._spriteCost = data.spirit
  ;
  (self._spiritNum):SetText(self._spriteCost)
  self._autoExploreTimes = 1
  ;
  (self._number):SetText(self._autoExploreTimes)
  ;
  (self._minusBtn):SetInteractable(false)
  self:SetRedDot()
end

AutoExploreContinueDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

AutoExploreContinueDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._copyType == "AutoExploreMainline" then
    local mainLineFloorDialog = (DialogManager.GetDialog)("mainline.mainline.newmainlinefloordialog")
    if mainLineFloorDialog then
      mainLineFloorDialog._auto = true
    end
  else
    do
      do
        if self._copyType == "AutoExploreResource" then
          local resourceFloorDialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
          if resourceFloorDialog then
            resourceFloorDialog._auto = true
          end
        end
        local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
        if dialog then
          dialog:SetCopyInfo(self._copyType, self._copyID)
        end
        local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cclickautoexplore")
        if csend then
          csend.zoneId = self._copyID
          csend:Send()
        end
        local data = {current = 0, totle = self._autoExploreTimes}
        ;
        ((NekoData.DataManager).DM_Game):SetAutoExploreTimes(data)
        self:Destroy()
      end
    end
  end
end

AutoExploreContinueDialog.OnAddBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local tempTimes = self._autoExploreTimes + 1
  if self._spirit < tempTimes * self._spriteCost then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100013)
    if not self._tipShowing then
      (self._tipAnim):SetTrigger("showTip")
      self._tipShowing = true
    end
    return 
  end
  self._autoExploreTimes = tempTimes
  ;
  (self._number):SetText(self._autoExploreTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._autoExploreTimes)
  if self._autoExploreTimes > 1 then
    (self._minusBtn):SetInteractable(true)
  end
end

AutoExploreContinueDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local tempTimes = (math.floor)(self._spirit / self._spriteCost)
  self._autoExploreTimes = tempTimes
  ;
  (self._number):SetText(self._autoExploreTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._autoExploreTimes)
  if self._autoExploreTimes > 1 then
    (self._minusBtn):SetInteractable(true)
  end
end

AutoExploreContinueDialog.OnMinusBtnClicked = function(self)
  -- function num : 0_8
  local tempTimes = self._autoExploreTimes - 1
  self._autoExploreTimes = tempTimes
  ;
  (self._number):SetText(self._autoExploreTimes)
  ;
  (self._spiritNum):SetText(self._spriteCost * self._autoExploreTimes)
  if tempTimes == 1 then
    (self._minusBtn):SetInteractable(false)
  end
end

AutoExploreContinueDialog.OnAddVITBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
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

AutoExploreContinueDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText((NumberManager.GetShowNumber)(self._spirit) .. "/" .. (NumberManager.GetShowNumber)(limit))
end

AutoExploreContinueDialog.HaveSpiritItemSoonExpire = function(self)
  -- function num : 0_11 , upvalues : _ENV, MillisecondToDay
  local spiritItems = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListByTypeID(DataCommon.SpiritItemType)
  for i,v in ipairs(spiritItems) do
    local deltime = v:GetDelTime()
    if deltime and deltime - (ServerGameTimer.GetServerTime)() < MillisecondToDay then
      return true
    end
  end
  return false
end

AutoExploreContinueDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_12
  if stateName == "ShowTip" then
    self._tipShowing = false
  end
end

AutoExploreContinueDialog.SetRedDot = function(self)
  -- function num : 0_13
  (self._vitRedDot):SetActive(self:HaveSpiritItemSoonExpire())
end

return AutoExploreContinueDialog

