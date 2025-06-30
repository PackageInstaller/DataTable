-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_activity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CTimedActivitySwitch = (BeanManager.GetTableByName)("activity.ctimedactivityswitch")
local CSfblessingChat = (BeanManager.GetTableByName)("activity.csfblessingchat")
local CActivityMidAutumnRe = (BeanManager.GetTableByName)("activity.cactivitymidautumnre")
local CBannerAndEntrance = (BeanManager.GetTableByName)("activity.cbannerandentrance")
local CPopUpGift = (BeanManager.GetTableByName)("topup.cpopupgift")
local C7DaySPopUpGift = (BeanManager.GetTableByName)("topup.c7dayspopupgift")
local StarMirageUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).StarMirage)
local SwimSuitUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).SwimSuit)
local ChristmasUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).Christmas)
local LoverUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).Lover)
local SpringFestivalUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).SpringFestival)
local SActivityDailySupply = (LuaNetManager.GetProtocolDef)("protocol.activity.sactivitydailysupply")
local CommonAwardStatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local WelfareType = (require("logic.dialog.welfare.welfaremaindialog")).WelfareType
local BM_Activity = class("BM_Activity")
BM_Activity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._activities = (NekoData.Data).activities
  self._managers = {[1] = ((require("logic.manager.experimental.behaviormanager.activity.bm_spiritdiscount")).Create)(), [2] = ((require("logic.manager.experimental.behaviormanager.activity.bm_agcoin")).Create)(), [3] = ((require("logic.manager.experimental.behaviormanager.activity.bm_sign")).Create)(), [4] = ((require("logic.manager.experimental.behaviormanager.activity.bm_starmirage")).Create)(), [5] = ((require("logic.manager.experimental.behaviormanager.activity.bm_puzzle")).Create)(), [6] = ((require("logic.manager.experimental.behaviormanager.activity.bm_summeractivity")).Create)(), [8] = ((require("logic.manager.experimental.behaviormanager.activity.bm_halloween")).Create)(), [9] = ((require("logic.manager.experimental.behaviormanager.activity.bm_doubleeleven")).Create)(), [10] = ((require("logic.manager.experimental.behaviormanager.activity.bm_christmas")).Create)(), [11] = ((require("logic.manager.experimental.behaviormanager.activity.bm_birthday")).Create)(), [12] = ((require("logic.manager.experimental.behaviormanager.activity.bm_christmascall")).Create)(), [13] = ((require("logic.manager.experimental.behaviormanager.activity.bm_springfestival")).Create)(), [14] = ((require("logic.manager.experimental.behaviormanager.activity.bm_lover")).Create)(), [15] = ((require("logic.manager.experimental.behaviormanager.activity.bm_aprilfoolsday")).Create)(), [16] = ((require("logic.manager.experimental.behaviormanager.activity.bm_children")).Create)(), [17] = ((require("logic.manager.experimental.behaviormanager.activity.bm_dragonboatfestival")).Create)(), [18] = ((require("logic.manager.experimental.behaviormanager.activity.bm_giftoftime")).Create)(), [19] = ((require("logic.manager.experimental.behaviormanager.activity.bm_giftoftimepuzzle")).Create)(), [20] = ((require("logic.manager.experimental.behaviormanager.activity.bm_giftoftimemaze")).Create)(), [21] = ((require("logic.manager.experimental.behaviormanager.activity.bm_summerechoesactivity")).Create)()}
  self._timers = {}
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnActivityStart, ((NekoData.Events).Activity).n_ActivityStart, nil)
end

BM_Activity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in pairs(self._managers) do
    v:Clear()
  end
  for _,v in pairs(self._timers) do
    (ServerGameTimer.RemoveTask)(v)
  end
  self._timers = {}
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BM_Activity.HaveRedDot = function(self, id, record)
  -- function num : 0_2 , upvalues : _ENV
  if not id or not record then
    return false
  end
  local type = tonumber((record.record).bannerfunction)
  if self:IsActivityOpenByType(type) and type == 10 then
    return self:GetPuzzleRedDot((record.record).eventid)
  end
  if self:IsActivityOpenById(id) then
    if type == DataCommon.GeneralCollectionActFuncType then
      local localTipsKey = "OpenMidAutumnDialog_" .. (record.record).eventid
      return ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips)[localTipsKey])
    else
      do
        if type == DataCommon.GiftofTimeActFuncType then
          if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):ShowRedDot() and not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID)):ShowRedDot() then
            do return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)):ShowRedDot() end
            if type == DataCommon.TaskShopActFuncType then
              return ((NekoData.BehaviorManager).BM_CommonActivity):ShowRedDot((record.record).eventid)
            else
              if id == 9 then
                local invite = self:CheckInviteRedDot()
                warn(">> act: ", invite)
                return invite
              else
                do
                  if id == 21 then
                    return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityManagerID)):ShowRedDot()
                  else
                    if id == 41 then
                      return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)):ShowRedDot()
                    else
                      if id == 46 then
                        return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):ShowRedDot()
                      else
                        if id == 56 then
                          return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)):ShowRedDot()
                        else
                          if id == 48 or id == 72 then
                            if not (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasActivityManagerID)):ShowRedDot() then
                              do return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):ShowRedDot() end
                              if id == 63 then
                                return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):ShowRedDot()
                              else
                                if id == 66 then
                                  return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.LoverActivityManagerID)):ShowRedDot()
                                else
                                  if id == 85 then
                                    return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)):ShowRedDot()
                                  else
                                    if id == 100 then
                                      return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)):ShowRedDot()
                                    else
                                      if id == 104 then
                                        return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)):ShowRedDot()
                                      else
                                        if id == 125 then
                                          return ((NekoData.BehaviorManager).BM_Anniversary):ShowRedDot()
                                        else
                                          if id == 157 then
                                            return ((NekoData.BehaviorManager).BM_StarMirageCopy):ShowRedDot()
                                          else
                                            if id == 161 then
                                              return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):ShowRedDot()
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                              return false
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BM_Activity.GetCurrentActivities = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local t = {}
  local current = (ServerGameTimer.GetServerTime)()
  for id,time in pairs((self._activities).time) do
    if time < current then
      t[#t + 1] = id
    end
  end
  return t
end

BM_Activity.HasActivity = function(self, id)
  -- function num : 0_4
  do return ((self._activities).time)[id] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BM_Activity.GetEndTime = function(self, id)
  -- function num : 0_5
  return ((self._activities).time)[id]
end

BM_Activity.GetManager = function(self, id)
  -- function num : 0_6
  return (self._managers)[id]
end

BM_Activity.OnActivityStart = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local id = notification.userInfo
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if (self._timers)[id] then
    (self._timers)[id] = (ServerGameTimer.RemoveTask)((self._timers)[id])
  end
  local endtime = self:GetEndTime(id)
  local current = (ServerGameTimer.GetServerTime)()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._timers)[id] = (ServerGameTimer.AddTask)((endtime - current) // 1000, 0, function()
    -- function num : 0_7_0 , upvalues : self, id
    self:OnActivityStop(id)
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self._timers)[id] = nil
  end
)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ActivityStart, self, id)
end

BM_Activity.OnActivityStop = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ActivityStop, self, id)
end

BM_Activity.OnSSignCrossDay = function(self, activityId)
  -- function num : 0_9 , upvalues : _ENV
  local timer = (self._timers)[activityId]
  if timer then
    (ServerGameTimer.RemoveTask)(timer)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._timers)[activityId] = nil
    self:OnActivityStop(activityId)
  end
end

BM_Activity.IsActivityOpen = function(self, id)
  -- function num : 0_10
  local bm = (self._managers)[id]
  if not bm then
    if ((self._activities).others)[id] then
      return (((self._activities).others)[id]).isOpen
    end
    return false
  end
  if id == 2 then
    return bm:IsAgCoinActivityOpen()
  else
    return false
  end
end

BM_Activity.GetShatteredZonesClearReward = function(self)
  -- function num : 0_11
  return (self._activities).shatteredZonesClearReward
end

BM_Activity.GetArenaSeasonId = function(self)
  -- function num : 0_12
  return (self._activities).arenaSeasonId
end

BM_Activity.GetArenaId = function(self)
  -- function num : 0_13
  return (self._activities).arenaId
end

BM_Activity.GetArenaCamp = function(self)
  -- function num : 0_14
  return (self._activities).arenaCamp
end

BM_Activity.GetKeyExchangeTimes = function(self)
  -- function num : 0_15
  return (self._activities).exchangeTimes
end

BM_Activity.GetArenaEndDay = function(self)
  -- function num : 0_16
  return (self._activities).arenaEndDay
end

BM_Activity.GetArenaReceiveAward = function(self, items)
  -- function num : 0_17
  return (self._activities).arenaReceiveAward
end

BM_Activity.GetBanners = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local list = {}
  for k,v in pairs((self._activities).banner) do
    local data = clone(v)
    data.showRedDot = self:HaveRedDot(k, v)
    ;
    (table.insert)(list, data)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_18_0
    do return a.order < b.order end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

BM_Activity.GetIcons = function(self)
  -- function num : 0_19
  local lsit = {}
end

BM_Activity.GetEntrances = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local list = {}
  for k,v in pairs((self._activities).entrance) do
    local check = false
    if global_var_local_check and (v.id == 8 or v.id == 9) then
      check = true
    end
    if (v.record).evententrancetype ~= -1 and not check then
      local data = clone(v)
      data.showRedDot = self:HaveRedDot(k, v)
      ;
      (table.insert)(list, data)
    end
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_20_0
    do return a.order < b.order end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

BM_Activity.EnterActivity = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local list = self:GetEntrances()
  local num = #list
  if num == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100407)
  else
    if num == 1 then
      self:EnterActivityById((list[1]).id)
    else
      ;
      (DialogManager.CreateSingletonDialog)("activity.activitylistdialog")
    end
  end
end

BM_Activity.EnterActivityById = function(self, id)
  -- function num : 0_22 , upvalues : _ENV, CDungeonSelectMainLine, StarMirageUnlockRecord, SwimSuitUnlockRecord, LoverUnlockRecord, CTimedActivitySwitch, WelfareType, CActivityMidAutumnRe, CSfblessingChat
  LogInfoFormat("BM_Activity", "-EnterActivityById- bannerId = %s ---", id)
  if not ((self._activities).entrance)[id] then
    local value = ((self._activities).banner)[id]
  end
  if value then
    (DialogManager.DestroySingletonDialog)("activity.activitylistdialog")
    local type = (value.record).bannerfunction
    if type == 1 then
      if id == 1 then
        if value.canJump then
          ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).StarMirageUnlock)
          ;
          ((DialogManager.CreateSingletonDialog)("activity.starmirage.selectlevelmaindialog")):SetTabType(((NekoData.BehaviorManager).BM_Game):GetLocalCache((DataCommon.LocalCache).StarMirageOpenType))
        else
          local tmpRes = CDungeonSelectMainLine:GetRecorder(StarMirageUnlockRecord.scheduleinterval)
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100305, {tmpRes.floor})
        end
      else
        do
          if id == 21 then
            if value.canJump then
              local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummeractivityinfo")
              if protocol then
                protocol:Send()
              end
            else
              do
                do
                  local tmpRes = CDungeonSelectMainLine:GetRecorder(SwimSuitUnlockRecord.scheduleinterval)
                  ;
                  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100393, {tmpRes.floor})
                  if id == 161 then
                    if value.canJump then
                      (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):SendCGetSummerEchoInfo()
                    else
                      ;
                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100418)
                    end
                  else
                    if id == 48 or id == 72 then
                      if value.canJump and ((((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):GetIsOpen() or self:IsActivityOpen((DataCommon.Activities).Christmas)) then
                        if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):GetIsOpen() then
                          if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).ChristmasCallActivityUnlock) then
                            local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                            if sceneController then
                              (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.ChristmasCallTimeLineId)
                            end
                          else
                            do
                              ;
                              (DialogManager.CreateSingletonDialog)("activity.chrismascall.maindialog")
                              ;
                              ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).ChristmasCallActivityUnlock)
                              ;
                              (DialogManager.CreateSingletonDialog)("activity.chrismascall.maindialog")
                              ;
                              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100439)
                              if id == 66 then
                                if value.canJump then
                                  (DialogManager.CreateSingletonDialog)("activity.loverunlockdialog")
                                else
                                  local tmpRes = CDungeonSelectMainLine:GetRecorder(LoverUnlockRecord.scheduleinterval)
                                  ;
                                  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100450, {tmpRes.floor})
                                end
                              else
                                do
                                  if id == 125 then
                                    if value.canJump then
                                      (DialogManager.CreateSingletonDialog)("activity.anniversarypackage.anniversarypackagemaindialog")
                                    else
                                      local AnniversaryUnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).Anniversary)
                                      local tmpRes = CDungeonSelectMainLine:GetRecorder(AnniversaryUnlockRecord.scheduleinterval)
                                      ;
                                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100450, {tmpRes.floor})
                                    end
                                  else
                                    do
                                      if id == 157 then
                                        if value.canJump then
                                          if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageCopy) then
                                            local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                            if sceneController then
                                              (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.StarMirageCopyTimeLineId)
                                            end
                                          else
                                            do
                                              ;
                                              (DialogManager.CreateSingletonDialog)("activity.starmirage1package.maindialog")
                                              ;
                                              ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).StarMirageCopy)
                                              local Starmirage1UnlockRecord = CTimedActivitySwitch:GetRecorder((DataCommon.Activities).StarMirageCopy)
                                              do
                                                local tmpRes = CDungeonSelectMainLine:GetRecorder(Starmirage1UnlockRecord.scheduleinterval)
                                                ;
                                                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100450, {tmpRes.floor})
                                                if type == 2 then
                                                  local baseMainUI = (DialogManager.GetDialog)("base.basemainui")
                                                  if baseMainUI then
                                                    baseMainUI:OnGachaClick()
                                                  end
                                                else
                                                  do
                                                    if type == 3 then
                                                      ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(tonumber((value.record).functionparameter))
                                                      local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
                                                      if protocol then
                                                        protocol:Send()
                                                      end
                                                    else
                                                      do
                                                        if type == 4 then
                                                          if id == 6 then
                                                            if value.canJump then
                                                              ((DialogManager.CreateSingletonDialog)("activity.share.sharemaindialog")):SetId(6)
                                                            else
                                                              ;
                                                              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100408)
                                                            end
                                                          else
                                                            if id == 8 then
                                                              (DialogManager.CreateSingletonDialog)("invite.inviteacceptdlg")
                                                              return 
                                                            else
                                                              if id == 9 then
                                                                local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.copeninviteshare")
                                                                cmd:Send()
                                                                return 
                                                              end
                                                            end
                                                          end
                                                        else
                                                          do
                                                            if type == 5 then
                                                              ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((value.record).functionparameter)
                                                            else
                                                              if type == 6 then
                                                                if value.canJump then
                                                                  local funcParam = tonumber((value.record).functionparameter)
                                                                  if funcParam == WelfareType.dreamSpiral then
                                                                    local mainLineProgress = ((NekoData.BehaviorManager).BM_Game):GetMainLineProgress()
                                                                    if mainLineProgress and mainLineProgress.floor and tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(100)).Value) < mainLineProgress.floor then
                                                                      local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
                                                                      if dialog then
                                                                        dialog:SetJumpTab(funcParam)
                                                                        dialog:SetData(true)
                                                                      end
                                                                    else
                                                                      do
                                                                        do
                                                                          ;
                                                                          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100347)
                                                                          do
                                                                            if funcParam == WelfareType.qixi then
                                                                              local dialog = (DialogManager.CreateSingletonDialog)("welfare.welfaremaindialog")
                                                                              if dialog then
                                                                                dialog:SetJumpTab(funcParam)
                                                                                dialog:SetData(true)
                                                                              end
                                                                            end
                                                                            ;
                                                                            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100408)
                                                                            if type == 8 then
                                                                              local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                                                                              dialog:OnTypeFourBtnClicked()
                                                                            else
                                                                              do
                                                                                if type == DataCommon.GeneralCollectionActFuncType then
                                                                                  if value.canJump then
                                                                                    local localTipsKey = "OpenMidAutumnDialog_" .. (value.record).eventid
                                                                                    local activityMidAutumnReRecord = CActivityMidAutumnRe:GetRecorder((value.record).eventid)
                                                                                    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips)[localTipsKey]) then
                                                                                      local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                      if sceneController then
                                                                                        (sceneController._baseMainFSM):SetNumber("storyId", activityMidAutumnReRecord.TimelineId)
                                                                                      end
                                                                                    else
                                                                                      do
                                                                                        ;
                                                                                        (DialogManager.ModifyDialogAsset)("activity.midautumn.midautumndialog", (activityMidAutumnReRecord.ResourcePath)[1], (activityMidAutumnReRecord.ResourceName)[1])
                                                                                        ;
                                                                                        (DialogManager.ModifyDialogAsset)("activity.midautumn.exchangedialog", (activityMidAutumnReRecord.ResourcePath)[2], (activityMidAutumnReRecord.ResourceName)[2])
                                                                                        ;
                                                                                        (DialogManager.ModifyDialogAsset)("activity.midautumn.midautumnitemcell", (activityMidAutumnReRecord.ResourcePath)[3], (activityMidAutumnReRecord.ResourceName)[3])
                                                                                        do
                                                                                          local dialog = (DialogManager.CreateSingletonDialog)("activity.midautumn.midautumndialog")
                                                                                          dialog:SetRecord(activityMidAutumnReRecord)
                                                                                          ;
                                                                                          ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips)[localTipsKey])
                                                                                          ;
                                                                                          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100423)
                                                                                          if type == 10 then
                                                                                            if value.canJump then
                                                                                              if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenPuzzleDialog) then
                                                                                                ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenPuzzleDialog)
                                                                                              end
                                                                                              ;
                                                                                              (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):OpenActivityDialog((value.record).eventid)
                                                                                            else
                                                                                              ;
                                                                                              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100418)
                                                                                            end
                                                                                          else
                                                                                            if type == 11 then
                                                                                              if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.HalloweenActivityID)):GetIsOpen() then
                                                                                                if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenHalloweenDialog) then
                                                                                                  local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                  if sceneController then
                                                                                                    (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.HalloweenTimeLineId)
                                                                                                  end
                                                                                                else
                                                                                                  do
                                                                                                    ;
                                                                                                    (DialogManager.CreateSingletonDialog)("activity.halloween.halloweenmaindialog")
                                                                                                    ;
                                                                                                    ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenHalloweenDialog)
                                                                                                    ;
                                                                                                    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100417)
                                                                                                    if type == 12 then
                                                                                                      if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DoubleElevenActivityID)):GetIsOpen() then
                                                                                                        (DialogManager.CreateSingletonDialog)("activity.doubleeleven.maindialog")
                                                                                                      else
                                                                                                        ;
                                                                                                        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100419)
                                                                                                      end
                                                                                                    else
                                                                                                      if type == 13 then
                                                                                                        if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.BirthDayActivityManagerID)):GetIsOpen() then
                                                                                                          if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenBirthDayDialog) then
                                                                                                            local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                            if sceneController then
                                                                                                              (sceneController._baseMainFSM):SetNumber("storyId", (DataCommon.BirtDayTimeLineId)[120001])
                                                                                                            end
                                                                                                          else
                                                                                                            do
                                                                                                              ;
                                                                                                              (DialogManager.CreateSingletonDialog)("activity.birthday.maindialog")
                                                                                                              ;
                                                                                                              ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenBirthDayDialog)
                                                                                                              ;
                                                                                                              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100423)
                                                                                                              if type == 14 then
                                                                                                                if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetIsOpen() then
                                                                                                                  local day = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetDay()
                                                                                                                  local clientbuffer = (((CS.UnityEngine).PlayerPrefs).GetInt)("SpringFestivalDay")
                                                                                                                  if not clientbuffer or clientbuffer ~= day then
                                                                                                                    (((CS.UnityEngine).PlayerPrefs).SetInt)("SpringFestivalDay", day)
                                                                                                                    ;
                                                                                                                    (LuaNotificationCenter.PostNotification)(Common.n_RefreshSpringFestivalRedDot)
                                                                                                                    local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                                    if sceneController then
                                                                                                                      local timelineRecorder = CSfblessingChat:GetRecorder(day)
                                                                                                                      if timelineRecorder then
                                                                                                                        (sceneController._baseMainFSM):SetNumber("storyId", timelineRecorder.timelineID)
                                                                                                                      else
                                                                                                                        ;
                                                                                                                        (DialogManager.CreateSingletonDialog)("activity.springfestival.springfestivalmaindialog")
                                                                                                                      end
                                                                                                                    end
                                                                                                                  else
                                                                                                                    do
                                                                                                                      do
                                                                                                                        ;
                                                                                                                        (DialogManager.CreateSingletonDialog)("activity.springfestival.springfestivalmaindialog")
                                                                                                                        ;
                                                                                                                        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100423)
                                                                                                                        if type == 15 then
                                                                                                                          if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.AprilFoolsDayActivityManagerID)):GetIsOpen() then
                                                                                                                            if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenAprilFoolsDayDialog) then
                                                                                                                              local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                                              if sceneController then
                                                                                                                                (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.AprilFoolsDayTimeLineId)
                                                                                                                              end
                                                                                                                            else
                                                                                                                              do
                                                                                                                                ;
                                                                                                                                (DialogManager.CreateSingletonDialog)("activity.aprilfoolsday.aprilfoolsdaymaindialog")
                                                                                                                                ;
                                                                                                                                ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenAprilFoolsDayDialog)
                                                                                                                                ;
                                                                                                                                ((NekoData.BehaviorManager).BM_Message):SendMessageById(100418)
                                                                                                                                if type == 16 then
                                                                                                                                  if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChildrenActivityManagerID)):GetIsOpen() then
                                                                                                                                    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenChildrenDialog) then
                                                                                                                                      local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                                                      if sceneController then
                                                                                                                                        (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.ChildrenDayTimeLineId)
                                                                                                                                      end
                                                                                                                                    else
                                                                                                                                      do
                                                                                                                                        ;
                                                                                                                                        (DialogManager.CreateSingletonDialog)("activity.children.childrenmaindialog")
                                                                                                                                        ;
                                                                                                                                        ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenChildrenDialog)
                                                                                                                                        ;
                                                                                                                                        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100423)
                                                                                                                                        if type == 17 then
                                                                                                                                          if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.DragonBoatFestivalActivityManagerID)):GetIsOpen() then
                                                                                                                                            if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).OpenDragonBoatFestivalDialog) then
                                                                                                                                              local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                                                                                                                                              if sceneController then
                                                                                                                                                (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.DragonBoatFestivalTimeLineId)
                                                                                                                                              end
                                                                                                                                            else
                                                                                                                                              do
                                                                                                                                                do
                                                                                                                                                  ;
                                                                                                                                                  (DialogManager.CreateSingletonDialog)("activity.dragonboatfestival.maindialog")
                                                                                                                                                  ;
                                                                                                                                                  ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenDragonBoatFestivalDialog)
                                                                                                                                                  ;
                                                                                                                                                  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100419)
                                                                                                                                                  if type == 18 then
                                                                                                                                                    if value.canJump and (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)):GetIsOpen() then
                                                                                                                                                      (DialogManager.CreateSingletonDialog)("activity.giftoftime.giftoftimemaindialog")
                                                                                                                                                    else
                                                                                                                                                      ;
                                                                                                                                                      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100419)
                                                                                                                                                    end
                                                                                                                                                  else
                                                                                                                                                    if type == 19 then
                                                                                                                                                      if value.canJump and ((NekoData.BehaviorManager).BM_CommonActivity):GetIsOpen((value.record).eventid) then
                                                                                                                                                        ((NekoData.BehaviorManager).BM_CommonActivity):OpenActivityDialog((value.record).eventid)
                                                                                                                                                      else
                                                                                                                                                        ;
                                                                                                                                                        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100489)
                                                                                                                                                      end
                                                                                                                                                    end
                                                                                                                                                  end
                                                                                                                                                  LogErrorFormat("BM_Activity", "id：%s error.", id)
                                                                                                                                                end
                                                                                                                                              end
                                                                                                                                            end
                                                                                                                                          end
                                                                                                                                        end
                                                                                                                                      end
                                                                                                                                    end
                                                                                                                                  end
                                                                                                                                end
                                                                                                                              end
                                                                                                                            end
                                                                                                                          end
                                                                                                                        end
                                                                                                                      end
                                                                                                                    end
                                                                                                                  end
                                                                                                                end
                                                                                                              end
                                                                                                            end
                                                                                                          end
                                                                                                        end
                                                                                                      end
                                                                                                    end
                                                                                                  end
                                                                                                end
                                                                                              end
                                                                                            end
                                                                                          end
                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BM_Activity.IsActivityOpenById = function(self, id)
  -- function num : 0_23 , upvalues : _ENV
  if not ((self._activities).entrance)[id] then
    local value = ((self._activities).banner)[id]
  end
  if value then
    if (value.record).bannerfunction == DataCommon.GeneralCollectionActFuncType then
      return value
    else
      if value then
        do return value.canJump end
      end
    end
  end
end

BM_Activity.IsActivityOpenByType = function(self, type)
  -- function num : 0_24 , upvalues : _ENV
  for k,v in pairs((self._activities).entrance) do
    if (v.record).bannerfunction == type then
      return true
    end
  end
  for k,v in pairs((self._activities).banner) do
    if (v.record).bannerfunction == type then
      return true
    end
  end
end

BM_Activity.CheckInviteRedDot = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local b = false
  if ((self._activities).redDot)[9] then
    for _,v in pairs(((self._activities).redDot)[9]) do
      if not b then
        b = v
      end
    end
  end
  do
    return b
  end
end

BM_Activity.GetInviteRedDot = function(self, id)
  -- function num : 0_26
  local t = ((self._activities).redDot)[9]
  return t and t[id] or false
end

BM_Activity.GetPuzzleRedDot = function(self, actId)
  -- function num : 0_27 , upvalues : _ENV
  return (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.PuzzleActivityID)):ShowRedDot(actId)
end

BM_Activity.HaveGetReward = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local list = self:GetEntrances()
  for _,value in pairs(list) do
    if value.showRedDot then
      return true
    end
  end
end

BM_Activity.HaveGetRewardById = function(self, managerId)
  -- function num : 0_29 , upvalues : _ENV
  local manager = (self._managers)[managerId]
  if manager then
    return manager:ShowRedDot()
  else
    LogErrorFormat("BM_Activity", "managerId(%s) Error.", managerId)
  end
end

BM_Activity.GetShareActivity = function(self, bannerId)
  -- function num : 0_30 , upvalues : _ENV
  local value = ((self._activities).share)[bannerId]
  if not value then
    LogErrorFormat("BM_Activity", "bannerId(%s) Error.", bannerId)
  end
  return value
end

BM_Activity.GetMidAutumnLeftTime = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local list = ((self._activities).typeMap)[DataCommon.GeneralCollectionActFuncType]
  for _,bannerRecord in ipairs(list) do
    if self:IsActivityOpenById(bannerRecord.id) and (self._activities).midAutumnInfo then
      return ((self._activities).midAutumnInfo).leftTime
    end
  end
  return 0
end

BM_Activity.GetMidAutumnActivityId = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local list = ((self._activities).typeMap)[DataCommon.GeneralCollectionActFuncType]
  for _,bannerRecord in ipairs(list) do
    if self:IsActivityOpenById(bannerRecord.id) and (self._activities).midAutumnInfo then
      return bannerRecord.eventid
    end
  end
end

BM_Activity.GetActivityRedPointID = function(self)
  -- function num : 0_33
  return self._redPointActivityID
end

BM_Activity.GetPopTipsStatusWithActivityId = function(self, activityId)
  -- function num : 0_34
  if ((self._activities).popTips)[activityId] then
    return (((self._activities).popTips)[activityId]).status
  end
end

BM_Activity.GetBackTaskRedPoint = function(self)
  -- function num : 0_35 , upvalues : _ENV
  return ((self._activities).redDot)[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask]
end

BM_Activity.GetBackGiftRedPoint = function(self)
  -- function num : 0_36 , upvalues : _ENV
  return ((self._activities).redDot)[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode]
end

BM_Activity.SetBackTaskRedPoint = function(self, flag)
  -- function num : 0_37 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ((self._activities).redDot)[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).returnTask] = flag
end

BM_Activity.SetBackGiftRedPoint = function(self, flag)
  -- function num : 0_38 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ((self._activities).redDot)[(((NekoData.BehaviorManager).BM_ReturnWelfare).DisplayType).enterInvitedCode] = flag
end

BM_Activity.GetOtherActivityLeftTimeWithActivityId = function(self, activityId)
  -- function num : 0_39 , upvalues : _ENV
  if ((self._activities).others)[activityId] then
    return (((self._activities).others)[activityId]).leftTime
  else
    LogErrorFormat("BM_Activity", "activity id %s wrong", activityId)
  end
  return 0
end

BM_Activity.GetWhiteValentine = function(self)
  -- function num : 0_40
  return (self._activities).whiteValentine
end

BM_Activity.GetBannerIdByActivityId = function(self, activityId)
  -- function num : 0_41 , upvalues : CBannerAndEntrance
  local allIds = CBannerAndEntrance:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CBannerAndEntrance:GetRecorder(allIds[i])
    if record.eventid == activityId then
      return allIds[i]
    end
  end
end

BM_Activity.GetActivityIdByType = function(self, type)
  -- function num : 0_42 , upvalues : _ENV
  for k,v in pairs((self._activities).entrance) do
    if (v.record).bannerfunction == type then
      return (v.record).eventid
    end
  end
  for k,v in pairs((self._activities).banner) do
    if (v.record).bannerfunction == type then
      return (v.record).eventid
    end
  end
end

BM_Activity.GetPopUpGift = function(self)
  -- function num : 0_43
  if ((self._activities).popUpGift).firstOpenActivityId then
    return (self._activities).popUpGift
  end
end

BM_Activity.IsAutoPopUpGift = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local type = (DataCommon.LocalCache).PopUpGiftAutoOpenType
  local value = ((NekoData.BehaviorManager).BM_Game):GetLocalCache(type)
  local record = self:GetPopUpGiftRecord()
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if not ((self._activities).popUpGift).data and ((self._activities).popUpGift).firstOpenActivityId and value == type.Default then
    return type.First
  end
  if ((self._activities).popUpGift).data and record then
    local leftTime = (((self._activities).popUpGift).data).leftTime
    local ratio = leftTime // 1000 / (record.time * 3600)
    if value == type.Default then
      return type.First
    end
    if value == type.First and ratio <= 0.5 then
      return type.Second
    end
    if value == type.Second and ratio <= 0.1 then
      return type.Third
    end
  end
end

BM_Activity.GetPopUpGiftRecord = function(self)
  -- function num : 0_45 , upvalues : CPopUpGift, _ENV
  if ((self._activities).popUpGift).firstOpenActivityId then
    local allIds = CPopUpGift:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local tmpRecord = CPopUpGift:GetRecorder(allIds[i])
      if tmpRecord.activityID == ((self._activities).popUpGift).firstOpenActivityId then
        return tmpRecord
      end
    end
    LogErrorFormat("BM_Activity", "Can not find record by activityId: %s in cpopupgift", ((self._activities).popUpGift).firstOpenActivityId)
  end
end

BM_Activity.GetPopUpGift7Day = function(self)
  -- function num : 0_46 , upvalues : _ENV
  return clone((self._activities).popUpGift7Day)
end

BM_Activity.IsAutoPopUpGift7Day = function(self)
  -- function num : 0_47 , upvalues : _ENV
  if (self._activities).popUpGift7Day and ((self._activities).popUpGift7Day).pop == 1 then
    local type = (DataCommon.LocalCache).PopUpGift7DayAutoOpenType
    local value = ((NekoData.BehaviorManager).BM_Game):GetLocalCache(type)
    if value == type.Default then
      return type.First
    else
      if value == type.First then
        return type.Second
      else
        if value == type.Second then
          return type.Third
        end
      end
    end
  end
end

BM_Activity.ShowPopUpGift7DayRedDot = function(self)
  -- function num : 0_48 , upvalues : _ENV, CommonAwardStatus
  if (self._activities).popUpGift7Day then
    for k,v in pairs(((self._activities).popUpGift7Day).rewards) do
      if v == CommonAwardStatus.UNLOCKED then
        return true
      end
    end
  end
end

BM_Activity.GetPopUpGift7DayActivityId = function(self)
  -- function num : 0_49 , upvalues : _ENV, C7DaySPopUpGift
  if (self._activities).popUpGift7Day then
    for k,v in pairs(((self._activities).popUpGift7Day).rewards) do
      local record = C7DaySPopUpGift:GetRecorder(k)
      if record then
        return record.activityID
      else
        LogErrorFormat("BM_Activity", "Can not find record by activityId: %s in c7dayspopupgift", k)
      end
    end
  end
end

BM_Activity.GetPopUpGift7DayTotalDuration = function(self)
  -- function num : 0_50 , upvalues : CTimedActivitySwitch, _ENV
  if (self._activities).popUpGift7Day then
    local activityId = self:GetPopUpGift7DayActivityId()
    local record = CTimedActivitySwitch:GetRecorder(activityId)
    local openTime = (os.time)(self:GetDateMap(record.openTime))
    local closeTime = (os.time)(self:GetDateMap(record.closeTime))
    if openTime < closeTime then
      return (closeTime - openTime) * 1000
    end
  end
  do
    return 0
  end
end

BM_Activity.GetDateMap = function(self, str)
  -- function num : 0_51 , upvalues : _ENV
  local strList1 = (string.split)(str, " ")
  local dateList = (string.split)(strList1[1], "-")
  local timeList = (string.split)(strList1[2], ":")
  return {year = dateList[1], month = dateList[2], day = dateList[3], hour = timeList[1], min = timeList[2], sec = timeList[3]}
end

BM_Activity.GetDailySupplyDataByActivityId = function(self, activityId)
  -- function num : 0_52 , upvalues : _ENV
  local data = ((self._activities).dailySupplyMap)[activityId]
  if not data then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(sactivitydailysupply) by activityId(%s)", activityId)
  else
    local list = {}
    for k,v in pairs(data) do
      (table.insert)(list, {id = k, status = v})
    end
    return list
  end
end

BM_Activity.ShowDailySupplyRedDotByActivityId = function(self, activityId)
  -- function num : 0_53 , upvalues : _ENV, SActivityDailySupply
  local data = ((self._activities).dailySupplyMap)[activityId]
  if not data then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(sactivitydailysupply) by activityId(%s)", activityId)
  else
    for k,v in pairs(data) do
      if v == SActivityDailySupply.UNLOCKED then
        return true
      end
    end
  end
end

BM_Activity.GetAccumulateRewardListByActivityId = function(self, activityId)
  -- function num : 0_54 , upvalues : _ENV
  if not ((self._activities).accumulateRewardMap)[activityId] then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(SGetPointsCollection) by activityId(%s)", activityId)
    return 
  else
    return (((self._activities).accumulateRewardMap)[activityId]).accumulateRewardList
  end
end

BM_Activity.GetAccumulatePointsByActivityId = function(self, activityId, itemId)
  -- function num : 0_55 , upvalues : _ENV
  if not ((self._activities).accumulateRewardMap)[activityId] then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(srefreshpointstasks) by activityId(%s)", activityId)
    return 
  else
    return ((((self._activities).accumulateRewardMap)[activityId]).accumulatePoints)[itemId] or 0
  end
end

BM_Activity.ShowAccumulateRedDot = function(self, activityId)
  -- function num : 0_56 , upvalues : _ENV
  local tmp = ((self._activities).accumulateRewardMap)[activityId]
  if not tmp then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(SGetPointsCollection) by activityId(%s)", activityId)
    return 
  end
  for i,v in ipairs((((self._activities).accumulateRewardMap)[activityId]).accumulateRewardList) do
    if v.status == 1 then
      return true
    end
  end
end

BM_Activity.JudgeActivityType = function(self, activityId, type)
  -- function num : 0_57 , upvalues : _ENV
  do return (string.sub)(activityId, 1, 3) == type end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BM_Activity

