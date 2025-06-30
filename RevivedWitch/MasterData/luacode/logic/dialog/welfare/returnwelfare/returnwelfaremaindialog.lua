-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnwelfaremaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CReturnLoginActivity = (BeanManager.GetTableByName)("welfare.creturnloginactivity")
local TaskStatus = (LuaNetManager.CreateBean)("protocol.task.taskstatus")
local ShowByModalDialogs = {"welfare.returnwelfare.roleopstiondialog", "mainline.bossrush.checkotherroleinfodialog", "welfare.returnwelfare.returnbattlepassunlockdialog"}
local ReturnWelfareMainDialog = class("ReturnWelfareMainDialog", Dialog)
ReturnWelfareMainDialog.AssetBundleName = "ui/layouts.welfare"
ReturnWelfareMainDialog.AssetName = "ReturnWelfare"
ReturnWelfareMainDialog.PageType = {signActivity = 8001}
ReturnWelfareMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnWelfareMainDialog
  ((ReturnWelfareMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._accumulatedSigned = false
  self._tabBtnData = {}
  self._selectedTab = nil
end

ReturnWelfareMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, TabFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._tabBtnPanel = self:GetChild("Group")
  self._frame = self:GetChild("Frame")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tabBtnFrame = (TableFrame.Create)(self._tabBtnPanel, self, true, true, true)
  self._tabFrame = (TabFrame.Create)(self._frame, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshSignActivity, Common.n_RefreshSignActivity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_SingletonDialogDestroy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasksUpdate, Common.n_OnSActivityTasks, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasksUpdate, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshReturnWelfareRedDot, Common.n_RefreshReturnWelfareRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshReturnBattlePass, Common.n_RefreshReturnBattlePass, nil)
end

ReturnWelfareMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._tabBtnFrame):Destroy()
  ;
  (self._tabFrame):Destroy()
  self._data = {}
  ;
  (DialogManager.DestroySingletonDialog)("welfare.returnwelfare.returnbattlepassunlockdialog")
  ;
  (DialogManager.DestroySingletonDialog)("welfare.returnwelfare.returnbattlepasssecondconfirm")
  ;
  (DialogManager.DestroySingletonDialog)("welfare.returnwelfare.roleopstiondialog")
end

ReturnWelfareMainDialog.SetJumpTab = function(self, tabId)
  -- function num : 0_3
  self._jumpTab = tabId
end

ReturnWelfareMainDialog.SetData = function(self, openOnInitial)
  -- function num : 0_4 , upvalues : _ENV, CReturnLoginActivity
  self._tabBtnData = {}
  self._openOnInitial = openOnInitial
  local signActivities = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnSignActivities()
  ;
  (table.sort)(signActivities, function(a, b)
    -- function num : 0_4_0 , upvalues : CReturnLoginActivity
    local a_record = CReturnLoginActivity:GetRecorder(a.id)
    local b_record = CReturnLoginActivity:GetRecorder(b.id)
    do return a_record.sort < b_record.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(signActivities) do
    if ((NekoData.BehaviorManager).BM_Activity):HasActivity(v.id) then
      local showEntrance = false
      local showRedDot = false
      local alwaysShow = (CReturnLoginActivity:GetRecorder(v.id)).alwaysShow == 1
      for _,award in ipairs(v.awards) do
        if not award.receive then
          showEntrance = true
          if award.index <= v.totalSignNum then
            showRedDot = true
          end
        end
      end
      local record = CReturnLoginActivity:GetRecorder(v.id)
      if (not self._openOnInitial or record.show ~= 0) and (showEntrance or alwaysShow) then
        (table.insert)(self._tabBtnData, {record = record, showRedDot = showRedDot})
      end
    end
  end
  if not self._openOnInitial and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask) then
    local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask)
    local taskFinishReddot = ((NekoData.BehaviorManager).BM_ActivityTasks):ReturnWelfareTaskRedDot()
    local taskRewardReddot = ((NekoData.BehaviorManager).BM_Activity):GetBackTaskRedPoint()
    local showRedDot = taskFinishReddot or taskRewardReddot
    ;
    (table.insert)(self._tabBtnData, {record = record, showRedDot = showRedDot})
    local sendProtocol = (LuaNetManager.CreateProtocol)("protocol.task.cactivitytasks")
    if sendProtocol then
      sendProtocol.activityID = sendProtocol.BACK_PLAYER
      sendProtocol:Send()
    end
  end
  if not self._openOnInitial and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode) then
    local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode)
    local showRedDot = ((NekoData.BehaviorManager).BM_Activity):GetBackGiftRedPoint()
    ;
    (table.insert)(self._tabBtnData, {record = record, showRedDot = showRedDot})
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenbackgift")
    if protocol then
      protocol:Send()
    end
  end
  if not self._openOnInitial and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfarePack) then
    local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfarePack)
    ;
    (table.insert)(self._tabBtnData, {record = record, showRedDot = false})
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenbackpack")
    if protocol then
      protocol:Send()
    end
  end
  do
    if not self._openOnInitial and ((NekoData.BehaviorManager).BM_ReturnWelfare):GetReturnBattlePass() then
      local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass)
      ;
      (table.insert)(self._tabBtnData, {record = record, showRedDot = ((NekoData.BehaviorManager).BM_ReturnWelfare):ShowReturnBattlePassRedDot()})
    end
    ;
    (table.sort)(self._tabBtnData, function(a, b)
    -- function num : 0_4_1 , upvalues : CReturnLoginActivity
    local a_record = CReturnLoginActivity:GetRecorder((a.record).id)
    local b_record = CReturnLoginActivity:GetRecorder((b.record).id)
    do return a_record.sort < b_record.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self._firstShowPageId = (((self._tabBtnData)[1]).record).id
    ;
    (self._tabBtnFrame):ReloadAllCell()
    ;
    (self._tabBtnFrame):MoveToTop()
    if not self._jumpTab then
      self:SelectNextTab()
    else
      self:SetSelectedTab(self._jumpTab)
      self._jumpTab = nil
    end
    -- DECOMPILER ERROR: 12 unprocessed JMP targets
  end
end

ReturnWelfareMainDialog.SetSelectedTab = function(self, tabId, refresh)
  -- function num : 0_5 , upvalues : ReturnWelfareMainDialog
  if self._selectedTab ~= tabId then
    self._selectedTab = tabId
    ;
    (self._tabBtnFrame):FireEvent("SelectedTab")
    local tabCell = (self._tabFrame):ToPage(self._selectedTab)
    if (ReturnWelfareMainDialog.PageType).signActivity <= tabId then
      tabCell:RefreshTabCell(tabId, refresh)
    else
      tabCell:RefreshTabCell(refresh)
    end
  else
    do
      if refresh then
        local tabCell = (self._tabFrame):GetCellAtIndex(tabId)
        if (ReturnWelfareMainDialog.PageType).signActivity <= tabId then
          tabCell:RefreshTabCell(tabId, refresh)
        else
          tabCell:RefreshTabCell(refresh)
        end
      end
    end
  end
end

ReturnWelfareMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : _ENV
  if frame == self._tabFrame then
    if index == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask then
      return "welfare.returnwelfare.returnwelfaretasktabcell"
    else
      if index == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode then
        return "welfare.returnwelfare.returnwelfareentercdkeytabcell"
      else
        if index == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnWelfarePack then
          return "welfare.returnwelfare.returnwelfaregiftbagtabcell"
        else
          if index == (((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass then
            return "welfare.returnwelfare.returnbattlepasstabcell"
          else
            return "welfare.returnwelfare.returnsigntabcell"
          end
        end
      end
    end
  else
    if frame == self._tabBtnFrame then
      return "welfare.returnwelfare.returnwelfaretabbtncell"
    end
  end
end

ReturnWelfareMainDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  return #self._tabBtnData
end

ReturnWelfareMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._tabBtnData)[index]
end

ReturnWelfareMainDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  if self._next and not (DialogManager.GetDialog)("bag.itemaccountdialog") and not (DialogManager.GetDialog)("gacha.gachamoviedialog") then
    self._next = false
  end
end

local SelectNext = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemaccountdialog") or (DialogManager.GetDialog)("gacha.gachamoviedialog") then
    self._next = true
  end
end

ReturnWelfareMainDialog.SelectNextTab = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self._open and not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnActivityState() and self._accumulatedSigned then
    self:Destroy()
  else
    if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnActivityState() then
      local actId = nil
      for i,v in ipairs(self._tabBtnData) do
        if v.showRedDot then
          actId = (v.record).id
          break
        end
      end
      do
        do
          self:SetSelectedTab(actId, true)
          local has_need_to_sign = false
          if not self._accumulatedSigned and not has_need_to_sign then
            self:SetSelectedTab(self._firstShowPageId)
            has_need_to_sign = true
          end
          if not has_need_to_sign then
            self:SetSelectedTab((((self._tabBtnData)[1]).record).id)
          end
        end
      end
    end
  end
end

ReturnWelfareMainDialog.OnRefreshSignActivity = function(self, notification)
  -- function num : 0_12 , upvalues : _ENV, CReturnLoginActivity
  local signActivities = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SignManagerID)):GetReturnSignActivities()
  ;
  (table.sort)(signActivities, function(a, b)
    -- function num : 0_12_0 , upvalues : CReturnLoginActivity
    local a_record = CReturnLoginActivity:GetRecorder(a.id)
    local b_record = CReturnLoginActivity:GetRecorder(b.id)
    do return b_record.sort < a_record.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._tabBtnFrame):ReloadAllCell()
  ;
  (self._tabBtnFrame):MoveToTop()
  for i,v in ipairs(signActivities) do
    if ((NekoData.BehaviorManager).BM_Activity):HasActivity(v.id) then
      local showRedDot = false
      for _,award in ipairs(v.awards) do
        if not award.receive and award.index <= v.totalSignNum then
          showRedDot = true
        end
      end
      local record = CReturnLoginActivity:GetRecorder(v.id)
      ;
      (self._tabBtnFrame):FireEvent("RefreshReddot", {record = record, showRedDot = showRedDot})
    end
  end
  local tabId = notification.userInfo
  local tabCell = (self._tabFrame):GetCellAtIndex(tabId)
  tabCell:RefreshTabCell(tabId, true, tabId == self._selectedTab)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ReturnWelfareMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  self:Destroy()
end

ReturnWelfareMainDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

ReturnWelfareMainDialog.OnSActivityTasksUpdate = function(self)
  -- function num : 0_15 , upvalues : CReturnLoginActivity, _ENV
  local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask)
  local taskFinishReddot = ((NekoData.BehaviorManager).BM_ActivityTasks):ReturnWelfareTaskRedDot()
  local taskRewardReddot = ((NekoData.BehaviorManager).BM_Activity):GetBackTaskRedPoint()
  local showRedDot = taskFinishReddot or taskRewardReddot
  ;
  (self._tabBtnFrame):FireEvent("RefreshReddot", {record = record, showRedDot = showRedDot})
end

ReturnWelfareMainDialog.OnRefreshReturnWelfareRedDot = function(self)
  -- function num : 0_16 , upvalues : CReturnLoginActivity, _ENV
  local record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode)
  local backGiftRewardReddot = ((NekoData.BehaviorManager).BM_Activity):GetBackGiftRedPoint()
  ;
  (self._tabBtnFrame):FireEvent("RefreshReddot", {record = record, showRedDot = backGiftRewardReddot})
  self:OnSActivityTasksUpdate()
end

ReturnWelfareMainDialog.RefreshTabBtnData = function(self, id, showRedDot)
  -- function num : 0_17 , upvalues : _ENV
  for _,v in ipairs(self._tabBtnData) do
    if (v.record).id == id then
      v.showRedDot = showRedDot
      break
    end
  end
end

ReturnWelfareMainDialog.OnRefreshReturnBattlePass = function(self, notification)
  -- function num : 0_18 , upvalues : _ENV, CReturnLoginActivity
  local activityId = notification.userInfo
  if not ((NekoData.BehaviorManager).BM_ReturnWelfare):GetReturnBattlePass() then
    local index = nil
    for i,v in ipairs(self._tabBtnData) do
      if (v.record).id == activityId then
        index = i
        break
      end
    end
    do
      do
        if index then
          (table.remove)(self._tabBtnData, index)
          ;
          (self._tabBtnFrame):ReloadAllCell()
          ;
          (self._tabBtnFrame):MoveToTop()
          if #self._tabBtnData == 0 then
            self:Destroy()
          else
            self:SetSelectedTab((((self._tabBtnData)[1]).record).id)
          end
        end
        do return  end
        local showRedDot = ((NekoData.BehaviorManager).BM_ReturnWelfare):ShowReturnBattlePassRedDot()
        self:RefreshTabBtnData(activityId, showRedDot)
        ;
        (self._tabBtnFrame):FireEvent("RefreshReddot", {record = CReturnLoginActivity:GetRecorder((((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnBattlePass), showRedDot = showRedDot})
        local tabCell = (self._tabFrame):GetCellAtIndex(activityId)
        tabCell:RefreshTabCell(true, true)
      end
    end
  end
end

ReturnWelfareMainDialog.AddNewModal = function(self, dialog)
  -- function num : 0_19 , upvalues : _ENV, ShowByModalDialogs
  if (table.keyof)(ShowByModalDialogs, dialog._dialogName) then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

return ReturnWelfareMainDialog

