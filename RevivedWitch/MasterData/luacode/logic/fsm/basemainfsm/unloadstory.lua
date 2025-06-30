-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/unloadstory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local dialog = nil
local State = {}
local storyId = 0
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, dialog
  LogInfo("BaseMainFSM", "UnLoad Enter")
  dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
end

State.Update = function(controller)
  -- function num : 0_1 , upvalues : dialog, _ENV, storyId
  if dialog:IsCover() then
    controller:SetBaseCharActive(true)
    ;
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(controller._timeline)
    controller._timeline = nil
    local sceneUICamera = (controller._sceneRef):GetSceneUICamera()
    if sceneUICamera then
      sceneUICamera:SetActive(true)
    end
    local uiDialog = (DialogManager.GetDialog)("base.basemainui")
    if uiDialog then
      (uiDialog:GetRootWindow()):SetActive(true)
      uiDialog:Show()
    end
    uiDialog = (DialogManager.GetDialog)("base.basemainmenudialog")
    if uiDialog then
      (uiDialog:GetRootWindow()):SetActive(true)
    end
    uiDialog = (DialogManager.GetDialog)("base.baseinteractdialog")
    if uiDialog then
      (uiDialog:GetRootWindow()):SetActive(true)
    end
    storyId = (controller._baseMainFSM):GetParameter("storyId")
    if storyId == DataCommon.ReturnWelfarePopTips then
      (DialogManager.CreateSingletonDialog)("welfare.returnwelfare.returnwelfareactivitymaildialog")
    end
    ;
    (controller._baseMainFSM):SetNumber("storyId", 0)
  end
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, storyId, dialog, State
  (LuaAudioManager.PlayBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
  LogInfo("BaseMainFSM", "UnLoad Exit")
  if storyId ~= 0 then
    dialog = (DialogManager.CreateSingletonDialog)("storyloadingdialog")
  end
  LogInfoFormat("Unloadstory", "--- storyId = %s ---", storyId)
  if storyId == 2003 or storyId == 2004 or storyId == 2005 or storyId == 2006 then
    (LuaNotificationCenter.PostNotification)(Common.n_GuideStoryEnd, State, storyId)
  end
  do
    if (DataCommon.MidAutumnTimeLines)[storyId] then
      local key = "OpenMidAutumnDialog_" .. (DataCommon.MidAutumnTimeLines)[storyId]
      ;
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips)[key])
      ;
      ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(((NekoData.BehaviorManager).BM_Activity):GetBannerIdByActivityId((DataCommon.MidAutumnTimeLines)[storyId]))
    end
    if storyId == DataCommon.HalloweenTimeLineId then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenHalloweenDialog)
      ;
      ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(41)
    end
    if storyId == DataCommon.AprilFoolsDayTimeLineId then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenAprilFoolsDayDialog)
      ;
      ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(85)
    end
    if storyId == DataCommon.ChildrenDayTimeLineId then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenChildrenDialog)
      ;
      ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(100)
    end
    if storyId == (DataCommon.BirtDayTimeLineId)[120001] then
      ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenBirthDayDialog)
      ;
      ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(56)
    else
      if (table.contain)(DataCommon.BirtDayTimeLineId, storyId) then
        local birthdayDialogName = "activity.birthday.maindialog"
        ;
        (DialogManager.DestroySingletonDialog)(birthdayDialogName)
        local birthdayDialog = (DialogManager.CreateSingletonDialog)(birthdayDialogName)
        if birthdayDialog then
          birthdayDialog:ToTaskDetail(storyId)
        end
      end
    end
    do
      local christmasCallNPCTalkTimeLineIDs = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):GetNPCTalkTimeLineIDs()
      local springFestivalCallNPCTalkTimeLineIDs = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetNPCTalkTimeLineIDs()
      if storyId == 2013 then
        (DialogManager.CreateSingletonDialog)("activity.swimsuit.entrymaindialog")
      else
        if storyId == DataCommon.ChristmasTimeLineId or storyId == DataCommon.ChristmasCallTimeLineId then
          ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).ChristmasCallActivityUnlock)
          ;
          (DialogManager.CreateSingletonDialog)("activity.chrismascall.maindialog")
        else
          if (table.contain)(christmasCallNPCTalkTimeLineIDs, storyId) then
            local chrismasCallDialogName = "activity.chrismascall.maindialog"
            local chrismasCallDialog = (DialogManager.GetDialog)(chrismasCallDialogName)
            if not chrismasCallDialog then
              chrismasCallDialog = (DialogManager.CreateSingletonDialog)(chrismasCallDialogName)
            end
            if chrismasCallDialog then
              chrismasCallDialog:ToProgressDialog()
            end
          else
            do
              if (table.contain)(springFestivalCallNPCTalkTimeLineIDs, storyId) then
                (DialogManager.CreateSingletonDialog)("activity.springfestival.springfestivalmaindialog")
              end
              if storyId == DataCommon.DragonBoatFestivalTimeLineId then
                ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).OpenDragonBoatFestivalDialog)
                ;
                ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(104)
              end
              if storyId == DataCommon.SummerEchoesTimeLineId then
                (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.entrymaindialog")
              end
              if storyId == DataCommon.StarMirageCopyTimeLineId then
                ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).StarMirageCopy)
                ;
                ((NekoData.BehaviorManager).BM_Activity):EnterActivityById(157)
              end
              storyId = 0
            end
          end
        end
      end
    end
  end
end

return State

