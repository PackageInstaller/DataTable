local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local m_misc = PB.index("Misc", 1)
local m_TaskCategoryCount = TU.TaskCategoryCount
local m_taskLists, m_mode, m_ownActivePoint, m_allActivePointRewardRef
local m_specialActivity = false
local m_specialIndex, m_specialIconOpen, m_specialIconClose, m_specialIconEffect, m_specialhomework
local m_finishedTaskCount = 0
local m_rewardTaskCount = 0
local m_rewards = {}
local m_classifiedTasks = _ENV["!"]({})
local m_selectedMainTasks
local m_currentMainTab = 1

function SetupWindow()
  REF.ScrollView.gameObject:SetActive(false)
  REF.MainTaskNode.gameObject:SetActive(false)
  REF.ActivePointProgress.gameObject:SetActive(false)
  LU.Bind(REF.WrapContent, {
    updateRow = OnTaskItemShow
  })
  LU.Bind(REF.WrapContentMainTask, {
    updateRow = OnMainTaskItemShow
  })
  WU.TraverseChildren(REF.ActivePointRewards, function(g)
    WU.BindButtonEvent(_ENV["$"](g)["$"], OnActivePointRewardClick)
  end)
  WU.TraverseChildren(REF.WeekRewards, function(g)
    WU.BindButtonEvent(_ENV["$"](g)["$"], OnWeekDoneCountRewardClick)
  end)
  for i = 1, m_TaskCategoryCount do
    local tab = _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. i]
    tab["$SetTab"](WU.GetString("Window_Task" .. (PB.enum.TaskCategory.__keys[i] or "")), "Lobby", "mission/mission_icon_" .. i, false)
    tab["$SetClickCallback"](function()
      SwitchTaskCategory(i)
    end)
  end
  WU.TraverseChildren(REF.MainTaskTabGrid, function(go, index)
    WU.BindButtonEvent(_ENV["$"](go).root, function()
      OnSwitchMainTaskTab(index + 1)
    end)
  end)
  CS.EventDelegate.Add(_ENV["$"](REF.TabGrid)["WidgetTabSlot" .. PB.enum.TaskCategory.Week].UIToggle.onChange, function()
    if not CS.UIToggle.current.value and m_taskLists ~= nil then
      local weekList = m_taskLists[PB.enum.TaskCategory.Week]
      if weekList ~= nil then
        TU.ClearNewFlag(weekList)
      end
    end
  end)
  WU.BindButtonEvent(REF.ButtonWeekReplace, function()
    local weekList = m_taskLists[PB.enum.TaskCategory.Week]
    if weekList ~= nil then
      local list = _ENV["!"](weekList):where(function(k, v)
        return not v.rewardGot and v.id > 0
      end)
      if list:count() > 0 then
        WU.AcquireWindowAsync("TaskWeekReplace")
      else
        WU.ShowHintText(WU.GetString("Window_NoWeekTask"))
      end
    end
  end)
  WU.BindButtonEvent(REF.ButtonWeekHelp, function()
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_TaskWeek"))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonGetAllRewards, OnGetAllRewardsClick)
end

function InitWindow()
  m_currentMainTab = 1
  m_specialhomework = {}
  REF.ScrollView.gameObject:SetActive(false)
  REF.ActivePointProgress.gameObject:SetActive(false)
  local activeCategories
  this:Bind("task/activeCategories", function(categories)
    activeCategories = categories
    for category = 1, m_TaskCategoryCount do
      _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. category].gameObject:SetActive(_ENV["!"](categories):has(category))
    end
    REF.TabGrid.UIGrid:Reposition()
    if m_mode ~= nil and not _ENV["!"](categories):has(m_mode) then
      SwitchTaskCategory(categories[1])
    end
  end)
  local toCategory
  for index = 0, #REF.TabGrid - 1 do
    local name = REF.TabGrid[index]["$gameObject"].name
    local realCategory = string.sub(name, -1)
    if realCategory then
      realCategory = tonumber(realCategory)
      if _ENV["!"](activeCategories):has(realCategory) then
        toCategory = realCategory
        break
      end
    end
  end
  this:Bind("fci/task/", OnCategorizedTasksChange)
  this:Bind("fci/task/activepoint/", OnActivePointListChange)
  this:Bind("task/taskWeekInfo", OnWeekInfoChange)
  this:Bind("ActivityList", OnActivityChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  for category = 1, m_TaskCategoryCount do
    RU.BindRedMark(this, "Task/" .. category, function(flag)
      _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. category]["$SetNew"](flag)
    end)
  end
  SwitchTaskCategory(toCategory)
end

function Goto(category)
  category = math.floor(tonumber(category))
  SwitchTaskCategory(category)
end

function OnCategorizedTasksChange(list)
  m_taskLists = list
  TU.CheckTaskReward(m_taskLists)
  SetListView()
end

function SetListView()
  if m_mode == nil or m_taskLists == nil then
    return
  end
  REF.ScrollView.gameObject:SetActive(true)
  local list = m_taskLists[m_mode]
  if list == nil then
    list = {}
  end
  WU.SetActive(REF.MainTaskNode, m_mode == PB.enum.TaskCategory.Main and 0 < #list)
  WU.SetActive(REF.DragBG, m_mode ~= PB.enum.TaskCategory.Main)
  if m_mode == PB.enum.TaskCategory.Main and 0 < #list then
    m_classifiedTasks = _ENV["!"]({})
    for _, v in pairs(list) do
      local taskinfo = PB.get("TaskInfo", v.id)
      local mainCategory = taskinfo.categoryInMainTask
      if m_classifiedTasks[mainCategory] == nil then
        m_classifiedTasks[mainCategory] = {}
      end
      table.insert(m_classifiedTasks[mainCategory], v)
    end
    for _, v in pairs(m_classifiedTasks) do
      table.sort(v, MainTaskSort)
    end
    for i = 0, #REF.MainTaskTabGrid - 1 do
      local ref = REF.MainTaskTabGrid[i]
      WU.SetActive(ref.root, m_classifiedTasks[i + 1] ~= nil)
      if m_classifiedTasks[i + 1] ~= nil then
        ref.TaskLabel.UILabel.text = WU.GetString("MainTaskTag" .. i + 1)
        local canReward = TU.TaskCanReward(m_classifiedTasks[i + 1])
        WU.SetActive(ref.SpriteRed, canReward)
      end
    end
    REF.MainTaskTabGrid.UIGrid:Reposition()
    OnSwitchMainTaskTab(m_currentMainTab)
  elseif m_mode ~= PB.enum.TaskCategory.Main then
    LU.Set(REF.WrapContent, #list)
  end
  REF.TaskEmpty.gameObject:SetActive(#list == 0)
end

function SwitchTaskCategory(mode)
  WU.RecordButtonClick(1001330 .. mode .. 0)
  if m_taskLists == nil or mode == m_mode then
    return
  end
  m_mode = mode
  SetListView()
  REF.ActivePointProgress.gameObject:SetActive(mode == PB.enum.TaskCategory.Routine)
  REF.ButtonGetAllRewards.gameObject:SetActive(mode == PB.enum.TaskCategory.Routine)
  _ENV["$"](REF.ButtonGetAllRewards).Label.UILabel.text = WU.GetString("Window_GetAllRewards")
  REF.WeekInfo.gameObject:SetActive(mode == PB.enum.TaskCategory.Week)
  _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. mode].UIToggle.value = true
  if mode == PB.enum.TaskCategory.Deadline then
    RU.SetRedMark("Task/" .. mode .. "/New", false)
    TU.TaskSetNew(mode, m_taskLists[mode])
  elseif mode == PB.enum.TaskCategory.Week then
    RU.SetRedMark("Task/" .. mode .. "/New", false)
    TU.TaskSetNew(mode, m_taskLists[mode])
  end
  REF.WrapContent.UIPlayTween:Play(true)
  CheckWeekTaskRefreshed()
end

function OnActivePointListChange(activePointList)
  if activePointList == nil then
    return
  end
  m_ownActivePoint = activePointList.activePoint
  m_allActivePointRewardRef = {}
  REF.ActivePointProgress.gameObject:SetActive(m_mode == PB.enum.TaskCategory.Routine)
  REF.ActivePointProgress.UIProgressBar.value = m_ownActivePoint / activePointList.progress[#activePointList.progress].targetActivePoint
  local taskActivePointReward = PB.all("TaskActivePointReward")
  for i = 1, #REF.ActivePointRewards do
    SetActivePointView(REF.ActivePointRewards[i - 1], activePointList.progress[i], i, taskActivePointReward[i].targetActivePoint)
  end
  RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Routine .. "/ActivePoint", TU.ActivePointCanReward(activePointList))
end

function OnWeekInfoChange(weekInfo)
  if weekInfo == nil then
    return
  end
  m_allActivePointRewardRef = {}
  REF.WeekInfo.gameObject:SetActive(m_mode == PB.enum.TaskCategory.Week)
  local rewards = m_misc.taskWeekStepReward
  REF.WeekProgress.UIProgressBar.value = weekInfo.taskDoneCount / rewards[#rewards].step
  for i = 1, #REF.WeekRewards do
    SetWeekDoneCountView(i, weekInfo)
  end
  RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Week .. "/WeekDoneCountReward", TU.WeekDoneCountCanReward())
  local replaced = weekInfo.refershCountToday >= m_misc.taskWeekRefreshMaxCountPerDay
  WU.SetActive(REF.AlreadyReplaced, replaced)
  WU.SetActive(REF.ButtonWeekReplace, not replaced)
end

function OnWeeklyActivePointChange(weeklyInfo)
  if weeklyInfo == nil then
    return
  end
  local hasWeeklyReward = TU.WeeklyActivePointCanReward(weeklyInfo)
  WU.SetActive(REF.WeeklyRewardEffect, hasWeeklyReward)
end

function OnTaskItemShow(goRef, wrapIndex, realIndex)
  local taskList = m_taskLists[m_mode]
  if taskList and realIndex < #taskList then
    local taskInfo = taskList[realIndex + 1]
    goRef["$$SetView"](taskInfo)
  end
end

function OnMainTaskItemShow(goRef, wrapIndex, realIndex)
  local taskList = m_selectedMainTasks
  if taskList and realIndex < #taskList then
    local taskInfo = taskList[realIndex + 1]
    goRef["$$SetView"](taskInfo)
  end
end

function SetActivePointView(ref, activePointRewardInfo, index, point)
  table.insert(m_allActivePointRewardRef, ref)
  ref["@rewardInfo"] = activePointRewardInfo
  ref["@index"] = index
  local canGetReward = m_ownActivePoint >= activePointRewardInfo.targetActivePoint and not activePointRewardInfo.rewardGot
  if m_specialActivity and m_specialIconEffect and m_specialIconEffect ~= "" then
    ref.Glow.EffectGenerator.m_EffectName = m_specialIconEffect
  else
    ref.Glow.EffectGenerator.m_EffectName = "UI_mission_01"
  end
  ref.Glow.gameObject:SetActive(canGetReward)
  WU.SetActive(ref.Icon, not canGetReward)
  if activePointRewardInfo.rewardGot then
    if m_specialActivity and m_specialIconClose and m_specialIconClose ~= "" then
      ref["$UIButton"].normalSprite = m_specialIconClose
    else
      ref["$UIButton"].normalSprite = "mission/mission_close"
    end
    ref.Icon.UISprite:MakePixelPerfect()
  else
    if m_specialActivity and m_specialIconOpen and m_specialIconOpen ~= "" then
      ref["$UIButton"].normalSprite = m_specialIconOpen
    else
      ref["$UIButton"].normalSprite = "mission/mission_open"
    end
    ref.Icon.UISprite:MakePixelPerfect()
  end
  ref.Label.UILabel.text = point
end

function SetWeekDoneCountView(i, weekInfo)
  local ref = REF.WeekRewards[i - 1]
  local rewardInfo = m_misc.taskWeekStepReward[i]
  local rewardGot = weekInfo.rewardGotRecord[rewardInfo.step]
  local canGetReward = weekInfo.taskDoneCount >= rewardInfo.step and not rewardGot
  ref["@rewardInfo"] = rewardInfo
  ref["@rewardGot"] = rewardGot
  ref["@canGetReward"] = canGetReward
  ref.Glow.EffectGenerator.m_EffectName = "UI_GiftBoxloop"
  ref.Glow.EffectGenerator:Reset()
  ref.Glow.transform.localScale = CS.UnityEngine.Vector3(0.4, 0.4, 1)
  ref.Glow.gameObject:SetActive(canGetReward)
  WU.SetActive(ref.Icon, not canGetReward)
  if rewardGot then
    ref["$UIButton"].normalSprite = "mission/mission_close_2"
  else
    ref["$UIButton"].normalSprite = "mission/mission_open_2"
  end
  ref.Icon.UISprite:MakePixelPerfect()
  ref.Label.UILabel.text = rewardInfo.step
end

function OnWeekDoneCountRewardClick(go)
  local ref = _ENV["$"](go)
  local info = ref["@rewardInfo"]
  if info == nil then
    error("Task", "ref userdata is nil")
    return
  end
  if ref["@canGetReward"] then
    this:GameRequest("fci/task/taskweekreward/"):Post({
      step = info.step
    }, function(result)
      DBH.ResChange(result.resChange)
      local weekInfo = this:GetData("task/taskWeekInfo")
      weekInfo.taskDoneCount = result.taskDoneCount
      weekInfo.rewardGotRecord = result.rewardGotRecord
      this:SetData("task/taskWeekInfo", weekInfo)
      WU.ShowRewards(result.resChange)
      WU.SetActive(ref.Icon, true)
    end)
  else
    local weekInfo = this:GetData("task/taskWeekInfo")
    local content = ""
    local title = WU.GetString("Task_WeekDoneCountRewardTitle")
    local buttonTitle = WU.GetString("WindowGacha_Close")
    if not weekInfo.rewardGotRecord[info.step] then
      content = WU.GetString("Task_WeekDoneCountRewardInfo", weekInfo.taskDoneCount, info.step)
      buttonTitle = nil
    end
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](info.reward, title, content, info.rewardGot, buttonTitle)
    end)
  end
end

function OnActivePointRewardClick(go)
  local ref = _ENV["$"](go)
  local info = ref["@rewardInfo"]
  if info == nil then
    error("Task", "ref userdata is nil")
    return
  end
  local canGetReward = m_ownActivePoint >= info.targetActivePoint and not info.rewardGot
  if canGetReward then
    WU.RecordButtonClick(100133013)
    this:GameRequest("fci/task/activepoint/reward/"):Post({
      targetActivePoint = info.targetActivePoint
    }, function(result)
      DBH.ResChange(result.resChange)
      info.rewardGot = true
      this:SetData("fci/task/activepoint/", this:GetData("fci/task/activepoint/"))
      WU.ShowRewards(result.resChange)
      WU.SetActive(ref.Icon, true)
    end)
  else
    WU.RecordButtonClick(100133014)
    local title
    if info.days ~= nil then
      title = WU.GetString("Window_SigninGiftTitle")
    else
      title = WU.GetString("Window_ActivePointRewardTitle")
    end
    local allRewards = {}
    for k, v in pairs(info.reward) do
      allRewards[k] = v
    end
    AM.GetTimeLimitExtraReward({
      type = 4,
      activePoint = info.targetActivePoint
    }, function(extra)
      for i = 1, #extra do
        table.insert(allRewards, extra[i])
      end
      local content = ""
      local buttonTitle = WU.GetString("WindowGacha_Close")
      if not info.rewardGot then
        content = WU.GetString("TaskActivePointRewardPreview", m_ownActivePoint, info.targetActivePoint or info.days)
        buttonTitle = nil
      end
      WU.AcquireWindowAsync("RewardPreview", function(ui)
        _ENV["$"](ui)["$$SetView"](allRewards, title, content, info.rewardGot, buttonTitle)
      end)
    end)
  end
end

function OnActivityChanged(activityList)
  if activityList == nil then
    return
  end
  local activePointList = this:GetData("fci/task/activepoint/")
  if activePointList == nil then
    return
  end
  local specialActivityId = m_misc.specialActivityId
  for _, activity in pairs(activityList) do
    if activity.type == PB.enum.ActivityType.ExtraReward then
      if specialActivityId == activity.activityId then
        m_specialActivity = ACU.GetStatus(activity) == PB.enum.ActivityStatus.Started
        GetSpecialInfo(specialActivityId)
        OnActivePointListChange(activePointList)
      end
    elseif activity.type == PB.enum.ActivityType.WeekTask then
      OnHomewrokChange({
        activityId = activity.activityId,
        _status = ACU.GetStatus(activity)
      })
    end
  end
end

function OnHomewrokChange(activity)
  local Tabslot = _ENV["$"](REF.TabGrid)["WidgetTabSlot" .. PB.enum.TaskCategory.Week]
  m_specialhomework[activity.activityId] = activity._status == PB.enum.ActivityStatus.Started
  local open = false
  for _, v in pairs(m_specialhomework) do
    if v then
      open = true
    end
  end
  if open then
    _ENV["$"](Tabslot).LabelButton.UIHtmlLabel.text = WU.GetString("Window_TaskWeek" .. activity.activityId)
  else
    _ENV["$"](Tabslot).LabelButton.UIHtmlLabel.text = WU.GetString("Window_Task" .. (PB.enum.TaskCategory.__keys[PB.enum.TaskCategory.Week] or ""))
  end
  Tabslot["$SetActivity"](open)
end

function OnActivityStatusChanged(category, activityId, status, type)
  local activePointList = this:GetData("fci/task/activepoint/")
  if activePointList == nil then
    return
  end
  local specialActivityId = m_misc.specialActivityId
  if type == PB.enum.ActivityType.ExtraReward and specialActivityId == activityId then
    m_specialActivity = status == PB.enum.ActivityStatus.Started
    GetSpecialInfo(specialActivityId)
    OnActivePointListChange(activePointList)
  end
  if type == PB.enum.ActivityType.WeekTask then
    OnHomewrokChange({activityId = activityId, _status = status})
  end
end

function GetSpecialInfo(specialActivityId)
  local specialInfo = PB.get("ActivityExtraRewardRule", specialActivityId)
  if specialInfo then
    m_specialIndex = specialInfo.dropConditionParams[1] / 20
    m_specialIconOpen = specialInfo.specialIconOpen
    m_specialIconClose = specialInfo.specialIconClose
    m_specialIconEffect = specialInfo.specialIconEffect
  else
    error("Task", "ActivityExtraRewardRule\228\184\173\230\178\161\230\156\137id\239\188\154" .. specialActivityId)
  end
end

function CheckWeekTaskRefreshed()
  if m_mode ~= PB.enum.TaskCategory.Week then
    return
  end
  local lastTime = WU.GetGameDataCache("WeekTaskViewTime")
  if lastTime ~= nil then
    local sameWeek = CS.GameTime.IsSameWeek(CS.GameTime.UtcToLocal(lastTime), CS.GameTime.serverNow)
    if not sameWeek then
      WU.ShowHintText(WU.GetString("Task_WeekRefreshedTip"))
    end
  end
  WU.SetGameDataCache("WeekTaskViewTime", CS.GameTime.serverUtc)
end

function OnGetAllRewardsClick()
  if m_mode ~= PB.enum.TaskCategory.Routine then
    return
  end
  local taskList = m_taskLists[m_mode]
  if taskList == nil then
    return
  end
  for i = 1, #taskList do
    local task = taskList[i]
    if task.isDone and not task.rewardGot and not task.timeout then
      m_finishedTaskCount = m_finishedTaskCount + 1
      this:GameRequest("fci/task/" .. task.id .. "/reward/"):Post(nil, function(result)
        DBH.ResChange(result.resChange)
        task.rewardGot = true
        WU.CombineRewards(result, m_rewards)
        m_rewardTaskCount = m_rewardTaskCount + 1
        if m_rewardTaskCount == m_finishedTaskCount then
          WU.ShowRewards(m_rewards, OnGetAllActivePointRewards)
          local counter = 1
          for i = 1, #taskList do
            if taskList[counter].rewardGot == true or taskList[counter].timeout then
              local t = taskList[counter]
              table.remove(taskList, counter)
              table.insert(taskList, t)
            else
              counter = counter + 1
            end
          end
          local points = this:GetData("fci/task/activepoint/")
          points.activePoint = result.activePoint
          this:SetData("fci/task/activepoint/", points)
          this:SetData("fci/task/", this:GetData("fci/task/"))
          m_rewardTaskCount = 0
          m_finishedTaskCount = 0
          m_rewards = {}
        end
      end)
    end
  end
  if m_finishedTaskCount == 0 then
    OnGetAllActivePointRewards(false)
  end
end

function OnGetAllActivePointRewards(second)
  if second == nil then
    second = true
  end
  local activePoint = this:GetData("fci/task/activepoint/")
  if activePoint == nil then
    return
  end
  for i = 1, #activePoint.progress do
    local progress = activePoint.progress[i]
    if not progress.rewardGot and activePoint.activePoint >= progress.targetActivePoint then
      m_finishedTaskCount = m_finishedTaskCount + 1
      this:GameRequest("fci/task/activepoint/reward/"):Post({
        targetActivePoint = progress.targetActivePoint
      }, function(result)
        DBH.ResChange(result.resChange)
        progress.rewardGot = true
        WU.CombineRewards(result, m_rewards)
        m_rewardTaskCount = m_rewardTaskCount + 1
        if m_rewardTaskCount == m_finishedTaskCount then
          this:SetData("fci/task/activepoint/", this:GetData("fci/task/activepoint/"))
          WU.ShowRewards(m_rewards)
          m_rewardTaskCount = 0
          m_finishedTaskCount = 0
          m_rewards = {}
        end
      end)
    end
  end
  if m_finishedTaskCount == 0 and second == false then
    WU.ShowHintText(WU.GetString("Window_GetAllRewardsFailed"))
  end
end

function OnSwitchMainTaskTab(index)
  if index == nil then
    return
  end
  local tasks = m_classifiedTasks[index]
  if tasks == nil then
    local defaultIndex = 100
    local minIndex = 100
    local taskinfo
    for key, value in pairs(m_classifiedTasks) do
      if TU.TaskCanReward(value) and key < defaultIndex then
        defaultIndex = key
      end
      if key < minIndex then
        minIndex = key
      end
    end
    if defaultIndex == 100 then
      defaultIndex = minIndex
    end
    if defaultIndex then
      taskinfo = m_classifiedTasks[defaultIndex]
      WU.ChangeToggleValue(REF.MainTaskTabGrid[m_currentMainTab - 1].root, false)
      m_selectedMainTasks = taskinfo
      m_currentMainTab = defaultIndex
    end
  else
    m_selectedMainTasks = tasks
    m_currentMainTab = index
  end
  REF.MainTaskTabGrid[m_currentMainTab - 1].root.UIToggle.value = true
  LU.Set(REF.WrapContentMainTask, #m_selectedMainTasks)
end

function MainTaskSort(a, b)
  if a.res.goalType == 43 and b.res.goalType == 43 then
    return false
  elseif a.res.goalType == 43 then
    return true
  elseif b.res.goalType == 43 then
    return false
  elseif a.rewardGot ~= b.rewardGot then
    return b.rewardGot
  elseif a.isDone ~= b.isDone then
    return a.isDone
  elseif a.dailyRefresh ~= nil and b.dailyRefresh ~= nil and a.dailyRefresh ~= b.dailyRefresh then
    return a.dailyRefresh
  elseif a.res.taskQuality ~= b.res.taskQuality then
    return a.res.taskQuality > b.res.taskQuality
  elseif a.res.priority ~= b.res.priority then
    return a.res.priority > b.res.priority
  else
    return a.id > b.id
  end
end

function Focus(on)
  WU.RecordWindowFocus(100133, on)
end
