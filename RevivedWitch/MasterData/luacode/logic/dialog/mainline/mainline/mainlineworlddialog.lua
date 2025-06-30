-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/mainlineworlddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSpirit = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectstrength")
local TypeInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeontype")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local VarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local GuidTypes = (LuaNetManager.GetBeanDef)("protocol.user.guidtypes")
local TableFrame = require("framework.ui.frame.table.tableframe")
local MainLineWorldDialog = class("MainLineWorldDialog", Dialog)
MainLineWorldDialog.AssetBundleName = "ui/layouts.mainline"
MainLineWorldDialog.AssetName = "MainLineWorld"
local limit = nil
local WhichType = {MainLine = 1, Resource = 2, BattleTest = 3, Activity = 4, Tower = 5, BossRush = 6, BranchLine = 7, WeekBoss = 8}
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(23, 5) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(23)
  end
end

MainLineWorldDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : MainLineWorldDialog, WhichType
  ((MainLineWorldDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._spirit = nil
  self._data = {}
  self._preWhich = nil
  self._which = WhichType.MainLine
  self._baseSceneController = nil
  self._lastWhich = self._which
  self._itemTipsJump = nil
end

MainLineWorldDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : limit, _ENV, WhichType, FinishGuide
  limit = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
  self._vitNum = self:GetChild("TopGroup/VIT/Text")
  self._addVIT = self:GetChild("TopGroup/VIT/Add")
  self._typeBtn = {self:GetChild("MainLineGroupBtn"), self:GetChild("ResourceGroupBtn"), self:GetChild("BattleTextBtn"), self:GetChild("BossRushBtn"), false, false, self:GetChild("SideStoryBtn")}
  ;
  ((self._typeBtn)[WhichType.BattleTest]):SetActive(((NekoData.BehaviorManager).BM_Game):IsGM())
  self._field = self:GetChild("WorldPanel")
  self._typeGuide = self:GetChild("ResourceGroupBtn/Guide")
  self._resource_manaTips = self:GetChild("ResourceGroupBtn/Tips")
  self._resource_redDot = self:GetChild("ResourceGroupBtn/RedDot")
  self._mainLineRedDot = self:GetChild("MainLineGroupBtn/RedDot")
  self._BossRushRedDot = self:GetChild("BossRushBtn/RedDot")
  self._tips = self:GetChild("BossRushBtn/Tips")
  ;
  (self._tips):SetActive(((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen())
  ;
  ((self._typeBtn)[WhichType.Resource]):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource))
  ;
  ((self._typeBtn)[WhichType.Activity]):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Activity))
  ;
  ((self._typeBtn)[WhichType.BranchLine]):SetActive(((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BranchLine))
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(3)
  ;
  ((self._typeBtn)[WhichType.MainLine]):Subscribe_PointerClickEvent(self.OnTypeOneBtnClicked, self)
  ;
  ((self._typeBtn)[WhichType.Resource]):Subscribe_PointerClickEvent(self.OnTypeTwoBtnClicked, self)
  ;
  ((self._typeBtn)[WhichType.BattleTest]):Subscribe_PointerClickEvent(self.OnTypeThreeBtnClicked, self)
  ;
  ((self._typeBtn)[WhichType.Activity]):Subscribe_PointerClickEvent(self.OnTypeFourBtnClicked, self)
  ;
  ((self._typeBtn)[WhichType.BranchLine]):Subscribe_PointerClickEvent(self.OnTypeFiveBtnClicked, self)
  ;
  (self._resource_manaTips):Subscribe_PointerClickEvent(self.OnManaTipsClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self:OnTypeOneBtnClicked()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShowDungeonList, Common.n_ReceiveDungeonList, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBossRushInfo, Common.n_ReceiveBossRushInfo, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShowBranchLineDungeonList, Common.n_ReceiveBranchLineData)
  self._spirit = ((NekoData.BehaviorManager).BM_Currency):GetSpirit()
  ;
  (self._vitNum):SetText(tostring(self._spirit) .. "/" .. tostring(limit))
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copendungeonlist")
  csend:Send()
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cresourcepanel")
  csend:Send()
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenbosspanel")
  csend:Send()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpirit, Common.n_RefreshSpirit, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceiveDungeonWorldAward, Common.n_ReceiveDungeonWorldAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_RefreshBossPanelRed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_RefreshFragmentPanelRed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSResourcePanel, Common.n_ReceiveResourcePanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLocalTipsChecked, Common.n_LocalTipsStateChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshMidAutumnLeftTime, Common.n_RefreshMidAutumnLeftTime, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshUndecidedRoadTip, Common.n_RefreshUndecidedRoadState, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_RefreshUndecidedRoadRedDot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_SReceiveWeekAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_SWeekBossRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_WeekBossTaskRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_SOpenWeekBossPanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_WeekBossChallengeRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshBossRushRed, Common.n_SeasonPvpAward, nil)
  self:OnBossRushInfo()
  self:OnRefreshBossRushRed()
  self:ItemTipsJump(((NekoData.BehaviorManager).BM_Game):GetFastMenuInfoFromCourtyard())
  ;
  ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard(nil, nil)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOfflineSweepActive, Common.n_RefreshOfflineSweepActive, nil)
  self:RefreshOfflineSweepActive()
end

MainLineWorldDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (UIBackManager.SetUIBackShow)(false)
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
  if self._jieSuoType2BtnTask then
    (GameTimer.RemoveTask)(self._jieSuoType2BtnTask)
    self._jieSuoType2BtnTask = nil
  end
  if self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
end

MainLineWorldDialog.Init = function(self, baseSceneController)
  -- function num : 0_4
  self._baseSceneController = baseSceneController
end

MainLineWorldDialog.RefreshOfflineSweepActive = function(self)
  -- function num : 0_5 , upvalues : _ENV, WhichType
  local status = ((NekoData.BehaviorManager).BM_OfflineSweep):GetStatus()
  if status ~= 0 then
    if self._offlinesweepDialog == nil then
      self._offlinesweepDialog = (DialogManager.CreateDialog)("mainline.offlinesweep.offlinesweepshowbtndialog", (self._rootWindow)._uiObject)
    end
    ;
    (self._offlinesweepDialog):SetActive(self._which == WhichType.Resource)
  elseif self._offlinesweepDialog then
    (self._offlinesweepDialog):Destroy()
    self._offlinesweepDialog = nil
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

MainLineWorldDialog.SetTaskJump = function(self)
  -- function num : 0_6
  self._fromTaskJump = true
end

MainLineWorldDialog.OnShowDungeonList = function(self)
  -- function num : 0_7 , upvalues : _ENV, WhichType, TableFrame
  if ((NekoData.BehaviorManager).BM_Game):GetIfAllDungeonWorldAndZoneAwardReceive() then
    (self._mainLineRedDot):SetActive(false)
  else
    ;
    (self._mainLineRedDot):SetActive(true)
  end
  if self._which == WhichType.MainLine then
    self._data = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
    if self._which ~= self._preWhich then
      if self._frame then
        (self._frame):Destroy()
      end
      self._frame = (TableFrame.Create)(self._field, self, false, false)
    end
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):FireEvent("MoveToCurrentWordIndex")
  end
  if self._itemTipsJump then
    local data = clone(self._itemTipsJump)
    self._itemTipsJump = nil
    self:OnItemTipsJump(data)
  end
end

MainLineWorldDialog.ToTowerDialog = function(self, protocol)
  -- function num : 0_8 , upvalues : WhichType, TableFrame
  self._preWhich = self._which
  if self._which == WhichType.Tower then
    self._data = protocol
    ;
    (self._frame):ReloadAllCell()
  else
    self._which = WhichType.Tower
    self._data = protocol
    if self._which ~= self._preWhich then
      if self._frame then
        (self._frame):Destroy()
      end
      self._frame = (TableFrame.Create)(self._field, self, false, false)
    end
    ;
    (self._frame):ReloadAllCell()
  end
end

MainLineWorldDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return 1
end

MainLineWorldDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10 , upvalues : WhichType
  if self._which == WhichType.MainLine then
    return "mainline.mainline.newmainlinedialogcell"
  else
    if self._which == WhichType.Resource then
      return "mainline.resource.newresourcedialogcell"
    else
      if self._which == WhichType.Activity then
        return "mainline.activity.activitymaindialog"
      else
        if self._which == WhichType.Tower then
          return "tower.towermaindialog"
        else
          if self._which == WhichType.BossRush then
            return "mainline.bossrush.bossrushpaneldialog"
          else
            if self._which == WhichType.BranchLine then
              return "mainline.branchline.branchlinedialog"
            else
              if self._which == WhichType.WeekBoss then
                return "mainline.bossrush.bossrushweekmaindialog"
              end
            end
          end
        end
      end
    end
  end
end

MainLineWorldDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return self._data
end

MainLineWorldDialog.SetSelected = function(self, index)
  -- function num : 0_12 , upvalues : _ENV
  for i,v in ipairs(self._typeBtn) do
    if i ~= index then
      do
        v:SetSelected(not v)
        -- DECOMPILER ERROR at PC12: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC12: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MainLineWorldDialog.OnTypeOneBtnClicked = function(self, arg)
  -- function num : 0_13 , upvalues : WhichType
  if arg then
    self._preWhich = self._which
  end
  self._which = WhichType.MainLine
  self:OnShowDungeonList()
  if not self._preWhich then
    self._preWhich = self._which
  end
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnTypeTwoBtnClicked = function(self)
  -- function num : 0_14 , upvalues : WhichType
  self._preWhich = self._which
  self._which = WhichType.Resource
  self:OnSResourcePanel()
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnSResourcePanel = function(self)
  -- function num : 0_15 , upvalues : _ENV, WhichType, TableFrame
  (self._resource_manaTips):SetActive(((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).Resource_Mana))
  ;
  (self._resource_redDot):SetActive(((NekoData.BehaviorManager).BM_Game):IsResourceRedDotShow())
  if self._which == WhichType.Resource then
    self._data = ((NekoData.BehaviorManager).BM_Game):GetResourcePanelList()
    if self._which ~= self._preWhich then
      if self._frame then
        (self._frame):Destroy()
      end
      self._frame = (TableFrame.Create)(self._field, self, true, false)
    end
    ;
    (self._frame):ReloadAllCell()
  end
  if self._itemTipsJump then
    local data = clone(self._itemTipsJump)
    self._itemTipsJump = nil
    self:OnItemTipsJump(data)
  end
end

MainLineWorldDialog.OnTypeThreeBtnClicked = function(self)
  -- function num : 0_16 , upvalues : WhichType, _ENV
  self._lastWhich = self._which
  self._preWhich = self._which
  self._which = WhichType.BattleTest
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    ;
    (DialogManager.CreateSingletonDialog)("mainline.battletextsecondconfirmdialog")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnTypeThreeBtnCancelClicked = function(self)
  -- function num : 0_17 , upvalues : WhichType
  self._preWhich = self._which
  self._which = self._lastWhich
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnTypeFourBtnClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV, WhichType
  ((NekoData.DataManager).DM_Team):ClearSupportRole()
  self._lastWhich = self._which
  self._preWhich = self._which
  self._which = WhichType.Activity
  self:OnActivityInfo()
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnTypeFiveBtnClicked = function(self)
  -- function num : 0_19 , upvalues : WhichType
  self._preWhich = self._which
  self._which = WhichType.BranchLine
  self:OnShowBranchLineDungeonList()
  self:SetSelected(self._which)
  if self._which ~= WhichType.Resource then
    (self._offlinesweepDialog):SetActive(not self._offlinesweepDialog)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

MainLineWorldDialog.OnManaTipsClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV, ResourceStageTable
  local stageId = ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).Resource_Mana)
  self:OnItemTipsJump({gainType = (DataCommon.GainTypeEnum).Resource, worldId = 1, info = ResourceStageTable:GetRecorder(stageId)})
end

MainLineWorldDialog.OnLocalTipsChecked = function(self, notification)
  -- function num : 0_21 , upvalues : _ENV
  if ((notification.userInfo).type).Tag == ((DataCommon.LocalTips).Resource_Mana).Tag and (notification.userInfo).sign == "Checked" then
    (self._resource_manaTips):SetActive(false)
  end
  ;
  (self._resource_redDot):SetActive(((NekoData.BehaviorManager).BM_Game):IsResourceRedDotShow())
end

MainLineWorldDialog.OnRefreshMidAutumnLeftTime = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Activity):GetMidAutumnLeftTime() <= 0 then
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.cresourcepanel")
    csend:Send()
  end
end

MainLineWorldDialog.OpenBossRushPanel = function(self)
  -- function num : 0_23 , upvalues : WhichType
  self._preWhich = self._which
  self._which = WhichType.BossRush
  self._initBossRushPanel = false
  self:OnBossRushInfo()
end

MainLineWorldDialog.OnShowBranchLineDungeonList = function(self)
  -- function num : 0_24 , upvalues : WhichType, _ENV, TableFrame
  if self._which == WhichType.BranchLine then
    self._data = ((NekoData.BehaviorManager).BM_Game):GetBranchLineList()
    if self._data then
      if self._which ~= self._preWhich then
        if self._frame then
          (self._frame):Destroy()
        end
        self._frame = (TableFrame.Create)(self._field, self, false, false)
      end
      ;
      (self._frame):ReloadAllCell()
    else
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copensidequestpanel")
      csend:Send()
    end
  end
end

MainLineWorldDialog.OnBossRushInfo = function(self)
  -- function num : 0_25 , upvalues : WhichType, _ENV, TableFrame
  if self._which == WhichType.BossRush then
    self._data = ((NekoData.BehaviorManager).BM_Game):GetBossRushInfo()
    if not self._initBossRushPanel and self._which ~= self._preWhich then
      self._initBossRushPanel = true
      if self._frame then
        (self._frame):Destroy()
      end
      self._frame = (TableFrame.Create)(self._field, self, true, false)
    end
    ;
    (self._frame):ReloadAllCell()
  end
end

MainLineWorldDialog.OpenWeekBossDialog = function(self)
  -- function num : 0_26 , upvalues : WhichType, TableFrame
  self._preWhich = self._which
  self._which = WhichType.WeekBoss
  if self._which == WhichType.WeekBoss then
    if self._which ~= self._preWhich then
      if self._frame then
        (self._frame):Destroy()
      end
      self._frame = (TableFrame.Create)(self._field, self, true, false)
    end
    ;
    (self._frame):ReloadAllCell()
  end
end

MainLineWorldDialog.OnActivityInfo = function(self)
  -- function num : 0_27 , upvalues : WhichType, _ENV, TableFrame
  if self._which == WhichType.Activity then
    self._data = {}
    local tempData = {}
    local hasWeekBoss = false
    local Activit = {BossRush = 2, WeekBoss = 6}
    for _,v in ipairs(((NekoData.BehaviorManager).BM_Game):GetActivityInfo()) do
      if not tempData[v.sort] then
        do
          tempData[v.sort] = {}
          if v.id == Activit.WeekBoss and ((NekoData.BehaviorManager).BM_WeekBoss):IsUnlock() then
            (table.insert)(tempData[v.sort], v)
            hasWeekBoss = true
          end
          ;
          (table.insert)(tempData[v.sort], v)
          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    do
      if hasWeekBoss then
        local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenweekbosspanel")
        csend:Send()
      end
      for s,v in pairs(tempData) do
        (table.sort)(v, function(a, b)
    -- function num : 0_27_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        ;
        (table.insert)(self._data, {sort = s, data = v})
      end
      ;
      (table.sort)(self._data, function(a, b)
    -- function num : 0_27_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      if self._which ~= self._preWhich then
        if self._frame then
          (self._frame):Destroy()
        end
        self._frame = (TableFrame.Create)(self._field, self, true, false)
      end
      ;
      (self._frame):ReloadAllCell()
    end
  end
end

MainLineWorldDialog.RefreshSpirit = function(self, notification)
  -- function num : 0_28 , upvalues : _ENV, limit
  self._spirit = (notification.userInfo).spirit
  ;
  (self._vitNum):SetText(tostring(self._spirit) .. "/" .. tostring(limit))
end

MainLineWorldDialog.OnBackBtnClicked = function(self)
  -- function num : 0_29 , upvalues : WhichType
  if self._which == WhichType.Tower or self._which == WhichType.BossRush or self._which == WhichType.WeekBoss then
    self:OnTypeFourBtnClicked()
    return 
  end
  self:Destroy()
end

MainLineWorldDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_30 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

MainLineWorldDialog.OnWorldIClicked = function(self, i, isWorldId, fromItemTipsJump)
  -- function num : 0_31 , upvalues : _ENV
  local index = i
  if isWorldId then
    for indexI,data in ipairs(self._data) do
      if data.worldId == i then
        index = indexI
        break
      end
    end
  end
  do
    local logicCell = (self._frame):GetLogicCell(1)
    if not logicCell._cell then
      (self._frame):GetCellDialog(logicCell)
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (logicCell._cell)._delegate = self
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (logicCell._cell)._cellData = logicCell._data
      ;
      (logicCell._cell):RefreshCell(logicCell._data)
    end
    ;
    ((logicCell._cell):GetRootWindow()):SetPosition(0, logicCell._pos, 0, 0)
    ;
    (logicCell._cell):OnWorldIClicked(index, fromItemTipsJump)
  end
end

MainLineWorldDialog.ItemTipsJump = function(self, run)
  -- function num : 0_32 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Guide):HasCurrentStrongGuide() and run then
    self._itemTipsJump = run
  end
end

MainLineWorldDialog.OnItemTipsJump = function(self, run)
  -- function num : 0_33 , upvalues : _ENV, TypeInfoTable
  if run.gainType then
    if run.gainType == (DataCommon.GainTypeEnum).MainLine then
      self:OnTypeOneBtnClicked()
      self:OnWorldIClicked(run.worldId, true)
      local mainLineFloorDialog = (DialogManager.GetDialog)("mainline.mainline.newmainlinefloordialog")
      if mainLineFloorDialog then
        mainLineFloorDialog:OnCellClicked((run.info).id)
      end
    else
      do
        if run.gainType == (DataCommon.GainTypeEnum).MainLine_NotSelect then
          self:OnTypeOneBtnClicked()
          self:OnWorldIClicked(run.worldId, true)
        else
          if run.gainType == (DataCommon.GainTypeEnum).ResourceMain then
            self:OnTypeTwoBtnClicked()
          else
            if run.gainType == (DataCommon.GainTypeEnum).Resource then
              self:OnTypeTwoBtnClicked()
              if run.worldId then
                local index = nil
                for indexI,data in ipairs(self._data) do
                  if data.id == run.worldId then
                    index = indexI
                    break
                  end
                end
                do
                  self:OnWorldIClicked(index, false, true)
                  local flag = (TypeInfoTable:GetRecorder(run.worldId)).showsmalltype == 0
                  if flag then
                    local dialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
                    if dialog then
                      dialog:OnCellClicked((run.info).id, true)
                    end
                  else
                    dialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
                    if dialog then
                      local littleTypeIndex = nil
                      for i,v in ipairs((dialog._data).detailInfo) do
                        for index,stageInfo in ipairs(v.stageList) do
                          if stageInfo.id == (run.info).id then
                            littleTypeIndex = i
                            break
                          end
                        end
                      end
                      dialog:OnLittleTypeBtnClicked(littleTypeIndex)
                      dialog:OnCellClicked((run.info).id, true)
                    end
                  end
                  if run.gainType == (DataCommon.GainTypeEnum).Resource_NotSelect then
                    self:OnTypeTwoBtnClicked()
                    if run.worldId then
                      local index = nil
                      for indexI,data in ipairs(self._data) do
                        if data.id == run.worldId then
                          index = indexI
                          break
                        end
                      end
                      self:OnWorldIClicked(index, false, false)
                      local flag = (TypeInfoTable:GetRecorder(run.worldId)).showsmalltype == 0
                      if not flag then
                        dialog = (DialogManager.GetDialog)("mainline.resource.resourcefloordialog")
                        if dialog then
                          dialog:OnLittleTypeBtnClicked((run.info).sortID)
                        end
                      end
                    end
                  elseif run.gainType == (DataCommon.GainTypeEnum).Tower then
                    self:OnTypeFourBtnClicked()
                    self:OnWorldIClicked(3)
                  elseif run.gainType == (DataCommon.GainTypeEnum).Fragment then
                    self:OnTypeFourBtnClicked()
                    self:OnWorldIClicked(1)
                  elseif run.gainType == (DataCommon.GainTypeEnum).UndecidedRoad then
                    self:OnTypeFourBtnClicked()
                    self:OnWorldIClicked(5)
                  elseif run.gainType == (DataCommon.GainTypeEnum).WeekBoss then
                    self:OnTypeFourBtnClicked()
                    self:OnWorldIClicked(6)
                  end
                  -- DECOMPILER ERROR: 13 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

MainLineWorldDialog.OnReceiveDungeonPointAward = function(self, notification)
  -- function num : 0_34 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):GetIfAllDungeonWorldAndZoneAwardReceive() then
    (self._mainLineRedDot):SetActive(false)
  else
    ;
    (self._mainLineRedDot):SetActive(true)
  end
  ;
  (self._frame):FireEvent("RefreshRedDot")
end

MainLineWorldDialog.OnReceiveDungeonWorldAward = function(self, notification)
  -- function num : 0_35 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):GetIfAllDungeonWorldAndZoneAwardReceive() then
    (self._mainLineRedDot):SetActive(false)
  else
    ;
    (self._mainLineRedDot):SetActive(true)
  end
  ;
  (self._frame):FireEvent("RefreshRedDot")
end

MainLineWorldDialog.OnRefreshBossRushRed = function(self, notification)
  -- function num : 0_36 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsBossPanelShowRed() or ((NekoData.BehaviorManager).BM_Game):IsFragmentPanelShowRed() or ((NekoData.BehaviorManager).BM_Game):IsUndecidedRoadShowRed() or ((NekoData.BehaviorManager).BM_WeekBoss):IfShowRedDotInMainlinePanel() then
    (self._BossRushRedDot):SetActive(true)
  else
    if ((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify() and (((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify()).award and (((NekoData.BehaviorManager).BM_Battle):GetSeasonNotify()).award > 0 then
      (self._BossRushRedDot):SetActive(true)
    else
      ;
      (self._BossRushRedDot):SetActive(false)
    end
  end
end

MainLineWorldDialog.RefreshUndecidedRoadTip = function(self)
  -- function num : 0_37 , upvalues : _ENV
  (self._tips):SetActive(((NekoData.BehaviorManager).BM_UndecidedRoad):GetSeasonIsOpen())
end

return MainLineWorldDialog

