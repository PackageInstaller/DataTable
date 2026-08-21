local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local NU = require("Common/NotepadUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local m_missionInfo, m_remainTime
local m_finished = false
local m_speedUpItems

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonSpeedUp, OnSpeedUpClick)
  WU.BindButtonEvent(REF.ButtonGiveUp, OnGiveUpClick)
  WU.BindButtonEvent(REF.ButtonDeploy, OnDeployClick)
  WU.BindButtonEvent(REF.ButtonGet, OnGetRewardClick)
  WU.BindButtonEvent(REF.ButtonSetAllActor, OnSetAllActorClick)
  m_speedUpItems = PB.all("ItemInfo"):where(function(k, v)
    return v.funcType == PB.enum.ItemFuncType.DeploySpeedUp
  end):toarray()
end

function InitWindow()
  this:Bind("Deploy/SelectedMission", OnCurrentMissionChange)
  this:RegisterGameEvent("DeployFinishEffect", PlayFinishedEffect)
  this:DelayInvokeInFrames(1, function()
    if not REF.Ongoing.gameObject.activeSelf then
      return
    end
    for i = 1, #m_speedUpItems do
      if this:GetData("fci/item/" .. m_speedUpItems[i].id).count > 0 then
        WU.TriggerUnforcedTutorial(1119)
        break
      end
    end
  end)
end

function UpdateWindow()
  if m_missionInfo == nil then
    return
  end
  REF.NotStart.gameObject:SetActive(m_missionInfo.startTimestamp == 0)
  REF.Ongoing.gameObject:SetActive(m_missionInfo.startTimestamp ~= 0)
  m_remainTime = m_missionInfo.endTimestamp - CS.GameTime.serverUtc
  m_finished = m_remainTime <= 0
  REF.ButtonGet.gameObject:SetActive(m_finished)
  REF.Ongoing.gameObject:SetActive(not m_finished)
  REF.LabelRemainTime.gameObject:SetActive(not m_finished)
  if not m_finished then
    REF.LabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(m_remainTime, REF.LabelRemainTime.UIHtmlLabel.fontSize)
  end
end

function UninitWindow()
  this:SetData("Deploy/SelectedMission", nil)
  if m_missionInfo.startTimestamp == 0 then
    m_missionInfo.roleid = {}
  end
end

function OnCurrentMissionChange(mission)
  if mission ~= nil then
    m_missionInfo = mission
    SetView()
  end
end

function OnSpeedUpClick()
  WU.RecordButtonClick(100132105)
  WU.AcquireWindowAsync("DeploySpeedUp")
end

function OnGiveUpClick()
  WU.RecordButtonClick(100132104)
  WU.ShowMessageYesNo(WU.GetString("WindowDeploy_GiveUpMissionTip"), function(msg)
    if msg == "YES" then
      this:GameRequest("fci/deploy/deploymissiondiscard/"):Post({
        id = m_missionInfo.id
      }, function(result)
        DBH.ResChange(result.resChange)
        m_missionInfo.startTimestamp = 0
        m_missionInfo.endTimestamp = 0
        m_missionInfo.roleid = {}
        this:SetData("fci/deploy/mission/", this:GetData("fci/deploy/mission/"))
      end)
    end
  end)
end

function OnDeployClick()
  WU.RecordButtonClick(100132103)
  if #m_missionInfo.roleid < m_missionInfo.config.needRoleNum then
    WU.ShowHintText(WU.GetString("WindowDeploy_ActorNotEnoughTip"))
    return
  end
  local setting = PB.index("Misc", 1)
  local deployInfo = this:GetData("fci/deploy/mission/")
  local accomplishNum = deployInfo.accomplishNum
  if accomplishNum >= setting.maxAccomplishDeployNum then
    WU.ShowMessageOK(WU.GetString("WindowDeploy_ReachMaxAccomplishCountTip", accomplishNum))
  elseif accomplishNum >= setting.maxNotifyDeployNum then
    WU.ShowMessageYesNo(WU.GetString("WindowDeploy_FewAccomplishCountTip", accomplishNum, setting.maxAccomplishDeployNum - accomplishNum), function(msg)
      if msg == "YES" then
        DoDeploy()
      end
    end)
  else
    DoDeploy()
  end
end

function DoDeploy()
  local maxDeployCount = PB.get("DeployCount", this:GetData("fci/baseinfo/").level).missionCount
  local ongoingCount = 0
  local deployInfo = this:GetData("fci/deploy/mission/")
  for _, mission in pairs(deployInfo.missionInfo) do
    if mission.startTimestamp ~= 0 then
      ongoingCount = ongoingCount + 1
    end
  end
  if ongoingCount == maxDeployCount then
    WU.ShowMessageOK(WU.GetString("WindowDeploy_ReachMaxDeployCountTip"))
  else
    local cost = m_missionInfo.config.cost
    local free = #cost == 0 or cost[1].count == 0
    if free then
      DoDeployImpl()
    else
      WU.TryToPayResource(cost[1], DoDeployImpl)
    end
  end
end

function DoDeployImpl()
  local selectedRoles = m_missionInfo.roleid
  local actors = this:GetData("fci/actor/")
  local actorUids = {}
  for _, role in pairs(selectedRoles) do
    local _, actor = _ENV["!"](actors):find(function(k, v)
      return PB.get("ActorConfig", v.id).role == role
    end)
    table.insert(actorUids, actor.uid)
  end
  this:GameRequest("fci/deploy/deploymissionattend/"):Post({
    actorUid = actorUids,
    id = m_missionInfo.id
  }, function(result)
    DBH.ResChange(result.resChange)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_DeployStart")
    REF.EffectSuccess.EffectGenerator:Play()
    m_missionInfo.startTimestamp = CS.GameTime.serverUtc
    m_missionInfo.endTimestamp = CS.GameTime.serverUtc + m_missionInfo.config.time
    this:SetData("fci/deploy/mission/", this:GetData("fci/deploy/mission/"))
    if result.isPlayStory then
      WU.EnterCartoonLevel(m_missionInfo.config.storyId, "Activity, Deploy")
    end
  end)
end

function OnGetRewardClick()
  this:GameRequest("fci/deploy/deploymissionreward/"):Post({
    id = m_missionInfo.id
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    WU.RecycleWindow("DeployMissionDetail")
    DB:SyncRemote(DB:GameRequest("fci/deploy/mission/"))
    NU.UpdateRoleFavour(result.favourChange)
  end)
end

function SetView()
  REF.LabelName.UILabel.text = WU.GetString("DeployMissionName_" .. m_missionInfo.config.id)
  REF.LabelTime.UILabel.text = WU.GetString("Window_Hour", m_missionInfo.config.time // 3600)
  REF.LabelDescription.UIHtmlLabel.text = WU.GetString("DeployMissionDescribe_" .. m_missionInfo.config.id)
  SetRequirementText()
  SetActors()
  for i = 0, #REF.Rewards - 1 do
    local hasReward = i < #m_missionInfo.config.reward
    REF.Rewards[i].root.gameObject:SetActive(hasReward)
    if hasReward then
      local reward = m_missionInfo.config.reward[i + 1]
      REF.Rewards[i].root["$SetData"](reward.type, reward.id, reward.count)
      REF.Rewards[i].root["$SetClickCallback"](function()
        WU.ShowResourceDetail(reward.type, reward.id)
      end)
    end
  end
  local cost = m_missionInfo.config.cost
  local free = #cost == 0 or cost[1].count == 0
  REF.LabelFree.gameObject:SetActive(free)
  REF.LabelPower.gameObject:SetActive(not free)
  if not free then
    REF.LabelPower.ResourcePrinter:SetResource(cost[1].type, cost[1].id, cost[1].count)
  end
end

function SetActors()
  local roles = m_missionInfo.roleid
  for i = 0, #REF.Actors - 1 do
    local hasActor = i < m_missionInfo.config.needRoleNum
    REF.Actors[i].root.gameObject:SetActive(hasActor)
    if hasActor then
      local ref = REF.Actors[i]
      if i < #roles then
        ref["$$SetActorByRoleId"](roles[i + 1])
        ref["$$ShowCustom"]({name = false})
      else
        ref["$$SetEmpty"](1)
      end
      if m_missionInfo.startTimestamp == 0 then
        ref["$$SetClickCallback"](function()
          WU.RecordButtonClick(100132101)
          WU.AcquireWindowAsync("DeployActorSelection")
        end)
      else
        ref["$$SetClickCallback"](nil)
      end
    end
  end
end

function SetRequirementText()
  local requirement = ""
  for i, condition in pairs(m_missionInfo.config.roleCon) do
    local req = ""
    if requirement ~= "" then
      req = req .. WU.GetString("WindowDeploy_Separator")
    end
    if condition.type == PB.enum.DeployMissionCondition.Lable then
    elseif condition.type == PB.enum.DeployMissionCondition.Role then
      local _, config = PB.all("ActorConfig"):find(function(k, v)
        return v.role == condition.needIds[1]
      end)
      if config == nil then
        error("Deploy", "no role " .. tostring(condition.needIds[1]) .. " in ActorConfig.xlsx")
      else
        req = req .. HU.ApplyFontColor(WU.GetString("ActorName_" .. config.id), "#00f1ff")
      end
    elseif condition.type == PB.enum.DeployMissionCondition.None then
      requirement = WU.GetString("WindowDeploy_AnyActor")
      break
    end
    requirement = requirement .. req
  end
  REF.LabelRequirement.UIHtmlLabel.text = requirement
  this:DelayInvokeEndOfFrame(function()
    REF.ScrollView.UIScrollView:ResetPosition()
  end)
end

function OnSetAllActorClick()
  if #m_missionInfo.roleid >= m_missionInfo.config.needRoleNum then
    return
  end
  local busyRole = {}
  local allMissions = this:GetData("fci/deploy/mission/").missionInfo
  for _, mission in ipairs(allMissions) do
    if mission.id ~= m_missionInfo.id then
      for _, roleId in ipairs(mission.roleid) do
        table.insert(busyRole, roleId)
      end
    end
  end
  local actors = this:GetData("fci/actor/")
  local tempRoles = {}
  local ownRoles = {}
  for _, v in ipairs(actors) do
    tempRoles[v.role] = true
  end
  for k, _ in pairs(tempRoles) do
    table.insert(ownRoles, k)
  end
  table.sort(ownRoles, function(a, b)
    return a < b
  end)
  local missionActor = m_missionInfo.roleid
  
  local function IsNotBusyAndNotRepeat(role)
    local r1 = table.find(busyRole, function(_, v)
      return v == role
    end)
    local r2 = table.find(missionActor, function(_, v)
      return v == role
    end)
    return r1 == nil and r2 == nil
  end
  
  local function IsRoleValid(role)
    for _, condition in pairs(m_missionInfo.config.roleCon) do
      if condition.type == PB.enum.DeployMissionCondition.Lable then
        return false
      elseif condition.type == PB.enum.DeployMissionCondition.Role then
        if condition.needIds[1] == role then
          return true
        end
      elseif condition.type == PB.enum.DeployMissionCondition.None then
        return true
      end
    end
    return false
  end
  
  for _, role in ipairs(ownRoles) do
    if #missionActor >= m_missionInfo.config.needRoleNum then
      break
    end
    if IsRoleValid(role) and IsNotBusyAndNotRepeat(role) then
      table.insert(missionActor, role)
    end
  end
  if #missionActor < m_missionInfo.config.needRoleNum then
    WU.ShowHintText(WU.GetString("WindowDeploy_MissionUnavailableTip"))
  else
    m_missionInfo.roleid = missionActor
    this:SetData("Deploy/SelectedMission", m_missionInfo)
  end
end

function PlayFinishedEffect()
  REF.FinishEffect.EffectGenerator:Play()
end

function Focus(on)
  WU.RecordWindowFocus(1001321, on)
end
