local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CReturnLoginActivity = BeanManager.GetTableByName("welfare.creturnloginactivity")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local ShowByModalDialogs = {
  "welfare.returnwelfare.roleopstiondialog",
  "mainline.bossrush.checkotherroleinfodialog",
  "welfare.returnwelfare.returnbattlepassunlockdialog"
}
local ReturnWelfareMainDialog = class("ReturnWelfareMainDialog", Dialog)
ReturnWelfareMainDialog.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareMainDialog.AssetName = "ReturnWelfare"
ReturnWelfareMainDialog.PageType = {signActivity = 8001}

function ReturnWelfareMainDialog:Ctor(...)
  ReturnWelfareMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._accumulatedSigned = false
  self._tabBtnData = {}
  self._selectedTab = nil
end

function ReturnWelfareMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._tabBtnPanel = self:GetChild("Group")
  self._frame = self:GetChild("Frame")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tabBtnFrame = TableFrame.Create(self._tabBtnPanel, self, true, true, true)
  self._tabFrame = TabFrame.Create(self._frame, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshSignActivity, Common.n_RefreshSignActivity, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSActivityTasks, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasksUpdate, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReturnWelfareRedDot, Common.n_RefreshReturnWelfareRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshReturnBattlePass, Common.n_RefreshReturnBattlePass, nil)
end

function ReturnWelfareMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._tabBtnFrame:Destroy()
  self._tabFrame:Destroy()
  self._data = {}
  DialogManager.DestroySingletonDialog("welfare.returnwelfare.returnbattlepassunlockdialog")
  DialogManager.DestroySingletonDialog("welfare.returnwelfare.returnbattlepasssecondconfirm")
  DialogManager.DestroySingletonDialog("welfare.returnwelfare.roleopstiondialog")
end

function ReturnWelfareMainDialog:SetJumpTab(tabId)
  self._jumpTab = tabId
end

function ReturnWelfareMainDialog:SetData(openOnInitial)
  self._tabBtnData = {}
  self._openOnInitial = openOnInitial
  local signActivities = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnSignActivities()
  table.sort(signActivities, function(a, b)
    local a_record = CReturnLoginActivity:GetRecorder(a.id)
    local b_record = CReturnLoginActivity:GetRecorder(b.id)
    return a_record.sort < b_record.sort
  end)
  for i, v in ipairs(signActivities) do
    if NekoData.BehaviorManager.BM_Activity:HasActivity(v.id) then
      local showEntrance = false
      local showRedDot = false
      local alwaysShow = CReturnLoginActivity:GetRecorder(v.id).alwaysShow == 1
      for _, award in ipairs(v.awards) do
        if not award.receive then
          showEntrance = true
          if award.index <= v.totalSignNum then
            showRedDot = true
          end
        end
      end
      local record = CReturnLoginActivity:GetRecorder(v.id)
      if (not self._openOnInitial or record.show ~= 0) and (showEntrance or alwaysShow) then
        table.insert(self._tabBtnData, {record = record, showRedDot = showRedDot})
      end
    end
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask) then
    local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask)
    local taskFinishReddot = NekoData.BehaviorManager.BM_ActivityTasks:ReturnWelfareTaskRedDot()
    local taskRewardReddot = NekoData.BehaviorManager.BM_Activity:GetBackTaskRedPoint()
    local showRedDot = taskFinishReddot or taskRewardReddot
    table.insert(self._tabBtnData, {record = record, showRedDot = showRedDot})
    local sendProtocol = LuaNetManager.CreateProtocol("protocol.task.cactivitytasks")
    if sendProtocol then
      sendProtocol.activityID = sendProtocol.BACK_PLAYER
      sendProtocol:Send()
    end
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode) then
    local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode)
    local showRedDot = NekoData.BehaviorManager.BM_Activity:GetBackGiftRedPoint()
    table.insert(self._tabBtnData, {record = record, showRedDot = showRedDot})
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenbackgift")
    if protocol then
      protocol:Send()
    end
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_Activity:IsActivityOpen(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfarePack) then
    local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfarePack)
    table.insert(self._tabBtnData, {record = record, showRedDot = false})
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenbackpack")
    if protocol then
      protocol:Send()
    end
  end
  if not self._openOnInitial and NekoData.BehaviorManager.BM_ReturnWelfare:GetReturnBattlePass() then
    local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass)
    table.insert(self._tabBtnData, {
      record = record,
      showRedDot = NekoData.BehaviorManager.BM_ReturnWelfare:ShowReturnBattlePassRedDot()
    })
  end
  table.sort(self._tabBtnData, function(a, b)
    local a_record = CReturnLoginActivity:GetRecorder(a.record.id)
    local b_record = CReturnLoginActivity:GetRecorder(b.record.id)
    return a_record.sort < b_record.sort
  end)
  self._firstShowPageId = self._tabBtnData[1].record.id
  self._tabBtnFrame:ReloadAllCell()
  self._tabBtnFrame:MoveToTop()
  if not self._jumpTab then
    self:SelectNextTab()
  else
    self:SetSelectedTab(self._jumpTab)
    self._jumpTab = nil
  end
end

function ReturnWelfareMainDialog:SetSelectedTab(tabId, refresh)
  if self._selectedTab ~= tabId then
    self._selectedTab = tabId
    self._tabBtnFrame:FireEvent("SelectedTab")
    local tabCell = self._tabFrame:ToPage(self._selectedTab)
    if tabId >= ReturnWelfareMainDialog.PageType.signActivity then
      tabCell:RefreshTabCell(tabId, refresh)
    else
      tabCell:RefreshTabCell(refresh)
    end
  elseif refresh then
    local tabCell = self._tabFrame:GetCellAtIndex(tabId)
    if tabId >= ReturnWelfareMainDialog.PageType.signActivity then
      tabCell:RefreshTabCell(tabId, refresh)
    else
      tabCell:RefreshTabCell(refresh)
    end
  end
end

function ReturnWelfareMainDialog:CellAtIndex(frame, index)
  if frame == self._tabFrame then
    if index == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask then
      return "welfare.returnwelfare.returnwelfaretasktabcell"
    elseif index == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode then
      return "welfare.returnwelfare.returnwelfareentercdkeytabcell"
    elseif index == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnWelfarePack then
      return "welfare.returnwelfare.returnwelfaregiftbagtabcell"
    elseif index == NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass then
      return "welfare.returnwelfare.returnbattlepasstabcell"
    else
      return "welfare.returnwelfare.returnsigntabcell"
    end
  elseif frame == self._tabBtnFrame then
    return "welfare.returnwelfare.returnwelfaretabbtncell"
  end
end

function ReturnWelfareMainDialog:NumberOfCell(frame, index)
  return #self._tabBtnData
end

function ReturnWelfareMainDialog:DataAtIndex(frame, index)
  return self._tabBtnData[index]
end

function ReturnWelfareMainDialog:OnDialogDestroy(notification)
  if self._next and not DialogManager.GetDialog("bag.itemaccountdialog") and not DialogManager.GetDialog("gacha.gachamoviedialog") then
    self._next = false
  end
end

local function SelectNext(self)
  if DialogManager.GetDialog("bag.itemaccountdialog") or DialogManager.GetDialog("gacha.gachamoviedialog") then
    self._next = true
  end
end

function ReturnWelfareMainDialog:SelectNextTab()
  if not self._open and not NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnActivityState() and self._accumulatedSigned then
    self:Destroy()
  elseif NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnActivityState() then
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
      self:SetSelectedTab(self._firstShowPageId)
      has_need_to_sign = true
    end
    if not has_need_to_sign then
      self:SetSelectedTab(self._tabBtnData[1].record.id)
    end
  end
end

function ReturnWelfareMainDialog:OnRefreshSignActivity(notification)
  local signActivities = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SignManagerID):GetReturnSignActivities()
  table.sort(signActivities, function(a, b)
    local a_record = CReturnLoginActivity:GetRecorder(a.id)
    local b_record = CReturnLoginActivity:GetRecorder(b.id)
    return a_record.sort > b_record.sort
  end)
  self._tabBtnFrame:ReloadAllCell()
  self._tabBtnFrame:MoveToTop()
  for i, v in ipairs(signActivities) do
    if NekoData.BehaviorManager.BM_Activity:HasActivity(v.id) then
      local showRedDot = false
      for _, award in ipairs(v.awards) do
        if not award.receive and award.index <= v.totalSignNum then
          showRedDot = true
        end
      end
      local record = CReturnLoginActivity:GetRecorder(v.id)
      self._tabBtnFrame:FireEvent("RefreshReddot", {record = record, showRedDot = showRedDot})
    end
  end
  local tabId = notification.userInfo
  local tabCell = self._tabFrame:GetCellAtIndex(tabId)
  tabCell:RefreshTabCell(tabId, true, tabId == self._selectedTab)
end

function ReturnWelfareMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function ReturnWelfareMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function ReturnWelfareMainDialog:OnSActivityTasksUpdate()
  local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask)
  local taskFinishReddot = NekoData.BehaviorManager.BM_ActivityTasks:ReturnWelfareTaskRedDot()
  local taskRewardReddot = NekoData.BehaviorManager.BM_Activity:GetBackTaskRedPoint()
  local showRedDot = taskFinishReddot or taskRewardReddot
  self._tabBtnFrame:FireEvent("RefreshReddot", {record = record, showRedDot = showRedDot})
end

function ReturnWelfareMainDialog:OnRefreshReturnWelfareRedDot()
  local record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode)
  local backGiftRewardReddot = NekoData.BehaviorManager.BM_Activity:GetBackGiftRedPoint()
  self._tabBtnFrame:FireEvent("RefreshReddot", {record = record, showRedDot = backGiftRewardReddot})
  self:OnSActivityTasksUpdate()
end

function ReturnWelfareMainDialog:RefreshTabBtnData(id, showRedDot)
  for _, v in ipairs(self._tabBtnData) do
    if v.record.id == id then
      v.showRedDot = showRedDot
      break
    end
  end
end

function ReturnWelfareMainDialog:OnRefreshReturnBattlePass(notification)
  local activityId = notification.userInfo
  if not NekoData.BehaviorManager.BM_ReturnWelfare:GetReturnBattlePass() then
    local index
    for i, v in ipairs(self._tabBtnData) do
      if v.record.id == activityId then
        index = i
        break
      end
    end
    if index then
      table.remove(self._tabBtnData, index)
      self._tabBtnFrame:ReloadAllCell()
      self._tabBtnFrame:MoveToTop()
      if #self._tabBtnData == 0 then
        self:Destroy()
      else
        self:SetSelectedTab(self._tabBtnData[1].record.id)
      end
    end
    return
  end
  local showRedDot = NekoData.BehaviorManager.BM_ReturnWelfare:ShowReturnBattlePassRedDot()
  self:RefreshTabBtnData(activityId, showRedDot)
  self._tabBtnFrame:FireEvent("RefreshReddot", {
    record = CReturnLoginActivity:GetRecorder(NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnBattlePass),
    showRedDot = showRedDot
  })
  local tabCell = self._tabFrame:GetCellAtIndex(activityId)
  tabCell:RefreshTabCell(true, true)
end

function ReturnWelfareMainDialog:AddNewModal(dialog)
  if table.keyof(ShowByModalDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

return ReturnWelfareMainDialog
