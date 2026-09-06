local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CTimedActivitySwitch = BeanManager.GetTableByName("activity.ctimedactivityswitch")
local CSfblessingChat = BeanManager.GetTableByName("activity.csfblessingchat")
local CActivityMidAutumnRe = BeanManager.GetTableByName("activity.cactivitymidautumnre")
local CBannerAndEntrance = BeanManager.GetTableByName("activity.cbannerandentrance")
local CPopUpGift = BeanManager.GetTableByName("topup.cpopupgift")
local C7DaySPopUpGift = BeanManager.GetTableByName("topup.c7dayspopupgift")
local StarMirageUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.StarMirage)
local SwimSuitUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.SwimSuit)
local ChristmasUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.Christmas)
local LoverUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.Lover)
local SpringFestivalUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.SpringFestival)
local SActivityDailySupply = LuaNetManager.GetProtocolDef("protocol.activity.sactivitydailysupply")
local CommonAwardStatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local WelfareType = require("logic.dialog.welfare.welfaremaindialog").WelfareType
local BM_Activity = class("BM_Activity")

function BM_Activity:Ctor()
  self._activities = NekoData.Data.activities
  self._managers = {
    [1] = require("logic.manager.experimental.behaviormanager.activity.bm_spiritdiscount").Create(),
    [2] = require("logic.manager.experimental.behaviormanager.activity.bm_agcoin").Create(),
    [3] = require("logic.manager.experimental.behaviormanager.activity.bm_sign").Create(),
    [4] = require("logic.manager.experimental.behaviormanager.activity.bm_starmirage").Create(),
    [5] = require("logic.manager.experimental.behaviormanager.activity.bm_puzzle").Create(),
    [6] = require("logic.manager.experimental.behaviormanager.activity.bm_summeractivity").Create(),
    [8] = require("logic.manager.experimental.behaviormanager.activity.bm_halloween").Create(),
    [9] = require("logic.manager.experimental.behaviormanager.activity.bm_doubleeleven").Create(),
    [10] = require("logic.manager.experimental.behaviormanager.activity.bm_christmas").Create(),
    [11] = require("logic.manager.experimental.behaviormanager.activity.bm_birthday").Create(),
    [12] = require("logic.manager.experimental.behaviormanager.activity.bm_christmascall").Create(),
    [13] = require("logic.manager.experimental.behaviormanager.activity.bm_springfestival").Create(),
    [14] = require("logic.manager.experimental.behaviormanager.activity.bm_lover").Create(),
    [15] = require("logic.manager.experimental.behaviormanager.activity.bm_aprilfoolsday").Create(),
    [16] = require("logic.manager.experimental.behaviormanager.activity.bm_children").Create(),
    [17] = require("logic.manager.experimental.behaviormanager.activity.bm_dragonboatfestival").Create(),
    [18] = require("logic.manager.experimental.behaviormanager.activity.bm_giftoftime").Create(),
    [19] = require("logic.manager.experimental.behaviormanager.activity.bm_giftoftimepuzzle").Create(),
    [20] = require("logic.manager.experimental.behaviormanager.activity.bm_giftoftimemaze").Create(),
    [21] = require("logic.manager.experimental.behaviormanager.activity.bm_summerechoesactivity").Create()
  }
  self._timers = {}
  LuaNotificationCenter.AddObserver(self, self.OnActivityStart, NekoData.Events.Activity.n_ActivityStart, nil)
end

function BM_Activity:Clear()
  for _, v in pairs(self._managers) do
    v:Clear()
  end
  for _, v in pairs(self._timers) do
    ServerGameTimer.RemoveTask(v)
  end
  self._timers = {}
  LuaNotificationCenter.RemoveObserver(self)
end

function BM_Activity:HaveRedDot(id, record)
  if not id or not record then
    return false
  end
  local type = tonumber(record.record.bannerfunction)
  if self:IsActivityOpenByType(type) and type == 10 then
    return self:GetPuzzleRedDot(record.record.eventid)
  end
  if self:IsActivityOpenById(id) then
    if type == DataCommon.GeneralCollectionActFuncType then
      local localTipsKey = "OpenMidAutumnDialog_" .. record.record.eventid
      return NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips[localTipsKey])
    elseif type == DataCommon.GiftofTimeActFuncType then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):ShowRedDot() or NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimePuzzleActivityManagerID):ShowRedDot() or NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID):ShowRedDot()
    elseif type == DataCommon.TaskShopActFuncType then
      return NekoData.BehaviorManager.BM_CommonActivity:ShowRedDot(record.record.eventid)
    elseif id == 9 then
      local invite = self:CheckInviteRedDot()
      warn(">> act: ", invite)
      return invite
    elseif id == 21 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):ShowRedDot()
    elseif id == 41 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID):ShowRedDot()
    elseif id == 46 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID):ShowRedDot()
    elseif id == 56 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID):ShowRedDot()
    elseif id == 48 or id == 72 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):ShowRedDot() or NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID):ShowRedDot()
    elseif id == 63 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):ShowRedDot()
    elseif id == 66 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID):ShowRedDot()
    elseif id == 85 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID):ShowRedDot()
    elseif id == 100 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID):ShowRedDot()
    elseif id == 104 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID):ShowRedDot()
    elseif id == 125 then
      return NekoData.BehaviorManager.BM_Anniversary:ShowRedDot()
    elseif id == 157 or id == 277 then
      return NekoData.BehaviorManager.BM_StarMirageCopy:ShowRedDot()
    elseif id == 161 then
      return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):ShowRedDot()
    end
  end
  return false
end

function BM_Activity:GetCurrentActivities()
  local t = {}
  local current = ServerGameTimer.GetServerTime()
  for id, time in pairs(self._activities.time) do
    if time < current then
      t[#t + 1] = id
    end
  end
  return t
end

function BM_Activity:HasActivity(id)
  return self._activities.time[id] ~= nil
end

function BM_Activity:GetEndTime(id)
  return self._activities.time[id]
end

function BM_Activity:GetManager(id)
  return self._managers[id]
end

function BM_Activity:OnActivityStart(notification)
  local id = notification.userInfo
  if self._timers[id] then
    self._timers[id] = ServerGameTimer.RemoveTask(self._timers[id])
  end
  local endtime = self:GetEndTime(id)
  local current = ServerGameTimer.GetServerTime()
  self._timers[id] = ServerGameTimer.AddTask((endtime - current) // 1000, 0, function()
    self:OnActivityStop(id)
    self._timers[id] = nil
  end)
  LuaNotificationCenter.PostNotification(Common.n_ActivityStart, self, id)
end

function BM_Activity:OnActivityStop(id)
  LuaNotificationCenter.PostNotification(Common.n_ActivityStop, self, id)
end

function BM_Activity:OnSSignCrossDay(activityId)
  local timer = self._timers[activityId]
  if timer then
    ServerGameTimer.RemoveTask(timer)
    self._timers[activityId] = nil
    self:OnActivityStop(activityId)
  end
end

function BM_Activity:IsActivityOpen(id)
  local bm = self._managers[id]
  if not bm then
    if self._activities.others[id] then
      return self._activities.others[id].isOpen
    end
    return false
  end
  if id == 2 then
    return bm:IsAgCoinActivityOpen()
  else
    return false
  end
end

function BM_Activity:GetShatteredZonesClearReward()
  return self._activities.shatteredZonesClearReward
end

function BM_Activity:GetArenaSeasonId()
  return self._activities.arenaSeasonId
end

function BM_Activity:GetArenaId()
  return self._activities.arenaId
end

function BM_Activity:GetArenaCamp()
  return self._activities.arenaCamp
end

function BM_Activity:GetKeyExchangeTimes()
  return self._activities.exchangeTimes
end

function BM_Activity:GetArenaEndDay()
  return self._activities.arenaEndDay
end

function BM_Activity:GetArenaReceiveAward(items)
  return self._activities.arenaReceiveAward
end

function BM_Activity:GetBanners()
  local list = {}
  for k, v in pairs(self._activities.banner) do
    local data = clone(v)
    data.showRedDot = self:HaveRedDot(k, v)
    table.insert(list, data)
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  return list
end

function BM_Activity:GetIcons()
  local lsit = {}
end

function BM_Activity:GetEntrances()
  local list = {}
  for k, v in pairs(self._activities.entrance) do
    local check = false
    if global_var_local_check and (v.id == 8 or v.id == 9) then
      check = true
    end
    if v.record.evententrancetype ~= -1 and not check then
      local data = clone(v)
      data.showRedDot = self:HaveRedDot(k, v)
      table.insert(list, data)
    end
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  return list
end

function BM_Activity:EnterActivity()
  local list = self:GetEntrances()
  local num = #list
  if num == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100407)
  elseif num == 1 then
    self:EnterActivityById(list[1].id)
  else
    DialogManager.CreateSingletonDialog("activity.activitylistdialog")
  end
end

function BM_Activity:EnterActivityById(id)
  LogInfoFormat("BM_Activity", "-EnterActivityById- bannerId = %s ---", id)
  local value = self._activities.entrance[id] or self._activities.banner[id]
  if value then
    DialogManager.DestroySingletonDialog("activity.activitylistdialog")
    local type = value.record.bannerfunction
    if type == 1 then
      if id == 1 then
        if value.canJump then
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.StarMirageUnlock)
          DialogManager.CreateSingletonDialog("activity.starmirage.selectlevelmaindialog"):SetTabType(NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.StarMirageOpenType))
        else
          local tmpRes = CDungeonSelectMainLine:GetRecorder(StarMirageUnlockRecord.scheduleinterval)
          NekoData.BehaviorManager.BM_Message:SendMessageById(100305, {
            tmpRes.floor
          })
        end
      elseif id == 21 then
        if value.canJump then
          local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetsummeractivityinfo")
          if protocol then
            protocol:Send()
          end
        else
          local tmpRes = CDungeonSelectMainLine:GetRecorder(SwimSuitUnlockRecord.scheduleinterval)
          NekoData.BehaviorManager.BM_Message:SendMessageById(100393, {
            tmpRes.floor
          })
        end
      elseif id == 161 then
        if value.canJump then
          NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):SendCGetSummerEchoInfo()
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100418)
        end
      elseif id == 48 or id == 72 then
        if value.canJump and (NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID):GetIsOpen() or self:IsActivityOpen(DataCommon.Activities.Christmas)) then
          if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID):GetIsOpen() then
            if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.ChristmasCallActivityUnlock) then
              local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
              if sceneController then
                sceneController._baseMainFSM:SetNumber("storyId", DataCommon.ChristmasCallTimeLineId)
              end
            else
              DialogManager.CreateSingletonDialog("activity.chrismascall.maindialog")
              NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.ChristmasCallActivityUnlock)
            end
          else
            DialogManager.CreateSingletonDialog("activity.chrismascall.maindialog")
          end
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100439)
        end
      elseif id == 66 then
        if value.canJump then
          DialogManager.CreateSingletonDialog("activity.loverunlockdialog")
        else
          local tmpRes = CDungeonSelectMainLine:GetRecorder(LoverUnlockRecord.scheduleinterval)
          NekoData.BehaviorManager.BM_Message:SendMessageById(100450, {
            tmpRes.floor
          })
        end
      elseif id == 125 then
        if value.canJump then
          DialogManager.CreateSingletonDialog("activity.anniversarypackage.anniversarypackagemaindialog")
        else
          local AnniversaryUnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.Anniversary)
          local tmpRes = CDungeonSelectMainLine:GetRecorder(AnniversaryUnlockRecord.scheduleinterval)
          NekoData.BehaviorManager.BM_Message:SendMessageById(100450, {
            tmpRes.floor
          })
        end
      elseif id == 157 or id == 277 then
        if value.canJump then
          if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageCopy) then
            local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
            if sceneController then
              sceneController._baseMainFSM:SetNumber("storyId", DataCommon.StarMirageCopyTimeLineId)
            end
          else
            DialogManager.CreateSingletonDialog("activity.starmirage1package.maindialog")
            NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.StarMirageCopy)
          end
        else
          local Starmirage1UnlockRecord = CTimedActivitySwitch:GetRecorder(DataCommon.Activities.StarMirageCopy)
          local tmpRes = CDungeonSelectMainLine:GetRecorder(Starmirage1UnlockRecord.scheduleinterval)
          NekoData.BehaviorManager.BM_Message:SendMessageById(100450, {
            tmpRes.floor
          })
        end
      end
    elseif type == 2 then
      local baseMainUI = DialogManager.GetDialog("base.basemainui")
      if baseMainUI then
        baseMainUI:OnGachaClick()
      end
    elseif type == 3 then
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(tonumber(value.record.functionparameter))
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    elseif type == 4 then
      if id == 6 then
        if value.canJump then
          DialogManager.CreateSingletonDialog("activity.share.sharemaindialog"):SetId(6)
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100408)
        end
      elseif id == 8 then
        DialogManager.CreateSingletonDialog("invite.inviteacceptdlg")
        return
      elseif id == 9 then
        local cmd = LuaNetManager.CreateProtocol("protocol.activity.copeninviteshare")
        cmd:Send()
        return
      end
    elseif type == 5 then
      CS.PixelNeko.Tools.ShareHelper.OpenURL(value.record.functionparameter)
    elseif type == 6 then
      if value.canJump then
        local funcParam = tonumber(value.record.functionparameter)
        if funcParam == WelfareType.dreamSpiral then
          local mainLineProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
          if mainLineProgress and mainLineProgress.floor and mainLineProgress.floor > tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(100).Value) then
            local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
            if dialog then
              dialog:SetJumpTab(funcParam)
              dialog:SetData(true)
            end
          else
            NekoData.BehaviorManager.BM_Message:SendMessageById(100347)
          end
        elseif funcParam == WelfareType.qixi then
          local dialog = DialogManager.CreateSingletonDialog("welfare.welfaremaindialog")
          if dialog then
            dialog:SetJumpTab(funcParam)
            dialog:SetData(true)
          end
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100408)
      end
    elseif type == 8 then
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      dialog:OnTypeFourBtnClicked()
    elseif type == DataCommon.GeneralCollectionActFuncType then
      if value.canJump then
        local localTipsKey = "OpenMidAutumnDialog_" .. value.record.eventid
        local activityMidAutumnReRecord = CActivityMidAutumnRe:GetRecorder(value.record.eventid)
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips[localTipsKey]) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", activityMidAutumnReRecord.TimelineId)
          end
        else
          DialogManager.ModifyDialogAsset("activity.midautumn.midautumndialog", activityMidAutumnReRecord.ResourcePath[1], activityMidAutumnReRecord.ResourceName[1])
          DialogManager.ModifyDialogAsset("activity.midautumn.exchangedialog", activityMidAutumnReRecord.ResourcePath[2], activityMidAutumnReRecord.ResourceName[2])
          DialogManager.ModifyDialogAsset("activity.midautumn.midautumnitemcell", activityMidAutumnReRecord.ResourcePath[3], activityMidAutumnReRecord.ResourceName[3])
          local dialog = DialogManager.CreateSingletonDialog("activity.midautumn.midautumndialog")
          dialog:SetRecord(activityMidAutumnReRecord)
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips[localTipsKey])
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100423)
      end
    elseif type == 10 then
      if value.canJump then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenPuzzleDialog) then
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenPuzzleDialog)
        end
        NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):OpenActivityDialog(value.record.eventid)
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100418)
      end
    elseif type == 11 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.HalloweenActivityID):GetIsOpen() then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenHalloweenDialog) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", DataCommon.HalloweenTimeLineId)
          end
        else
          DialogManager.CreateSingletonDialog("activity.halloween.halloweenmaindialog")
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenHalloweenDialog)
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100417)
      end
    elseif type == 12 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DoubleElevenActivityID):GetIsOpen() then
        DialogManager.CreateSingletonDialog("activity.doubleeleven.maindialog")
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100419)
      end
    elseif type == 13 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.BirthDayActivityManagerID):GetIsOpen() then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenBirthDayDialog) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", DataCommon.BirtDayTimeLineId[120001])
          end
        else
          DialogManager.CreateSingletonDialog("activity.birthday.maindialog")
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenBirthDayDialog)
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100423)
      end
    elseif type == 14 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):GetIsOpen() then
        local day = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SpringFestivalActivityManagerID):GetDay()
        local clientbuffer = CS.UnityEngine.PlayerPrefs.GetInt("SpringFestivalDay")
        if not clientbuffer or clientbuffer ~= day then
          CS.UnityEngine.PlayerPrefs.SetInt("SpringFestivalDay", day)
          LuaNotificationCenter.PostNotification(Common.n_RefreshSpringFestivalRedDot)
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            local timelineRecorder = CSfblessingChat:GetRecorder(day)
            if timelineRecorder then
              sceneController._baseMainFSM:SetNumber("storyId", timelineRecorder.timelineID)
            else
              DialogManager.CreateSingletonDialog("activity.springfestival.springfestivalmaindialog")
            end
          end
        else
          DialogManager.CreateSingletonDialog("activity.springfestival.springfestivalmaindialog")
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100423)
      end
    elseif type == 15 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID):GetIsOpen() then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenAprilFoolsDayDialog) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", DataCommon.AprilFoolsDayTimeLineId)
          end
        else
          DialogManager.CreateSingletonDialog("activity.aprilfoolsday.aprilfoolsdaymaindialog")
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenAprilFoolsDayDialog)
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100418)
      end
    elseif type == 16 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChildrenActivityManagerID):GetIsOpen() then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenChildrenDialog) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", DataCommon.ChildrenDayTimeLineId)
          end
        else
          DialogManager.CreateSingletonDialog("activity.children.childrenmaindialog")
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenChildrenDialog)
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100423)
      end
    elseif type == 17 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.DragonBoatFestivalActivityManagerID):GetIsOpen() then
        if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.OpenDragonBoatFestivalDialog) then
          local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
          if sceneController then
            sceneController._baseMainFSM:SetNumber("storyId", DataCommon.DragonBoatFestivalTimeLineId)
          end
        else
          DialogManager.CreateSingletonDialog("activity.dragonboatfestival.maindialog")
          NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.OpenDragonBoatFestivalDialog)
        end
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100419)
      end
    elseif type == 18 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetIsOpen() then
        DialogManager.CreateSingletonDialog("activity.giftoftime.giftoftimemaindialog")
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100419)
      end
    elseif type == 19 then
      if value.canJump and NekoData.BehaviorManager.BM_CommonActivity:GetIsOpen(value.record.eventid) then
        NekoData.BehaviorManager.BM_CommonActivity:OpenActivityDialog(value.record.eventid)
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100489)
      end
    elseif type == 20 then
      if value.canJump and NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo() then
        DialogManager.CreateSingletonDialog("activity.flower.flowerrankdialog")
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100524)
      end
    end
  else
    LogErrorFormat("BM_Activity", "id：%s error.", id)
  end
end

function BM_Activity:IsActivityOpenById(id)
  local value = self._activities.entrance[id] or self._activities.banner[id]
  if value then
    if value.record.bannerfunction == DataCommon.GeneralCollectionActFuncType then
      return value
    else
      return value and value.canJump
    end
  end
end

function BM_Activity:IsActivityOpenByType(type)
  for k, v in pairs(self._activities.entrance) do
    if v.record.bannerfunction == type then
      return true
    end
  end
  for k, v in pairs(self._activities.banner) do
    if v.record.bannerfunction == type then
      return true
    end
  end
end

function BM_Activity:CheckInviteRedDot()
  local b = false
  if self._activities.redDot[9] then
    for _, v in pairs(self._activities.redDot[9]) do
      b = b or v
    end
  end
  return b
end

function BM_Activity:GetInviteRedDot(id)
  local t = self._activities.redDot[9]
  return t and t[id] or false
end

function BM_Activity:GetPuzzleRedDot(actId)
  return NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.PuzzleActivityID):ShowRedDot(actId)
end

function BM_Activity:HaveGetReward()
  local list = self:GetEntrances()
  for _, value in pairs(list) do
    if value.showRedDot then
      return true
    end
  end
end

function BM_Activity:HaveGetRewardById(managerId)
  local manager = self._managers[managerId]
  if manager then
    return manager:ShowRedDot()
  else
    LogErrorFormat("BM_Activity", "managerId(%s) Error.", managerId)
  end
end

function BM_Activity:GetShareActivity(bannerId)
  local value = self._activities.share[bannerId]
  if not value then
    LogErrorFormat("BM_Activity", "bannerId(%s) Error.", bannerId)
  end
  return value
end

function BM_Activity:GetMidAutumnLeftTime()
  local list = self._activities.typeMap[DataCommon.GeneralCollectionActFuncType]
  for _, bannerRecord in ipairs(list) do
    if self:IsActivityOpenById(bannerRecord.id) and self._activities.midAutumnInfo then
      return self._activities.midAutumnInfo.leftTime
    end
  end
  return 0
end

function BM_Activity:GetMidAutumnActivityId()
  local list = self._activities.typeMap[DataCommon.GeneralCollectionActFuncType]
  for _, bannerRecord in ipairs(list) do
    if self:IsActivityOpenById(bannerRecord.id) and self._activities.midAutumnInfo then
      return bannerRecord.eventid
    end
  end
end

function BM_Activity:GetActivityRedPointID()
  return self._redPointActivityID
end

function BM_Activity:GetPopTipsStatusWithActivityId(activityId)
  if self._activities.popTips[activityId] then
    return self._activities.popTips[activityId].status
  end
end

function BM_Activity:GetBackTaskRedPoint()
  return self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask]
end

function BM_Activity:GetBackGiftRedPoint()
  return self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode]
end

function BM_Activity:SetBackTaskRedPoint(flag)
  self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.returnTask] = flag
end

function BM_Activity:SetBackGiftRedPoint(flag)
  self._activities.redDot[NekoData.BehaviorManager.BM_ReturnWelfare.DisplayType.enterInvitedCode] = flag
end

function BM_Activity:GetOtherActivityLeftTimeWithActivityId(activityId)
  if self._activities.others[activityId] then
    return self._activities.others[activityId].leftTime
  else
    LogErrorFormat("BM_Activity", "activity id %s wrong", activityId)
  end
  return 0
end

function BM_Activity:GetWhiteValentine()
  return self._activities.whiteValentine
end

function BM_Activity:GetBannerIdByActivityId(activityId)
  local allIds = CBannerAndEntrance:GetAllIds()
  local len = #allIds
  for i = 1, len do
    local record = CBannerAndEntrance:GetRecorder(allIds[i])
    if record.eventid == activityId then
      return allIds[i]
    end
  end
end

function BM_Activity:GetActivityIdByType(type)
  for k, v in pairs(self._activities.entrance) do
    if v.record.bannerfunction == type then
      return v.record.eventid
    end
  end
  for k, v in pairs(self._activities.banner) do
    if v.record.bannerfunction == type then
      return v.record.eventid
    end
  end
end

function BM_Activity:GetPopUpGift()
  if self._activities.popUpGift.firstOpenActivityId then
    return self._activities.popUpGift
  end
end

function BM_Activity:IsAutoPopUpGift()
  local type = DataCommon.LocalCache.PopUpGiftAutoOpenType
  local value = NekoData.BehaviorManager.BM_Game:GetLocalCache(type)
  local record = self:GetPopUpGiftRecord()
  if not self._activities.popUpGift.data and self._activities.popUpGift.firstOpenActivityId then
    if value == type.Default then
      return type.First
    end
  elseif self._activities.popUpGift.data and record then
    local leftTime = self._activities.popUpGift.data.leftTime
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

function BM_Activity:GetPopUpGiftRecord()
  if self._activities.popUpGift.firstOpenActivityId then
    local allIds = CPopUpGift:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local tmpRecord = CPopUpGift:GetRecorder(allIds[i])
      if tmpRecord.activityID == self._activities.popUpGift.firstOpenActivityId then
        return tmpRecord
      end
    end
    LogErrorFormat("BM_Activity", "Can not find record by activityId: %s in cpopupgift", self._activities.popUpGift.firstOpenActivityId)
  end
end

function BM_Activity:GetPopUpGift7Day()
  return clone(self._activities.popUpGift7Day)
end

function BM_Activity:IsAutoPopUpGift7Day()
  if self._activities.popUpGift7Day and self._activities.popUpGift7Day.pop == 1 then
    local type = DataCommon.LocalCache.PopUpGift7DayAutoOpenType
    local value = NekoData.BehaviorManager.BM_Game:GetLocalCache(type)
    if value == type.Default then
      return type.First
    elseif value == type.First then
      return type.Second
    elseif value == type.Second then
      return type.Third
    end
  end
end

function BM_Activity:ShowPopUpGift7DayRedDot()
  if self._activities.popUpGift7Day then
    for k, v in pairs(self._activities.popUpGift7Day.rewards) do
      if v == CommonAwardStatus.UNLOCKED then
        return true
      end
    end
  end
end

function BM_Activity:GetPopUpGift7DayActivityId()
  if self._activities.popUpGift7Day then
    for k, v in pairs(self._activities.popUpGift7Day.rewards) do
      local record = C7DaySPopUpGift:GetRecorder(k)
      if record then
        return record.activityID
      else
        LogErrorFormat("BM_Activity", "Can not find record by activityId: %s in c7dayspopupgift", k)
      end
    end
  end
end

function BM_Activity:GetPopUpGift7DayTotalDuration()
  if self._activities.popUpGift7Day then
    local activityId = self:GetPopUpGift7DayActivityId()
    local record = CTimedActivitySwitch:GetRecorder(activityId)
    local openTime = os.time(self:GetDateMap(record.openTime))
    local closeTime = os.time(self:GetDateMap(record.closeTime))
    if openTime < closeTime then
      return (closeTime - openTime) * 1000
    end
  end
  return 0
end

function BM_Activity:GetDateMap(str)
  local strList1 = string.split(str, " ")
  local dateList = string.split(strList1[1], "-")
  local timeList = string.split(strList1[2], ":")
  return {
    year = dateList[1],
    month = dateList[2],
    day = dateList[3],
    hour = timeList[1],
    min = timeList[2],
    sec = timeList[3]
  }
end

function BM_Activity:GetDailySupplyDataByActivityId(activityId)
  local data = self._activities.dailySupplyMap[activityId]
  if not data then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(sactivitydailysupply) by activityId(%s)", activityId)
  else
    local list = {}
    for k, v in pairs(data) do
      table.insert(list, {id = k, status = v})
    end
    return list
  end
end

function BM_Activity:ShowDailySupplyRedDotByActivityId(activityId)
  local data = self._activities.dailySupplyMap[activityId]
  if not data then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(sactivitydailysupply) by activityId(%s)", activityId)
  else
    for k, v in pairs(data) do
      if v == SActivityDailySupply.UNLOCKED then
        return true
      end
    end
  end
end

function BM_Activity:GetAccumulateRewardListByActivityId(activityId)
  if not self._activities.accumulateRewardMap[activityId] then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(SGetPointsCollection) by activityId(%s)", activityId)
    return
  else
    return self._activities.accumulateRewardMap[activityId].accumulateRewardList
  end
end

function BM_Activity:GetAccumulatePointsByActivityId(activityId, itemId)
  if not self._activities.accumulateRewardMap[activityId] then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(srefreshpointstasks) by activityId(%s)", activityId)
    return
  else
    return self._activities.accumulateRewardMap[activityId].accumulatePoints[itemId] or 0
  end
end

function BM_Activity:ShowAccumulateRedDot(activityId)
  local tmp = self._activities.accumulateRewardMap[activityId]
  if not tmp then
    LogErrorFormat("BM_Activity", "No data is sent in the server protocol(SGetPointsCollection) by activityId(%s)", activityId)
    return
  end
  for i, v in ipairs(self._activities.accumulateRewardMap[activityId].accumulateRewardList) do
    if v.status == 1 then
      return true
    end
  end
end

function BM_Activity:JudgeActivityType(activityId, type)
  return string.sub(activityId, 1, 3) == type
end

function BM_Activity:GetFlowerActInfo()
  return self._activities.floweract
end

return BM_Activity
