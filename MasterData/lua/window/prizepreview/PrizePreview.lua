local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_config, m_otherInfo, m_playerRecord, m_rewardGot, m_rewardsTable, m_progressIndex, m_firstCanRewardIndex, m_rewards
local m_rewardsFinishedCount = 0
local m_receiveRewardsCount = 0
local m_receiveRewards = {}
local m_listRewardLocation, m_wrapContent, m_scrollView, m_containerRef

function UninitWindow()
  WU.RemoveAllChild(REF.WrapContentReward)
  WU.RemoveAllChild(REF.WidgetReward)
  REF.WrapContentReward.UIWrapContent:UpdateChildren()
  m_config = nil
  m_otherInfo = nil
  m_playerRecord = nil
  m_rewardGot = nil
  m_rewardsTable = nil
  m_progressIndex = nil
  m_firstCanRewardIndex = nil
  m_wrapContent = nil
  m_scrollView = nil
  m_containerRef = nil
end

function Focus(on)
  if m_config == nil then
    return
  end
  if m_config.name == "DungeonGuildContribution" then
    local guildId = this:GetData("guildId")
    DungeonGuild_ValidateRestrictions(guildId)
  end
end

function SetPrizePreview(name, otherInfo)
  m_config = PB.get("PrizePreviewConfig", name)
  m_otherInfo = otherInfo
  m_playerRecord = m_otherInfo and m_otherInfo.playerRecord
  if m_config == nil then
    warning("PrizePreviewConfig doesn't have config of " .. name)
    return
  end
  UpdateStaticUI()
  local isWidget = m_config.widgetName and m_config.widgetName ~= ""
  local isWidgetControl = m_config.widgetControlSelf
  WU.SetActive(REF.ListReward, not isWidget)
  WU.SetActive(REF.WidgetReward, isWidget)
  if isWidget then
    InitWidgetUI()
    m_wrapContent = m_containerRef.WidgetWrapContentReward
    m_scrollView = m_containerRef.WidgetScrollViewReward
  else
    InitListUI()
    m_wrapContent = REF.WrapContentReward
    m_scrollView = REF.ScrollViewReward
  end
  this:DelayInvokeInFrames(1, function()
    if not isWidgetControl then
      if m_config.showState then
        GetGotHistory()
      end
      InitRewardsInfo()
      m_wrapContent.UIWrapContent:UpdateChildren()
      UpdateListUI()
    end
    SpecialAddOnUI()
    SpecialHandleOnEvent()
    SetGetAllRewardsButton()
  end)
end

function UpdateStaticUI()
  REF.LabelDialogTitle.UILabel.text = GetPrizePreviewTitle()
  REF.Anchor.UIWidget.width = m_config.bgWidth
  REF.BGback.UISprite.width = m_config.bgWidth
  REF.BGfront.UISprite.width = m_config.bgWidth
end

function InitWidgetUI()
  local goWidget = WU.InstantiateWindowPrefabAttached(REF.WidgetReward, "PrizePreview/" .. m_config.widgetName, m_config.widgetName)
  WU.HandleGameObjectAttached(goWidget)
  if m_config.widgetControlSelf then
    _ENV["$"](goWidget)["$$SetConfig"](m_config)
  end
  m_containerRef = _ENV["$"](goWidget)
end

function InitListUI()
  local goSlot = WU.InstantiateWindowPrefabAttached(REF.WrapContentReward, "PrizePreview/" .. m_config.slotName, m_config.slotName)
  WU.HandleGameObjectAttached(goSlot)
  local height = _ENV["$"](goSlot)["$UIWidget"].height
  REF.WrapContentReward.UIWrapContent.itemSize = height + 20
  local count = math.floor((REF.ListReward.UIWidget.height - 1) / (height + 20)) + 2
  for i = 1, count do
    local goSlot = WU.InstantiateWindowPrefabAttached(REF.WrapContentReward, "PrizePreview/" .. m_config.slotName, m_config.slotName)
    WU.HandleGameObjectAttached(goSlot)
  end
end

function InitRewardsInfo()
  local xlsxFilter = m_otherInfo and m_otherInfo.xlsxFilter
  local rewardListAll
  if m_config.rewardsXlsx and m_config.rewardsXlsx ~= "" then
    rewardListAll = PB.all(m_config.rewardsXlsx)
  else
    rewardListAll = GetRewardListFromServer()
  end
  if rewardListAll == nil then
    error("Prize Preview Need Rewards Info!")
  end
  local rewardList
  if xlsxFilter == nil then
    rewardList = rewardListAll
  else
    rewardList = table.where(rewardListAll, function(k, v)
      for i = 1, #xlsxFilter do
        local t = xlsxFilter[i]
        if t.value ~= v[t.key] then
          return false
        end
      end
      return true
    end):toarray():sort(function(a, b)
      return GetTargetPerLevel(a) < GetTargetPerLevel(b)
    end)
  end
  m_rewardsTable = {}
  for i = 1, #rewardList do
    if m_config.rewardOrderReverse then
      table.insert(m_rewardsTable, 1, rewardList[i])
    else
      table.insert(m_rewardsTable, rewardList[i])
    end
  end
end

function UpdateListUI()
  LU.Bind(m_wrapContent, {
    updateRow = OnRewardSlotShow
  })
  UpdateScrollContent()
end

function UpdateScrollContent()
  if not m_config.showState then
    LU.Set(m_wrapContent, #m_rewardsTable)
    return
  end
  m_progressIndex = nil
  m_firstCanRewardIndex = nil
  local rewardCount = #m_rewardsTable
  local startIndex, endeIndex, step
  if m_config.rewardOrderReverse then
    startIndex = rewardCount
    endeIndex = 1
    step = -1
  else
    startIndex = 1
    endeIndex = rewardCount
    step = 1
  end
  for i = startIndex, endeIndex, step do
    local rewards = m_rewardsTable[i]
    local rewardsTarget = GetTargetPerLevel(rewards)
    if rewardsTarget > m_playerRecord then
      if m_progressIndex == nil then
        m_progressIndex = i
      end
    elseif m_firstCanRewardIndex == nil and not _ENV["!"](m_rewardGot):has(rewardsTarget) then
      m_firstCanRewardIndex = i
    end
  end
  LU.Set(m_wrapContent, #m_rewardsTable)
  this:DelayInvokeInFrames(1, function()
    local itemHeight = m_wrapContent.UIWrapContent.itemSize
    local index
    if m_config.showProgress then
      index = fif(m_firstCanRewardIndex == nil, m_progressIndex, m_firstCanRewardIndex)
    else
      index = m_firstCanRewardIndex
    end
    if index == nil then
      index = 1
    end
    local m_moveDistance = itemHeight * (index - 1)
    m_scrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    m_scrollView.UIScrollView:RestrictWithinBounds(true)
  end)
end

function OnRewardSlotShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_rewardsTable == nil or realIndex >= #m_rewardsTable then
    return
  end
  local data
  local index = realIndex + 1
  local rewards = m_rewardsTable[index]
  local data = {}
  data.reward = GetRewardsPerLevel(rewards)
  if m_config.showState then
    local rewardsTarget = GetTargetPerLevel(rewards)
    local _, target = table.find(m_rewardGot, function(_, v)
      return rewardsTarget == v
    end)
    if target ~= nil then
      data.rewardState = PB.enum.RewardState.HasGot
    elseif rewardsTarget <= m_playerRecord then
      data.rewardState = PB.enum.RewardState.CanGet
    elseif m_progressIndex == index then
      data.rewardState = PB.enum.RewardState.IsDoing
      data.progressText, data.progressValue = GetProgressInfo(rewards)
    else
      data.rewardState = PB.enum.RewardState.WillDo
    end
    data.currentValue = m_playerRecord
    data.rewardTarget = rewardsTarget
  end
  rowRef["$$SetData"](data)
  rowRef["$$SetRewardView"]()
  rowRef["$$SetStateView"](m_config)
  SpecialHandleOnSlot(rowRef, rewards)
  if m_config.showState then
    rowRef["$$SetClickCallback"](OnRewardGetClick)
  else
    rowRef["$$SetClickCallback"]()
  end
end

function OnRewardGetClick(go)
  local rewardInfo = _ENV["$"](go)["@data"]
  local postData = GetPostData(rewardInfo)
  if m_config.name == "Couple" then
    this:BroadcastGameEvent("OnCoupleReward", postData)
    WU.RecycleWindow(this)
  else
    local path = GetRequirePath()
    this:GameRequest(path):Post(postData, function(result)
      DBH.ResChange(result.resChange)
      SetGotHistory(result, rewardInfo)
      WU.ShowRewards(result.resChange)
      UpdateScrollContent()
    end)
  end
end

function SpecialHandleOnSlot(ref, data)
  local target = GetTargetPerLevel(data)
  local targetStr = tostring(target)
  if m_config.name == "GameFlappy" then
    ref["$$SetTitleView"](targetStr .. "m")
  elseif m_config.name == "EventActivityStar" then
    ref["$$SetTitleView"](targetStr)
  elseif m_config.name == "BurstLink" then
    ref["$$SetTitleView"](WU.GetString("Tournament_WinTimes", targetStr))
  elseif m_config.name == "HotPotDining" then
    local title1 = fif(target > #m_rewardsTable, WU.GetString("Window_Level", "Max"), WU.GetString("Window_Level", target))
    local title2 = tostring(data.exp) .. "pt"
    ref["$$SetTitleView"](title1, title2)
  elseif m_config.name == "Couple" then
    ref["$$SetTitleView"](targetStr)
  elseif m_config.name == "DungeonGuildContribution" then
    ref["$$SetTitleView"]("<img src='ResIcon_s.guild_coin_2'/>" .. targetStr)
  end
end

function SpecialHandleOnEvent()
  if m_config.name == "DungeonGuildContribution" then
    this:Bind("guildId", DungeonGuild_ValidateRestrictions)
  end
end

function SpecialAddOnUI()
  local ref = _ENV["$"](REF.NodeComponent)
  local showTotalStars = m_config.name == "EventActivityStar"
  WU.SetActive(ref.NodeStar, showTotalStars)
  if m_config.name == "EventActivityStar" then
    ref.LabelTotalStar.UILabel.text = m_otherInfo.playerRecord
  elseif m_config.name == "DungeonGuildContribution" then
    m_containerRef.LabelMyRank.UILabel.text = m_otherInfo.myRank
    m_containerRef.LabelMyContribution.UIHtmlLabel.text = "<img src='ResIcon_s.guild_coin_2'/>&nbsp;" .. m_otherInfo.playerRecord
  end
end

function GetGotHistory()
  local path = GetRecordPath()
  local data = this:GetData(path) or {}
  if m_config.name == "Tower" then
    m_rewardGot = data.rewardGot
  elseif m_config.name == "DungeonGuildContribution" then
    m_rewardGot = data.rewardRecords or _ENV["!"]({})
  elseif m_config.name == "RacePVPScore" then
    m_rewardGot = data.rewardRecved
  elseif m_config.name == "EventActivityStar" then
    m_rewardGot = data.rewardSummary[m_otherInfo.activityId].rewardGot
  elseif m_config.name == "HotPotDining" then
    m_rewardGot = data.roleProgressDetails[m_otherInfo.roleId].rewardGot
  elseif m_config.name == "Couple" then
    m_rewardGot = _ENV["!"]({})
    local ori = data.coupleRewardInfo
    for i = 1, #ori do
      if ori[i].got then
        table.insert(m_rewardGot, ori[i].coupleScore)
      end
    end
  end
end

function SetGotHistory(result, rewardInfo)
  local path = GetRecordPath()
  local data = this:GetData(path) or {}
  if m_config.name == "Tower" then
    m_rewardGot = result.rewardGot
    data.rewardGot = m_rewardGot
  elseif m_config.name == "DungeonGuildContribution" then
    m_rewardGot = result.rewardRecords
    data.rewardRecords = result.rewardRecords
    this:BroadcastGameEvent("DungeonGuildRewardGot")
  elseif m_config.name == "RacePVPScore" then
    table.insert(m_rewardGot, rewardInfo.rewardTarget)
    data.rewardRecved = m_rewardGot
  elseif m_config.name == "EventActivityStar" then
    table.insert(m_rewardGot, rewardInfo.rewardTarget)
    data.rewardSummary[m_otherInfo.activityId].rewardGot = m_rewardGot
  end
  this:SetData(path, data)
end

function GetRecordPath()
  if m_config.name == "EventActivityStar" then
    return m_config.recordPath .. m_otherInfo.activityType .. "/" .. m_otherInfo.activityId
  else
    return m_config.recordPath
  end
end

function GetPrizePreviewTitle()
  if m_config.name == "Tower" then
    return WU.GetString("WindowTower_ScoreAward")
  elseif m_config.name == "GameFlappy" then
    return WU.GetString("GameFlappy_RewardTitle")
  elseif m_config.name == "GameLottery" then
    return WU.GetString("GameLottery_RewardTitle")
  elseif m_config.name == "DungeonGuildContribution" then
    return WU.GetString("DungeonGuild_RewardTitle")
  elseif m_config.name == "BurstLink" then
    return WU.GetString("Tournament_BurstLinkPrizePreviewTitle")
  elseif m_config.name == "RacePVPScore" then
    return WU.GetString("Tournament_Reward")
  elseif m_config.name == "RacePVPGrade" then
    return WU.GetString("PVPREALRACE_REWARD_TITLE")
  elseif m_config.name == "EventActivityStar" then
    return WU.GetString("EventActivity_Reward_Title")
  elseif m_config.name == "HotPotDining" then
    return WU.GetString("HotPot_RewardTitle")
  elseif m_config.name == "Couple" then
    return WU.GetString("Couple_RewardTitle")
  elseif m_config.name == "AsyncPvpNewGrade" then
    return WU.GetString("Tournament_BurstLinkPrizePreview")
  end
end

function GetRewardListFromServer()
  local data = this:GetData(m_config.rewardsPath)
  if m_config.name == "BurstLink" then
    return data.reward
  elseif m_config.name == "Couple" then
    return data.coupleRewardInfo
  end
end

function GetRewardsPerLevel(info)
  if m_config.name == "DungeonGuildContribution" or m_config.name == "RacePVPScore" or m_config.name == "HotPotDining" then
    return info.rewards
  else
    return info.reward
  end
end

function GetTargetPerLevel(info)
  if m_config.name == "Tower" then
    return info.towerFloor
  elseif m_config.name == "GameFlappy" then
    return info.score
  elseif m_config.name == "DungeonGuildContribution" then
    return info.score
  elseif m_config.name == "BurstLink" then
    return info.id
  elseif m_config.name == "RacePVPScore" then
    return info.battleScore
  elseif m_config.name == "EventActivityStar" then
    return info.star
  elseif m_config.name == "HotPotDining" then
    return info.level + 1
  elseif m_config.name == "Couple" then
    return info.coupleScore
  end
end

function GetProgressInfo(info)
  local targetValue, curValue
  if m_config.name == "HotPotDining" then
    local path = GetRecordPath()
    local data = this:GetData(path) or {}
    targetValue = info.exp
    curValue = data.roleProgressDetails[m_otherInfo.roleId].exp
  else
    targetValue = GetTargetPerLevel(info)
    curValue = m_playerRecord
  end
  local text = WU.GetString("Window_TowerReward2", curValue, targetValue)
  local value = curValue * 1.0 / targetValue
  return text, value
end

function GetPostData(info)
  if m_config.name == "Tower" then
    return {
      floorReward = info.rewardTarget
    }
  elseif m_config.name == "DungeonGuildContribution" then
    return {
      score = info.rewardTarget
    }
  elseif m_config.name == "RacePVPScore" then
    return {
      battleScore = info.rewardTarget
    }
  elseif m_config.name == "EventActivityStar" then
    return {
      star = info.rewardTarget
    }
  elseif m_config.name == "Couple" then
    return {
      coupleScore = info.rewardTarget
    }
  end
end

function GetRequirePath()
  if m_config.name == "EventActivityStar" then
    return m_config.getRewardPath .. m_otherInfo.activityType .. "/" .. m_otherInfo.activityId
  else
    return m_config.getRewardPath
  end
end

function OnGetAllRewardsClick()
  if m_rewardsTable == nil or m_rewardGot == nil then
    return
  end
  for i = 1, #m_rewardsTable do
    local rewards = {}
    rewards.rewardTarget = GetTargetPerLevel(m_rewardsTable[i])
    if not IsRewardGot(rewards.rewardTarget) and rewards.rewardTarget <= m_playerRecord then
      m_rewardsFinishedCount = m_rewardsFinishedCount + 1
      do
        local path = GetRequirePath()
        local id = GetPostData(rewards)
        this:GameRequest(path):Post(id, function(result)
          SetGotHistory(result, rewards)
          OnGetAllRewardsCallBack(result)
        end)
      end
    end
  end
  if m_rewardsFinishedCount == 0 then
    WU.ShowHintText(WU.GetString("Window_GetAllRewardsFailed"))
  end
end

function OnGetAllRewardsCallBack(result)
  if result == nil then
    return
  end
  m_receiveRewardsCount = m_receiveRewardsCount + 1
  WU.CombineRewards(result, m_receiveRewards)
  DBH.ResChange(result.resChange)
  if m_receiveRewardsCount == m_rewardsFinishedCount then
    WU.ShowRewards(m_receiveRewards)
    UpdateScrollContent()
    m_receiveRewardsCount = 0
    m_rewardsFinishedCount = 0
  end
end

function IsRewardGot(rewardTarget)
  for i = 1, #m_rewardGot do
    if rewardTarget == m_rewardGot[i] then
      return true
    end
  end
  return false
end

function SetGetAllRewardsButton()
  local isActive = m_config.canGetAll
  local button = REF.ButtonGetAllRewards
  if m_config.slotName and m_config.slotName ~= "" then
    local list = REF.ListReward
    local localPos = list.UIWidget.gameObject.transform.localPosition
    if m_listRewardLocation == nil then
      m_listRewardLocation = CS.UnityEngine.Vector3(localPos.x, localPos.y, list.UIWidget.height)
    end
    list.UIWidget.height = fif(isActive, m_listRewardLocation.z - 75, m_listRewardLocation.z)
    list.UIWidget:UpdateAnchors()
    REF.ScrollViewReward.UIPanel:UpdateAnchors()
    list.UIWidget.gameObject.transform.localPosition = CS.UnityEngine.Vector3(m_listRewardLocation.x, m_listRewardLocation.y + fif(isActive, 37, 0), 0)
  end
  button.gameObject:SetActive(isActive)
  if isActive then
    WU.BindButtonEvent(button, OnGetAllRewardsClick)
    _ENV["$"](button).Label.UILabel.text = WU.GetString("Window_GetAllRewards")
  end
end

function DungeonGuild_ValidateRestrictions(guildId)
  local top = WU.TopWindow()
  if top and top.name == this.name and guildId == 0 then
    if not this:GetData("GuildQuitNotified") then
      this:SetData("GuildQuitNotified", true)
      WU.ShowMessageOK(WU.GetString("Window_JustQuitGuild"), function(result)
        local top = WU.TopWindow()
        if top and top.name == this.name then
          WU.RecycleWindow(this)
        end
      end)
    else
      WU.RecycleWindow(this)
    end
  end
end
