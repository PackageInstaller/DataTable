local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local m_missions, m_remainRefreshTimes, m_refreshCost, m_availableRoles
local m_SkipConfirmaWindow = false

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnMissionSlotShow,
    delta = 0.01
  })
  WU.BindButtonEvent(REF.ButtonRefresh, OnRefreshClick)
  WU.BindButtonEvent(REF.ButtonGetAllRewards, OnGetAllRewardsClick)
  local timeSetting = CS.System.TimeSpan.Parse(PB.index("Misc", 1).dailyRefreshTime)
  REF.LabelRefreshTime.UILabel.text = WU.GetString("WindowDeploy_RefreshTime", timeSetting.Hours)
  _ENV["$"](REF.ButtonGetAllRewards).Label.UILabel.text = WU.GetString("Window_GetAllRewards")
end

function InitWindow()
  m_availableRoles = _ENV["!"]({})
  for _, actor in pairs(this:GetData("fci/actor/")) do
    local role = PB.get("ActorConfig", actor.id).role
    m_availableRoles[role] = role
  end
  this:SetData("fci/deploy/mission/", nil)
  this:BindRemote(DB:GameRequest("fci/deploy/mission/"), OnMissionChange)
  this:GameRequest("fci/resbuyprice/" .. PB.enum.ActivityType.DeployMission):Get(SetRefreshCost)
  this:Bind("fci/baseinfo/", function(info)
    if m_missions ~= nil then
      SetOngoingCount()
    end
  end)
end

function OnMissionChange(result)
  if result == nil then
    LU.Set(REF.WrapContent, 0)
  else
    m_missions = result.missionInfo
    local lastFinishedMission
    for _, mission in pairs(m_missions) do
      mission.config = PB.get("DeployMission", mission.id)
      if mission.config == nil then
        error("Deploy", "no id " .. mission.id .. " in DeployMission!!")
      elseif 0 < mission.endTimestamp then
        if lastFinishedMission == nil then
          lastFinishedMission = mission
        elseif lastFinishedMission.endTimestamp > mission.endTimestamp then
          lastFinishedMission = mission
        end
      end
    end
    if lastFinishedMission then
      this:BroadcastGameEvent("SetDeployNotify", lastFinishedMission.endTimestamp)
    end
    CheckAvailableMission()
    CheckSelectedMission()
    table.sort(m_missions, SortMission)
    LU.Set(REF.WrapContent, #m_missions)
    SetOngoingCount()
    SetRedMark()
  end
end

function OnMissionSlotShow(rowRef, wrapIndex, realIndex)
  if m_missions and realIndex ~= nil and realIndex < #m_missions then
    WU.SetActive(rowRef.Visual, true)
    rowRef["$$SetView"](m_missions[realIndex + 1])
  else
    WU.SetActive(rowRef.Visual, false)
  end
end

function OnRefreshClick()
  WU.RecordButtonClick(100132002)
  if m_remainRefreshTimes <= 0 then
    WU.ShowHintText(WU.GetString("Window_ExchangesNoTimes"))
    return
  end
  WU.TryToRefresh(m_refreshCost.type, m_refreshCost.count, Refresh)
end

function Refresh()
  WU.TryToPayResource(m_refreshCost, function()
    this:GameRequest("fci/resbuyprice/resbuy/"):Post({
      resbuypriceType = PB.enum.ActivityType.DeployMission
    }, function(result)
      DBH.ResChange(result.resChange)
      SetRefreshCost(result)
      this:GameRequest("fci/deploy/mission/"):Get(function(response)
        this:SetData("fci/deploy/mission/", response)
      end)
    end)
  end)
end

function SortMission(a, b)
  local isAFinished = a.endTimestamp ~= 0 and a.endTimestamp <= CS.GameTime.serverUtc
  local isBFinished = b.endTimestamp ~= 0 and b.endTimestamp <= CS.GameTime.serverUtc
  if isAFinished ~= isBFinished then
    return isAFinished
  else
    local isAStarted = a.startTimestamp ~= 0
    local isBStarted = b.startTimestamp ~= 0
    if isAStarted ~= isBStarted then
      return isAStarted
    elseif a.startTimestamp ~= b.startTimestamp then
      return a.startTimestamp > b.startTimestamp
    elseif a.available ~= b.available then
      return a.available
    elseif a.config.missionType ~= b.config.missionType then
      return a.config.missionType < b.config.missionType
    else
      return a.id < b.id
    end
  end
end

function SetOngoingCount()
  local count = 0
  for _, mission in pairs(m_missions) do
    if mission.startTimestamp ~= 0 then
      count = count + 1
    end
  end
  local level = this:GetData("fci/baseinfo/").level
  local info = PB.get("DeployCount", level)
  if info ~= nil then
    local maxDeployCount = info.missionCount
    REF.LabelDeployCount.UILabel.text = count .. "/" .. maxDeployCount
  else
    error("Deploy", "no level " .. level .. " in DeployCount.xlsx")
  end
end

function SetRedMark()
  local _, finishedMission = _ENV["!"](m_missions):find(function(k, v)
    return v.endTimestamp ~= 0 and v.endTimestamp <= CS.GameTime.serverUtc
  end)
  if finishedMission == nil then
    RU.SetRedMark(string.format("Activity/%s/Reward", PB.enum.ActivityType.DeployMission), false)
  end
end

function SetRefreshCost(result)
  m_remainRefreshTimes = result.remainBuyTimes
  m_refreshCost = result.cost
  REF.LabelRefreshCost.ResourcePrinter:SetResource(m_refreshCost.type, m_refreshCost.id, m_refreshCost.count)
end

function CheckSelectedMission()
  local selectedMission = this:GetData("Deploy/SelectedMission")
  local top = WU.TopWindow()
  if selectedMission ~= nil and top and top.name ~= "Deploy" then
    local _, mission = _ENV["!"](m_missions):find(function(k, v)
      return v.id == selectedMission.id
    end)
    if mission == nil then
      this:BroadcastGameEvent("OnNavigation", "Deploy")
      WU.ShowMessageOK(WU.GetString("Window_GameDataReset"))
    end
    this:SetData("Deploy/SelectedMission", mission)
  end
end

function CheckAvailableMission()
  local readyRoles = m_availableRoles:duplicate()
  for _, mission in pairs(m_missions) do
    for _, roleId in pairs(mission.roleid) do
      readyRoles[roleId] = nil
    end
  end
  for _, mission in pairs(m_missions) do
    local availableRole = 0
    for _, condition in pairs(mission.config.roleCon) do
      local paramString = condition.param:split("&")
      condition.needIds = {}
      for _, str in pairs(paramString) do
        table.insert(condition.needIds, math.floor(tonumber(str)))
      end
      if mission.startTimestamp ~= 0 or condition.type == PB.enum.DeployMissionCondition.Lable then
      elseif condition.type == PB.enum.DeployMissionCondition.Role then
        if readyRoles[condition.needIds[1]] ~= nil then
          availableRole = availableRole + 1
        end
      elseif condition.type == PB.enum.DeployMissionCondition.None then
        availableRole = readyRoles:count()
        break
      end
    end
    if mission.startTimestamp == 0 then
      mission.available = availableRole >= mission.config.needRoleNum
    else
      mission.available = true
    end
  end
end

function OnGetAllRewardsClick()
  local hasOverMissions = false
  for _, v in ipairs(m_missions) do
    if v.startTimestamp ~= 0 and 0 >= v.endTimestamp - CS.GameTime.serverUtc then
      hasOverMissions = true
      break
    end
  end
  if hasOverMissions then
    this:GameRequest("fci/deploy/deploymissionreward"):Put({}, function(result)
      local rewards = {}
      WU.CombineRewards(result, rewards)
      DBH.ResChange(result.resChange)
      NU.UpdateRoleFavour(result.favourChange)
      WU.ShowRewards(rewards)
      DB:SyncRemote(DB:GameRequest("fci/deploy/mission/"))
    end)
  else
    WU.ShowHintText(WU.GetString("Window_GetAllRewardsFailed"))
  end
end

function Focus(on)
  WU.RecordWindowFocus(100132, on)
end
