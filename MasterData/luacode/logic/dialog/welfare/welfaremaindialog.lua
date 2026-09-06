local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CWelfareTabCfg = BeanManager.GetTableByName("welfare.cwelfaretabconfig")
local GuidTypes = LuaNetManager.GetBeanDef("protocol.user.guidtypes")
local UnlockCfg = BeanManager.GetTableByName("recharge.cseasonpassunlock")
local CTotalLoginActivityShow = BeanManager.GetTableByName("welfare.ctotalloginactivityshow")
local CTotalLoginActivity = BeanManager.GetTableByName("welfare.ctotalloginactivity")
local WelfareMainDialog = class("WelfareMainDialog", Dialog)
WelfareMainDialog.AssetBundleName = "ui/layouts.welfare"
WelfareMainDialog.AssetName = "WelfareMain"
WelfareMainDialog.WelfareType = {
  growGift = 3,
  fitstRecharge = 4,
  sevenGrow = 5,
  dreamSpiral = 6,
  monthSign = 7,
  witchCalendar = 8,
  qixi = 7001,
  nationDay = 7002,
  beforeChristmas = 7003,
  recharge = 14001,
  signActivity14Day = 7004,
  newYear = 7005,
  uniqueEquip_overseas = 7006,
  foresight = 36001,
  limitedInvestment = 37001,
  anniversaryShare = 43001,
  accumulateCost = 50001,
  oldPlayerBenefits = 51001,
  minDisCount = 53001
}

function WelfareMainDialog:Ctor(...)
  WelfareMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._accumulatedSigned = false
  self._tabBtnData = {}
  self._selectedTab = nil
  self._signActivityRecords = {}
  local allIds = CTotalLoginActivity:GetAllIds()
  local len = #allIds
  for i = 1, len do
    self._signActivityRecords[allIds[i]] = CTotalLoginActivity:GetRecorder(allIds[i])
  end
end

function WelfareMainDialog:OnCreate()
  self._tabBtnPanel = self:GetChild("Group")
  self._frame = self:GetChild("Frame")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tabBtnFrame = TableFrame.Create(self._tabBtnPanel, self, true, true, true)
  self._tabFrame = TabFrame.Create(self._frame, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSignedState, Common.n_SignState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSignActivity, Common.n_RefreshSignActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshGrowGift, Common.n_RefreshGrowGift, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDreamInfo, Common.n_DreamSpiralRefresh, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshDreamRedDot, Common.n_TriggerGuide, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshTabBtnRedDot, Common.n_LocalTipsStateChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshLimitedInvestment, Common.n_RefreshLimitedInvestment, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMonthSign, Common.n_RefreshMonthSign, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshhWitchCalendar, Common.n_RefreshWitchCalendar, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshAnniversaryShareRedDot, Common.n_OnSAnniversaryShareInfo, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshForesightRedDot, Common.n_OnSGeneralForesightAct, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshAccumulateCost, Common.n_RefreshAccumulateCost, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshOldPlayerBenefits, Common.n_OnRefreshOldPlayerBenefits, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMinDiscount, Common.n_OnRefreshMinDiscount, nil)
end

function WelfareMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._tabBtnFrame:Destroy()
  self._tabFrame:Destroy()
  self._data = {}
end

function WelfareMainDialog:SetJumpTab(tabId)
  self._jumpTab = tabId
end

function WelfareMainDialog:SetData(f3, openOnInitial)
  self._tabBtnData = {}
  self._openOnInitial = openOnInitial
  if NekoData.BehaviorManager.BM_Welfare:IsWitchCalendarOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.witchCalendar),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot()
    })
  end
  local signActivities = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivities()
  table.sort(signActivities, function(a, b)
    local a_record = CWelfareTabCfg:GetRecorder(a.id)
    local b_record = CWelfareTabCfg:GetRecorder(b.id)
    return a_record.sort < b_record.sort
  end)
  for i, v in ipairs(signActivities) do
    if NekoData.BehaviorManager.BM_Activity:HasActivity(v.id) then
      local showEntrance = false
      local showRedDot = false
      local alwaysShow = CWelfareTabCfg:GetRecorder(v.id).alwaysShow == 1
      for _, award in ipairs(v.awards) do
        if not award.receive then
          showEntrance = true
          if award.index <= v.totalSignNum then
            showRedDot = true
          end
        end
      end
      local record = CWelfareTabCfg:GetRecorder(v.id)
      if (not self._openOnInitial or record.show ~= 0) and (showEntrance or alwaysShow) then
        table.insert(self._tabBtnData, {record = record, showRedDot = showRedDot})
      end
    end
  end
  self._accumulatedSigned = f3
  if not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() and self._accumulatedSigned and not NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot() then
    self._open = true
    self._menuBtn:SetActive(true)
  else
    self._menuBtn:SetActive(false)
  end
  if NekoData.BehaviorManager.BM_Welfare:GetAccumulatedIndex() ~= 0 then
    self._accumulatedSigned = false
  end
  self._accumulatedSigned = true
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.AccumulateCost) then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.accumulateCost),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowAccumulateCostRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.OldPlayerBenefits) then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.oldPlayerBenefits),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowOldPlayerWelfareRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.MinDiscount) and NekoData.BehaviorManager.BM_Welfare:IsShowMinDiscount() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.minDisCount),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowMinDiscountRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Foresight:GetIsOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.foresight),
      showRedDot = NekoData.BehaviorManager.BM_Foresight:GetHaveRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Welfare:IsLimitedInvestmentOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.limitedInvestment),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowLimitedInvestmentRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Welfare:IsMonthSignOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.monthSign),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowMonthSignRedDot()
    })
  end
  if not global_var_local_check and not self._openOnInitial and NekoData.BehaviorManager.BM_Welfare:ShowWelfareEntrance_GrowGift() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.growGift),
      showRedDot = NekoData.BehaviorManager.BM_Welfare:GrowGiftShowRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_SevenGrow:GetSevenDaysIsOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.sevenGrow),
      showRedDot = NekoData.BehaviorManager.BM_ActivityTasks:SevenDaysShowRedDot()
    })
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_AnniversaryShare:GetIsOpen() then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.anniversaryShare),
      showRedDot = NekoData.BehaviorManager.BM_AnniversaryShare:GetHaveRedDot()
    })
  end
  self._openDreamActId = self:GetOpenDreamActId()
  if not self._openOnInitial and 0 < self._openDreamActId then
    local tmpRecord = CWelfareTabCfg:GetRecorder(WelfareMainDialog.WelfareType.dreamSpiral)
    local cloneRecord = {}
    for key, value in pairs(tmpRecord) do
      cloneRecord[key] = value
    end
    local theRecord = UnlockCfg:GetRecorder(self._openDreamActId)
    if theRecord then
      cloneRecord.tabImg = theRecord.tabImg
      cloneRecord.tabImgSelected = theRecord.tabImgSelected
      cloneRecord.tabImgsmall = theRecord.tabImgsmall
      cloneRecord.tabImgSelectedsmall = theRecord.tabImgSelectedsmall
      table.insert(self._tabBtnData, {
        record = cloneRecord,
        showRedDot = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):ShowRedDot()
      })
    end
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn) then
    table.insert(self._tabBtnData, {
      record = CWelfareTabCfg:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn),
      showRedDot = false
    })
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenbackinvite")
    if protocol then
      protocol:Send()
    end
  end
  self._tabBtnFrame:ReloadAllCell()
  self._tabBtnFrame:MoveToTop()
  if not self._jumpTab then
    self:SelectNextTab()
  else
    self:SetSelectedTab(self._jumpTab)
    self._jumpTab = nil
  end
end

function WelfareMainDialog:SetSignInTab()
  local tabId = 0
  local signActivities = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivities()
  table.sort(signActivities, function(a, b)
    local a_record = CWelfareTabCfg:GetRecorder(a.id)
    local b_record = CWelfareTabCfg:GetRecorder(b.id)
    return a_record.sort < b_record.sort
  end)
  for i, v in ipairs(signActivities) do
    if NekoData.BehaviorManager.BM_Activity:HasActivity(v.id) then
      local showEntrance = false
      local alwaysShow = CWelfareTabCfg:GetRecorder(v.id).alwaysShow == 1
      for _, award in ipairs(v.awards) do
        if not award.receive then
          showEntrance = true
        end
      end
      local record = CWelfareTabCfg:GetRecorder(v.id)
      if (not self._openOnInitial or record.show ~= 0) and (showEntrance or alwaysShow) then
        tabId = record.id
      end
    end
  end
  if 0 < tabId then
    self:SetSelectedTab(tabId)
  end
end

function WelfareMainDialog:SetSelectedTab(tabId, refresh)
  if self._selectedTab ~= tabId then
    self._selectedTab = tabId
    self._tabBtnFrame:FireEvent("SelectedTab")
    local tabCell = self._tabFrame:ToPage(self._selectedTab)
    if self._signActivityRecords[tabId] then
      tabCell:RefreshTabCell(tabId, refresh)
    else
      tabCell:RefreshTabCell(refresh)
    end
  elseif refresh then
    local tabCell = self._tabFrame:GetCellAtIndex(tabId)
    if self._signActivityRecords[tabId] then
      tabCell:RefreshTabCell(tabId, refresh)
    else
      tabCell:RefreshTabCell(refresh)
    end
  end
end

function WelfareMainDialog:CellAtIndex(frame, index)
  if frame == self._tabFrame then
    if index == WelfareMainDialog.WelfareType.growGift then
      return "welfare.growgifttabcell"
    elseif index == WelfareMainDialog.WelfareType.sevenGrow then
      return "welfare.sevengrowtabbtncell"
    elseif index == WelfareMainDialog.WelfareType.foresight then
      return "welfare.foresight.mainpage"
    elseif index == WelfareMainDialog.WelfareType.dreamSpiral then
      return "shop.dreamspiralpage"
    elseif index == WelfareMainDialog.WelfareType.qixi then
      return "welfare.qixisignactivitytabcell"
    elseif index == WelfareMainDialog.WelfareType.nationDay then
      return "welfare.nationdaysignactivitytabcell"
    elseif index == WelfareMainDialog.WelfareType.beforeChristmas then
      return "welfare.beforechristmassignactivitytabcell"
    elseif index == WelfareMainDialog.WelfareType.recharge then
      return "welfare.recharge.welfarerechargedialog"
    elseif index == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.invitePlayerReturn then
      return "welfare.inviteplayerreturntabcell"
    elseif index == WelfareMainDialog.WelfareType.signActivity14Day then
      return "welfare.indefinitedaysignactivity.fourteendayssigntab"
    elseif table.contain(CTotalLoginActivityShow:GetAllIds(), index) then
      local record = CTotalLoginActivityShow:GetRecorder(index)
      if record.type == 1 then
        return "welfare.sevendaysignactivitytabcell"
      elseif record.type == 2 then
        return "welfare.indefinitedaysignactivity.fourteendayssigntab"
      else
        LogError("WelfareMainDialog:CellAtIndex", "Error type: " .. tostring(record.type))
        return "welfare.sevendaysignactivitytabcell"
      end
    elseif index == WelfareMainDialog.WelfareType.limitedInvestment then
      return "welfare.limitedinvestmenttabcell"
    elseif index == WelfareMainDialog.WelfareType.monthSign then
      return "welfare.monthsign.monthsigntabcell"
    elseif index == WelfareMainDialog.WelfareType.witchCalendar then
      return "welfare.witchcalendar.witchcalendartabcell"
    elseif index == WelfareMainDialog.WelfareType.anniversaryShare then
      return "welfare.anniversaryshare.mainpage"
    elseif index == WelfareMainDialog.WelfareType.oldPlayerBenefits then
      return "welfare.oldplayerbenefits.oldplayerbenefitstabcell"
    elseif index == WelfareMainDialog.WelfareType.minDisCount then
      return "welfare.mindiscount.mindiscounttabcell"
    elseif index == WelfareMainDialog.WelfareType.accumulateCost then
      return "welfare.accumulatecosttabcell"
    else
      return "welfare.signactivitytabcell"
    end
  else
    return "welfare.welfaretabbtncell"
  end
end

function WelfareMainDialog:NumberOfCell(frame, index)
  return #self._tabBtnData
end

function WelfareMainDialog:DataAtIndex(frame, index)
  return self._tabBtnData[index]
end

function WelfareMainDialog:RefreshTabBtnData(id, showRedDot)
  for _, v in ipairs(self._tabBtnData) do
    if v.record.id == id then
      v.showRedDot = showRedDot
      break
    end
  end
end

function WelfareMainDialog:OnRefreshSignedState(notification)
  local last_accumulatedSigned = self._accumulatedSigned
  local temp = notification.userInfo
  if temp.type == "accumulate" then
    self._accumulatedSigned = temp.state
    self._accumulatedSigned = true
  end
  if last_accumulatedSigned ~= self._accumulatedSigned and not self._accumulatedSigned then
    self:RefreshTabBtnData(WelfareMainDialog.WelfareType.accumulatedSigned, true)
    self._tabBtnFrame:FireEvent("RefreshRedDot", {
      tabId = WelfareMainDialog.WelfareType.accumulatedSigned,
      show = true
    })
  end
  if last_accumulatedSigned ~= self._accumulatedSigned then
    self:RefreshTabBtnData(WelfareMainDialog.WelfareType.accumulatedSigned, false)
    self._tabBtnFrame:FireEvent("RefreshRedDot", {
      tabId = WelfareMainDialog.WelfareType.accumulatedSigned,
      show = false
    })
  end
  if not self._open then
    if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() or NekoData.BehaviorManager.BM_Welfare:ShowWelfareRedDot() then
      local actId
      for i, v in ipairs(self._tabBtnData) do
        if v.showRedDot then
          actId = v.record.id
          break
        end
      end
      self:SetSelectedTab(actId, true)
    elseif not self._accumulatedSigned then
      self:SetSelectedTab(WelfareMainDialog.WelfareType.accumulatedSigned, true)
    end
  end
  NekoData.DataManager.DM_Welfare:SetSignState(self._accumulatedSigned)
  if not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() and self._accumulatedSigned and not NekoData.BehaviorManager.BM_Welfare:ShowWelfareRedDot() and not self._open then
    self:Destroy()
  end
end

local function SelectNext(self)
  if DialogManager.GetDialog("bag.itemaccountdialog") or DialogManager.GetDialog("gacha.gachamoviedialog") then
    self._next = true
  end
end

function WelfareMainDialog:OnDialogDestroy(notification)
  if self._next and not DialogManager.GetDialog("bag.itemaccountdialog") and not DialogManager.GetDialog("gacha.gachamoviedialog") then
    self._next = false
  end
end

function WelfareMainDialog:OnRefreshSignActivity(notification)
  local signActivities = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivities()
  table.sort(signActivities, function(a, b)
    local a_record = CWelfareTabCfg:GetRecorder(a.id)
    local b_record = CWelfareTabCfg:GetRecorder(b.id)
    return a_record.sort > b_record.sort
  end)
  for _, v in ipairs(self._tabBtnData) do
    if self._signActivityRecords[v.record.id] and not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityById(v.record.id) then
      self:RefreshTabBtnData(v.record.id, false)
    end
  end
  for i, v in ipairs(signActivities) do
    local showRedDot = false
    if NekoData.BehaviorManager.BM_Activity:HasActivity(v.id) then
      for _, award in ipairs(v.awards) do
        if award.index <= v.totalSignNum and not award.receive then
          showRedDot = true
          break
        end
      end
    end
    self:RefreshTabBtnData(v.id, showRedDot)
  end
  self._tabBtnFrame:ReloadAllCell()
  self._tabBtnFrame:MoveToTop()
  local tabId = notification.userInfo
  local tabCell = self._tabFrame:GetCellAtIndex(tabId)
  tabCell:RefreshTabCell(tabId, true, tabId == self._selectedTab)
  SelectNext(self)
end

function WelfareMainDialog:SelectNextTab()
  if not self._open and not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() and self._accumulatedSigned and not NekoData.BehaviorManager.BM_Welfare:ShowWelfareRedDot() and not NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot() then
    self:Destroy()
  elseif NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetSignActivityState() or NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot() then
    local actId
    for i, v in ipairs(self._tabBtnData) do
      if v.showRedDot then
        actId = v.record.id
        break
      end
    end
    self:SetSelectedTab(actId, true)
  else
    local has_need_to_sign = false
    if not self._accumulatedSigned and not has_need_to_sign then
      self:SetSelectedTab(WelfareMainDialog.WelfareType.accumulatedSigned)
      has_need_to_sign = true
    end
    if not has_need_to_sign then
      self:SetSelectedTab(self._tabBtnData[1].record.id)
    end
  end
end

function WelfareMainDialog:OnRefreshGrowGift()
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:GrowGiftShowRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.growGift, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.growGift,
    show = showRedDot
  })
  local tabCell = self._tabFrame:GetCellAtIndex(WelfareMainDialog.WelfareType.growGift)
  tabCell:RefreshTabCell(true, true)
end

function WelfareMainDialog:OnSActivityTasksUpdate()
  local showRedDot = NekoData.BehaviorManager.BM_ActivityTasks:SevenDaysShowRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.sevenGrow, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.sevenGrow,
    show = showRedDot
  })
end

function WelfareMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function WelfareMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function WelfareMainDialog:GetOpenDreamActId()
  return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):GetCurrentActId()
end

function WelfareMainDialog:RefreshDreamRedDot()
  local showRedDot = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID):ShowRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.dreamSpiral, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.dreamSpiral,
    show = showRedDot
  })
end

function WelfareMainDialog:RefreshDreamInfo()
  local openDreamId = self:GetOpenDreamActId()
  self._openDreamActId = openDreamId
  self:RefreshDreamRedDot()
  local tabCell = self._tabFrame:GetCellAtIndex(WelfareMainDialog.WelfareType.dreamSpiral)
  tabCell:RefreshTabCell()
end

function WelfareMainDialog:RefreshAnniversaryShareRedDot()
  local pageIndex
  for index, value in ipairs(self._tabBtnData) do
    if value.record.id == WelfareMainDialog.WelfareType.anniversaryShare then
      pageIndex = index
      break
    end
  end
  if pageIndex then
    local showRedDot = NekoData.BehaviorManager.BM_AnniversaryShare:GetHaveRedDot()
    self._tabBtnData[pageIndex].showRedDot = showRedDot
    self._tabBtnFrame:FireEvent("RefreshRedDot", {
      tabId = WelfareMainDialog.WelfareType.anniversaryShare,
      show = showRedDot
    })
  end
end

function WelfareMainDialog:RefreshTabBtnRedDot(notification)
  if notification.userInfo.type.Tag == DataCommon.LocalTips.LimitedInvestmentOpen.Tag then
    self:RefreshLimitedInvestmentTabBtnRedDot()
  elseif notification.userInfo.type.Tag == DataCommon.LocalTips.MonthSignOpen.Tag then
    self:RefreshMonthSignTabBtnRedDot()
  end
end

function WelfareMainDialog:RefreshForesightRedDot()
  local pageIndex
  for index, value in ipairs(self._tabBtnData) do
    if value.record.id == WelfareMainDialog.WelfareType.foresight then
      pageIndex = index
      break
    end
  end
  if pageIndex then
    local showRedDot = NekoData.BehaviorManager.BM_Foresight:GetHaveRedDot()
    self._tabBtnData[pageIndex].showRedDot = showRedDot
    self._tabBtnFrame:FireEvent("RefreshRedDot", {
      tabId = WelfareMainDialog.WelfareType.foresight,
      show = showRedDot
    })
  end
end

function WelfareMainDialog:RefreshLimitedInvestmentTabBtnRedDot()
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowLimitedInvestmentRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.limitedInvestment, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.limitedInvestment,
    show = showRedDot
  })
end

function WelfareMainDialog:OnRefreshLimitedInvestment()
  self:RefreshLimitedInvestmentTabBtnRedDot()
  local tabCell = self._tabFrame:GetCellAtIndex(WelfareMainDialog.WelfareType.limitedInvestment)
  tabCell:RefreshTabCell(true)
end

function WelfareMainDialog:RefreshMonthSignTabBtnRedDot()
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowMonthSignRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.monthSign, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.monthSign,
    show = showRedDot
  })
end

function WelfareMainDialog:OnRefreshMonthSign()
  self:RefreshMonthSignTabBtnRedDot()
  local tabCell = self._tabFrame:GetCellAtIndex(WelfareMainDialog.WelfareType.monthSign)
  tabCell:RefreshTabCell(true)
end

function WelfareMainDialog:RefreshWitchCalendarTabBtnRedDot()
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowWitchCalendarRedDot()
  self:RefreshTabBtnData(WelfareMainDialog.WelfareType.witchCalendar, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {
    tabId = WelfareMainDialog.WelfareType.witchCalendar,
    show = showRedDot
  })
end

function WelfareMainDialog:OnRefreshhWitchCalendar()
  self:RefreshWitchCalendarTabBtnRedDot()
  local tabCell = self._tabFrame:GetCellAtIndex(WelfareMainDialog.WelfareType.witchCalendar)
  tabCell:RefreshTabCell(true)
end

function WelfareMainDialog:OnRefreshAccumulateCost()
  local activityId = DataCommon.Activities.AccumulateCost
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowAccumulateCostRedDot()
  self:RefreshTabBtnData(activityId, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {tabId = activityId, show = showRedDot})
  local tabCell = self._tabFrame:GetCellAtIndex(activityId)
  tabCell:RefreshTabCell(true, true)
end

function WelfareMainDialog:OnRefreshOldPlayerBenefits(notification)
  local activityId = DataCommon.Activities.OldPlayerBenefits
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowOldPlayerWelfareRedDot()
  self:RefreshTabBtnData(activityId, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {tabId = activityId, show = showRedDot})
  local tabCell = self._tabFrame:GetCellAtIndex(activityId)
  tabCell:RefreshTabCell(true, true)
end

function WelfareMainDialog:OnRefreshMinDiscount(notification)
  if not NekoData.BehaviorManager.BM_Welfare:IsShowMinDiscount() then
    local pageIndex
    for index, value in ipairs(self._tabBtnData) do
      if value.record.id == WelfareMainDialog.WelfareType.minDisCount then
        pageIndex = index
        break
      end
    end
    if pageIndex then
      table.remove(self._tabBtnData, pageIndex)
      self._tabBtnFrame:ReloadAllCell()
      self._tabBtnFrame:MoveToTop()
      self:SelectNextTab()
      return
    end
  end
  local activityId = DataCommon.Activities.MinDiscount
  local showRedDot = NekoData.BehaviorManager.BM_Welfare:ShowMinDiscountRedDot()
  self:RefreshTabBtnData(activityId, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshRedDot", {tabId = activityId, show = showRedDot})
  local tabCell = self._tabFrame:GetCellAtIndex(activityId)
  tabCell:RefreshTabCell(true, true)
end

return WelfareMainDialog
