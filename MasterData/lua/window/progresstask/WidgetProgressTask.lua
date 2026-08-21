local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local HU = require("Common/HtmlUtil")
local DU = require("Common/DungeonUtil")
local S = require("Common/Singleton")
local AU = require("Common/ActorUtil")
local m_activityManager = S:Get("ActivityManager")
local Mathf = CS.UnityEngine.Mathf
local m_task, m_totalTaskList
local BoxId = PB.all("Misc"):first().taskPresentRewardBoxId
local intervalTime
local m_index = 0
local m_ptList = {}
local m_actorIdMap = {}
local m_currentInfo
local m_inited = false
local m_actorCul
local m_preLoadData = {
  "fci/actor-cultivation",
  "fci/custom-actor-cultivation/"
}

function Start()
  intervalTime = PB.all("Misc"):first().progressTaskSwitchingTime or 5
  this:RegisterGameEvent("SetViewInfo", SetViewInfo)
  this:RegisterGameEvent("ShowView", ShowView)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChange)
  this:SetData("ProgressTask/PTList", m_ptList)
  this:Bind("ProgressTask/PTList", OnPTListChanged)
  this:Bind("NavigationContext", OnNavigationContext)
  WU.BindButtonEvent(REF.SpriteBgBar, function()
    local list = _ENV["!"](this:GetData("ProgressTask/PTList")):toarray()
    local topWindow = WU.TopWindow()
    this:SetData("NewerPlan/FromWindow", topWindow and topWindow.name)
    this:SetData("ProgressTask/Tab", list[m_index].ptName)
    WU.AcquireWindowAsync("ProgressTask")
  end)
  for k, v in pairs(m_preLoadData) do
    this:Bind(v, InitPT)
  end
  CS.EventDelegate.Add(REF.Close.UIPlayTween.onFinished, closeFinish)
end

local timer = 0

function Update()
  timer = timer + CS.GameTime.deltaTime
  if timer > intervalTime then
    timer = 0
    LoopPlay()
  end
end

function InitPT()
  local ready = true
  for k, v in pairs(m_preLoadData) do
    if this:GetData(v) == nil then
      ready = false
      break
    end
  end
  if ready then
    local configs = PB.all("ProgressTaskConfig")
    for _, config in ipairs(configs) do
      local initFunc = rawget(_ENV, "Init" .. config.name)
      if initFunc then
        local acStatusMap = GetAcStatusMap(config.name)
        initFunc(acStatusMap)
      end
    end
    for k, v in pairs(m_preLoadData) do
      this:Unbind(v, InitPT)
    end
  end
end

function SetViewInfo(ptName, changeInfo)
  if ptName == nil then
    return
  end
  local ptList = this:GetData("ProgressTask/PTList")
  local oldIndex, oldInfo = table.find(ptList, function(k, v)
    return v.ptName == ptName
  end)
  if oldInfo and changeInfo then
    oldInfo.actorId = changeInfo.actorId or oldInfo.actorId
    oldInfo.text = changeInfo.text or oldInfo.text
    oldInfo.canGet = fif(changeInfo.canGet == nil, oldInfo.canGet, changeInfo.canGet)
  end
  if oldInfo and changeInfo == nil then
    table.remove(ptList, oldIndex)
  end
  if oldInfo == nil and changeInfo then
    changeInfo.ptName = ptName
    table.insert(ptList, changeInfo)
  end
  this:SetData("ProgressTask/PTList", ptList)
end

function ShowView(actorId)
  local configs = PB.all("ProgressTaskConfig"):where(function(_, v)
    return Mathf.FloorToInt(tonumber(v.params[1])) == actorId
  end)
  if configs then
    local ptList = this:GetData("ProgressTask/PTList")
    for k, v in pairs(configs) do
      local k3, v3 = table.find(ptList, function(k2, v2)
        return v2.ptName == v.name
      end)
      if k3 then
        timer = 0
        m_index = k3
        SetView(ptList[m_index])
        m_currentInfo = ptList[m_index]
      end
    end
  end
end

function OnPTListChanged(list)
  if list then
    m_ptList = list
    list = _ENV["!"](list):toarray()
    local index, ptInfo = table.find(list, function(k, v)
      return v.canGet
    end)
    if ptInfo then
      m_index = index
      SetView(ptInfo)
      m_currentInfo = ptInfo
      return
    else
      if m_index == 0 or m_index == nil or m_index > table.count(list) then
        m_index = 1
      end
      SetView(list[m_index])
      m_currentInfo = list[m_index]
    end
  end
end

function LoopPlay()
  local list = _ENV["!"](this:GetData("ProgressTask/PTList")):toarray()
  if m_index ~= 0 and m_index ~= nil and list[m_index] and list[m_index].canGet then
    return
  end
  m_index = m_index + 1
  if m_index > table.count(list) then
    m_index = 1
  end
  if m_currentInfo ~= list[m_index] then
    m_currentInfo = list[m_index]
    REF.Close.UIPlayTween:Play(true)
  end
end

function closeFinish()
  SetView(m_currentInfo)
  REF.Open.UIPlayTween:Play(true)
end

function SetView(info)
  if info then
    local actorId = info.actorId
    local hasActor = actorId ~= nil and actorId ~= 0
    WU.SetActive(REF.NodeSakuNormal, not hasActor and not info.canGet)
    WU.SetActive(REF.NodeSakuEffect, not hasActor and info.canGet)
    WU.SetActive(REF.NodeActorNormal, hasActor and not info.canGet)
    WU.SetActive(REF.NodeActorEffect, hasActor and info.canGet)
    WU.SetActive(REF.Holder, true)
    local kind
    if hasActor then
      kind = PB.get("ActorConfig", actorId).kind
      if kind == 1 then
        REF.TextureActorHeadMain.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/main/infight_head_%sa", actorId)
      elseif kind == 2 then
        REF.TextureActorHeadSub.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/sub/infight_head_%sa", actorId)
      end
    end
    WU.SetActive(REF.TextureActorHeadMain, kind == 1)
    WU.SetActive(REF.TextureActorHeadSub, kind == 2)
    REF.LabelDesc.UILabel.text = info.text
    if REF.SpriteBgBar then
      REF.SpriteBgBar.UISprite.width = REF.LabelDesc.UILabel.width + 90
      if REF.NodeSakuEffect.gameObject.activeSelf then
        local maskControl = _ENV["$"](REF.NodeSakuEffect).MaskControl
        local scale = maskControl.transform.localScale
        scale.x = REF.SpriteBgBar.UISprite.width / 542
        maskControl.transform.localScale = scale
      end
      if REF.NodeActorEffect.gameObject.activeSelf then
        local maskControl = _ENV["$"](REF.NodeActorEffect).MaskControl
        local scale = maskControl.transform.localScale
        scale.x = REF.SpriteBgBar.UISprite.width / 542
        maskControl.transform.localScale = scale
      end
    end
  else
    WU.SetActive(REF.Holder, false)
  end
  local active = info ~= nil
  local winCity = WU.FindWindow("City")
  if winCity then
    local p = _ENV["$"](winCity).ActivityGrid.transform.localPosition
    p.y = fif(active, 325, 250)
    _ENV["$"](winCity).ActivityGrid.transform.localPosition = p
    _ENV["$"](winCity).ActivityGrid.UIGrid:Reposition()
    p = _ENV["$"](winCity).BoardSpeechText.transform.localPosition
    p.y = fif(active, -371, -481)
    _ENV["$"](winCity).BoardSpeechText.transform.localPosition = p
  end
end

function GetAcStatusMap(ptName)
  local configs = PB.get("ProgressTaskConfig", ptName)
  local acStatusMap = {}
  if configs then
    acStatusMap = _ENV["!"](m_activityManager.GetActivitiesStatus(configs.relatedActivityType))
    if #configs.relatedActivityIds > 0 then
      acStatusMap = _ENV["!"](acStatusMap):where(function(k, v)
        return table.has(configs.relatedActivityIds, k)
      end)
    end
  end
  return acStatusMap
end

function OnActivityStatusChange(category, id, status, type)
  local relatedConfigs = PB.all("ProgressTaskConfig"):where(function(_, v)
    return v.relatedActivityType == type
  end)
  for _, config in pairs(relatedConfigs) do
    local acChangeFunc = rawget(_ENV, "OnAcChange" .. config.name)
    local acStatusMap = GetAcStatusMap(config.name)
    if acChangeFunc then
      acChangeFunc(acStatusMap)
    end
  end
end

function OnNavigationContext(winName)
  if winName == "City" then
    REF.Open.UIPlayTween:Play(true)
  end
end

local m_TaskPresentName = "TaskPresent"
local m_ptChangeInfo = {
  ptName = "TaskPresent"
}
local m_task, m_totalTaskList
local m_dungeonId = 6

function InitTaskPresent()
  m_totalTaskList = PB.all("TaskInfo"):where(function(k, v)
    return v.category == PB.enum.TaskCategory.Present
  end):toarray():sort(function(a, b)
    return a.priority > b.priority
  end)
  this:Bind("fci/presentTasks", OnPresentTaskChanged)
  this:Bind("fci/dungeon/chapter/1", ToggleRendering)
  this:Bind("taskPresentTargetActor", function(id)
    if IsOpenForTaskPresent() then
      SetViewInfo(m_TaskPresentName, {actorId = id})
    end
  end)
  this:Bind("fci/item/" .. BoxId, ToggleRendering)
end

function OnPresentTaskChanged(tasks)
  m_task = GetCurrentTask(tasks)
  this:SetData("fci/currentPresentTask", m_task)
  ToggleRendering()
  local lastTaskRes = m_totalTaskList:last()
  if m_task then
    if this:GetData("taskPresentTargetActor") == nil then
      this:GameRequest("fci/present-target-actor"):Get(function(resp)
        this:SetData("taskPresentTargetActor", resp.presentTargetActor)
      end)
    end
    if m_task.id == lastTaskRes.id and m_task.isDone then
      m_ptChangeInfo.text = WU.GetString("WindowTaskPrsent_RewardRemind")
    else
      m_ptChangeInfo.text = WU.GetString("TaskDesc_" .. m_task.res.id, m_task.res.maxProgress, TU.GetParamLocalizationText(m_task.res.taskParam, m_task.res.goalType)) .. string.format(" (%s/%s)", m_task.progress, m_task.res.maxProgress)
    end
    local index = table.find(m_totalTaskList, function(k, v)
      return v.id == m_task.id
    end)
    m_ptChangeInfo.canGet = m_task.isDone and not m_task.rewardGot
    RU.SetRedMark("ProgressTask/TaskPresent", m_ptChangeInfo.canGet)
    if IsOpenForTaskPresent() then
      SetViewInfo(m_TaskPresentName, m_ptChangeInfo)
    else
      SetViewInfo(m_TaskPresentName, nil)
    end
  elseif this:GetData("fci/item/" .. BoxId).count > 0 then
    if this:GetData("taskPresentTargetActor") == nil then
      this:GameRequest("fci/present-target-actor"):Get(function(resp)
        this:SetData("taskPresentTargetActor", resp.presentTargetActor)
      end)
    end
    SetViewInfo(m_TaskPresentName, nil)
  end
end

function GetCurrentTask(taskList)
  if taskList then
    local tasks = {}
    table.copy(taskList, tasks, true)
    local unReward = _ENV["!"](tasks):where(function(k, v)
      return not v.rewardGot
    end):toarray()
    unReward:sort(function(a, b)
      return a.res.priority > b.res.priority
    end)
    return unReward:first()
  end
end

function IsOpenForTaskPresent()
  local taskInfo = this:GetData("fci/currentPresentTask")
  local boxCount = this:GetData("fci/item/" .. BoxId).count
  local isFinished = false
  local unlockDungeonId = PB.all("Misc"):first().ptTaskPresent
  DU.IsDungeonFinished(this:GetData("fci/dungeon/chapter-summary"), unlockDungeonId, function(finished)
    isFinished = finished
  end)
  return isFinished and taskInfo ~= nil
end

function ToggleRendering()
  local active = IsOpenForTaskPresent()
  local ptChangeInfo = {}
  local taskInfo = this:GetData("fci/currentPresentTask")
  if active then
    SetViewInfo(m_TaskPresentName, m_ptChangeInfo)
  else
    SetViewInfo(m_TaskPresentName, nil)
  end
end

function CommonInitActorCultivation(acStatusMap, ptName)
  this:Bind("fci/actorCultivationTasks", function(tasks)
    local config = PB.get("ProgressTaskConfig", ptName)
    local actorId = Mathf.FloorToInt(tonumber(config.params[1]))
    local relatedActivityId = config.relatedActivityIds[1]
    local actorCuls = this:GetData("fci/actor-cultivation")
    SetViewInfo(ptName, nil)
    if actorCuls and IsActorCultivationOpen(acStatusMap, actorId, actorCuls) then
      local _, actorCul = table.find(actorCuls, function(k, v)
        return relatedActivityId == v.activityId
      end)
      local nextProgress = NextProgress(actorCul)
      local rewardAll = RewardAll(actorCul)
      if rewardAll and actorCul.vip then
        SetViewInfo(ptName, nil)
      else
        local text = ""
        local currentTasks = {}
        if tasks ~= nil then
          currentTasks = table.where(tasks, function(k, v)
            return v.actorCultivationActivityId == relatedActivityId
          end):toarray()
        end
        local canGet = TaskRewardCanGet(currentTasks, actorCul) or ProgressRewardCanGet(actorCul)
        if actorCul.progress < 100 then
          if not canGet then
            text = WU.GetString("ProgressTask_Progress1", actorCul.progress, nextProgress)
          else
            text = WU.GetString("ProgressTask_Progress2", actorCul.progress, nextProgress)
          end
        elseif actorCul.progress == 100 and not rewardAll then
          text = WU.GetString("ProgressTask_Progress3", actorCul.progress, nextProgress)
        elseif actorCul.progress == 100 and rewardAll then
          actorId = nil
          text = WU.GetString("ProgressTask_Progress4", actorCul.progress, nextProgress)
        end
        SetViewInfo(ptName, {
          actorId = actorId,
          text = text,
          canGet = fif(rewardAll, false, canGet)
        })
      end
    end
  end)
end

function RewardAll(actorCul)
  local normalRewardProgress = actorCul.progressReward
  local vipRewardProgress = actorCul.progressRewardVip
  local vip = actorCul.vip
  local rewardProgress
  if vip then
    if normalRewardProgress == 100 then
      rewardProgress = 100
    else
      rewardProgress = fif(normalRewardProgress < vipRewardProgress, normalRewardProgress, vipRewardProgress)
    end
  else
    rewardProgress = normalRewardProgress
  end
  return rewardProgress == 100
end

function NextProgress(actorCul)
  local nextProgress = 100
  for _, v in pairs(PB.all("ActorCultivationProgressReward")) do
    if v.activityId == actorCul.activityId and v.progress > actorCul.progress then
      nextProgress = v.progress
      break
    end
  end
  return nextProgress
end

function TaskRewardCanGet(tasks, actorCul)
  local canGet = false
  if tasks then
    for k, v in pairs(tasks) do
      canGet = v.isDone and not v.rewardGot and not v.timeout and fif(v.actorCultivationVipOnly, actorCul.vip, true)
      if canGet then
        break
      end
    end
  end
  return canGet
end

function ProgressRewardCanGet(actorCul)
  local progress = actorCul.progress
  local normalRewardProgress = actorCul.progressReward
  local vipRewardProgress = actorCul.progressRewardVip
  local m_IsVip = actorCul.vip
  local rewardProgress
  if m_IsVip then
    if normalRewardProgress == 100 then
      rewardProgress = 100
    else
      rewardProgress = fif(normalRewardProgress < vipRewardProgress, normalRewardProgress, vipRewardProgress)
    end
  else
    rewardProgress = normalRewardProgress
  end
  if progress == 100 and rewardProgress == 99 then
    return true
  end
  if rewardProgress ~= 100 then
    local rewardsToGet
    if normalRewardProgress ~= vipRewardProgress and m_IsVip then
      local nextProgress = fif(normalRewardProgress > vipRewardProgress, normalRewardProgress, vipRewardProgress)
      rewardsToGet = PB.get("ActorCultivationProgressReward", actorCul.activityId, nextProgress)
    else
      local progressRewards = PB.all("ActorCultivationProgressReward")
      for _, v in pairs(progressRewards) do
        if v.activityId == actorCul.activityId and rewardProgress < v.progress then
          rewardsToGet = v
          break
        end
      end
    end
    if rewardsToGet and rewardsToGet.progress ~= 100 then
      local reward = rewardsToGet.reward[1]
      local vipReward = rewardsToGet.rewardVip[1]
      if progress >= rewardsToGet.progress and (normalRewardProgress < rewardsToGet.progress or m_IsVip and vipRewardProgress < rewardsToGet.progress) then
        return true
      end
    end
  end
  return false
end

function CommonOnAcChangeActorCultivation(acStatusMap, ptName)
  CommonInitActorCultivation(acStatusMap, ptName)
end

function IsActorCultivationOpen(acStatusMap, actorId, actorCuls)
  local activityIsOpen = table.has(acStatusMap, PB.enum.ActivityStatus.Started)
  local ownActor = false
  for _, v in pairs(actorCuls) do
    if v.actorId == actorId then
      ownActor = true
      break
    end
  end
  ownActor = ownActor and AU.GetActorListById(actorId)
  return activityIsOpen and ownActor
end

function InitActorCultivation1(acStatusMap)
  OnAcChangeActorCultivation1(acStatusMap)
end

function OnAcChangeActorCultivation1(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation1")
end

function InitActorCultivation2(acStatusMap)
  OnAcChangeActorCultivation2(acStatusMap)
end

function OnAcChangeActorCultivation2(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation2")
end

function InitActorCultivation3(acStatusMap)
  OnAcChangeActorCultivation3(acStatusMap)
end

function OnAcChangeActorCultivation3(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation3")
end

function InitActorCultivation4(acStatusMap)
  OnAcChangeActorCultivation4(acStatusMap)
end

function OnAcChangeActorCultivation4(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation4")
end

function InitActorCultivation5(acStatusMap)
  OnAcChangeActorCultivation5(acStatusMap)
end

function OnAcChangeActorCultivation5(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation5")
end

function InitActorCultivation6(acStatusMap)
  OnAcChangeActorCultivation6(acStatusMap)
end

function OnAcChangeActorCultivation6(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation6")
end

function InitActorCultivation7(acStatusMap)
  OnAcChangeActorCultivation7(acStatusMap)
end

function OnAcChangeActorCultivation7(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation7")
end

function InitActorCultivation8(acStatusMap)
  OnAcChangeActorCultivation8(acStatusMap)
end

function OnAcChangeActorCultivation8(acStatusMap)
  CommonOnAcChangeActorCultivation(acStatusMap, "ActorCultivation8")
end

function IsCustomActorCultivationOpen(acIndex, acStatusMap)
  local acCnt = table.count(table.where(acStatusMap, function(k, v)
    return v == PB.enum.ActivityStatus.Started
  end):toarray())
  local culInfo = this:GetData("fci/custom-actor-cultivation/")
  local culPlans = culInfo and culInfo.culPlans
  local curCulPlan = culPlans and culPlans[acIndex]
  local time = CS.GameTime.serverUtc
  local open = acCnt > acIndex - 1 or curCulPlan and curCulPlan.started and time >= curCulPlan.startTime and time < curCulPlan.endTime
  return open
end

function CommonInitCustomActorCultivation(acStatusMap, index, ptName)
  local config = PB.get("ProgressTaskConfig", ptName)
  local relatedActivityId = config.relatedActivityIds[1]
  this:Bind("fci/customActorCultivationTasks", function(tasks)
    local cusActorCuls = this:GetData("fci/custom-actor-cultivation/")
    if IsCustomActorCultivationOpen(index, acStatusMap) then
      local actorCul = cusActorCuls.culPlans[index]
      if actorCul then
        if actorCul.started then
          local rewardAll = RewardAll(actorCul)
          if rewardAll and actorCul.vip then
            SetViewInfo(ptName, nil)
          else
            local currentTasks
            if tasks ~= nil then
              currentTasks = table.where(tasks, function(k, v)
                return v.actorCultivationActivityId == relatedActivityId
              end):toarray()
            end
            local nextProgress = 3
            for _, v in pairs(PB.all("ActorCultivationProgressReward")) do
              if v.activityId == relatedActivityId and v.progress > actorCul.progress then
                nextProgress = v.progress
                break
              end
            end
            local text = fif(actorCul.progress == 100, WU.GetString("ProgressTask_Complete"), WU.GetString("ProgressTask_Progress", actorCul.progress, nextProgress))
            SetViewInfo(ptName, {
              actorId = actorCul.actorId,
              text = text,
              canGet = TaskRewardCanGet(currentTasks, actorCul)
            })
          end
        else
          SetViewInfo(ptName, {
            actorId = actorCul.actorId,
            text = WU.GetString("ProgressTask_CustomConfirm"),
            canGet = false
          })
        end
      else
        SetViewInfo(ptName, {
          actorId = nil,
          text = WU.GetString("ProgressTask_CustomChooseActor"),
          canGet = false
        })
      end
    else
      SetViewInfo(ptName, nil)
    end
  end)
end

function InitCustomActorCultivation1(acStatusMap)
  OnAcChangeCustomActorCultivation1(acStatusMap)
end

function OnAcChangeCustomActorCultivation1(acStatusMap)
  CommonInitCustomActorCultivation(acStatusMap, 1, "CustomActorCultivation1")
end

function InitCustomActorCultivation2(acStatusMap)
  OnAcChangeCustomActorCultivation2(acStatusMap)
end

function OnAcChangeCustomActorCultivation2(acStatusMap)
  CommonInitCustomActorCultivation(acStatusMap, 2, "CustomActorCultivation2")
end

function HaveCanGetTask(tasks, vip)
  if tasks then
    for k, v in pairs(tasks) do
      local canGet = v.isDone and not v.rewardGot and not v.timeout and fif(v.actorCultivationVipOnly, vip, true)
      if canGet then
        return true
      end
    end
  end
  return false
end

function GetTaskDescString(task)
  local param = task.res.taskParam
  if param[1] ~= nil and (task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimes or task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesP1Star or task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesActorPN or task.res.goalType == PB.enum.TaskType.BalanceP0GoldMTimes) then
    if param[1] == 0 then
      return WU.GetString("Task_AnyDugeon")
    else
      return WU.GetString("DungeonName_" .. param[1])
    end
  end
  return ColorParam(param)
end

function ColorParam(param)
  local p = {}
  for i = 1, #param do
    table.insert(p, HU.ApplyFontColor(param[i], "#0199E9"))
  end
  return table.unpack(p)
end
