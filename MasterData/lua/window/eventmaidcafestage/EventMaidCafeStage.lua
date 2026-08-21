local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_activityManager = S:Get("ActivityManager")
local m_configDataManager = S:Get("ConfigDataManager")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_activityList, m_curNormalActivityId, m_curHardActivityId, m_records, m_dungeonList, m_normalDungeonList, m_hardDungeonList, m_buffActors, m_starRewardList, m_initDragPos
local m_currentDungeonMode = 1
local dMode = {
  {
    BG = "Texture/Coffee_bg/maid_coffee_gossip_bg",
    BGSize = {width = 3000, height = 1080},
    spriteName = "coffee_challenge"
  },
  {
    BG = "Texture/Coffee_bg/maid_coffee_challenge_bg",
    BGSize = {width = 2340, height = 1080},
    spriteName = "coffee_normal"
  }
}
local m_progressBarClamp = {left = -551, right = 0}

function SetupWindow()
  WU.TraverseChildren(REF.NormalDungeons, function(go, index)
    WU.BindButtonEvent(_ENV["$"](go).root, OnClickDungeon)
  end)
  WU.TraverseChildren(REF.HardDungeons, function(go, index)
    WU.BindButtonEvent(_ENV["$"](go).root, OnClickDungeon)
  end)
  WU.TraverseChildren(REF.StarRewardsGrid, function(go, index)
    WU.BindButtonEvent(_ENV["$"](go).root, OnClickStarReward)
  end)
  WU.BindButtonEvent(REF.StoryCollections, OnClickCollection)
  WU.SetActive(REF.StarRewardsProgress, false)
  WU.BindButtonEvent(REF.ModeChange, OnClickChangeDungeonMode)
  m_initDragPos = REF.ScrollView.transform.localPosition.x
end

function InitWindow()
  this:Bind("MaidCafe/CurrentActivity/Ordinary", OnActivityChange)
  this:Bind("MaidCafe/CurrentDungeonMode", OnCurrentDungeonMode)
end

function Focus(on)
end

function OnActivityChange(activityList)
  if activityList == nil then
    return
  end
  m_activityList = activityList
  local normalActivity = activityList[1]
  local hardActivity = activityList[2]
  if normalActivity == nil or hardActivity == nil then
    error("normalDungeon Ac or hardDungeon Ac Open time not match, check Activities.xlsx with type " .. PB.enum.ActivityType.MaidCafe_DaemonMode)
    return
  end
  m_starRewardList = PB.all("EventReward"):where(function(k, v)
    return v.activityId == normalActivity.activityId and v.activityType == PB.enum.ActivityType.MaidCafe_DaemonMode
  end):toarray()
  InitDungeons(normalActivity, true)
  InitDungeons(hardActivity, false)
  local curActivityInfo = PB.get("ActivityBuffActors", PB.enum.ActivityType.MaidCafe_DaemonMode, m_curNormalActivityId)
  if curActivityInfo == nil then
    error("nothing to show with id :", m_curNormalActivityId)
    return
  end
  m_buffActors = curActivityInfo.buffActors
  local buffList = curActivityInfo.buffId
  local buffDesc = ""
  for i = 1, #buffList do
    local affixId = buffList[i]
    local affix = PB.get("AffixInfo", affixId)
    local buffIndex = affix.index
    local buffInfo = PB.get("BuffIndex", buffIndex)
    local buffData = PB.get("BuffData", buffInfo.index, buffInfo.owner[1])
    if buffData.iconName ~= "" then
      buffDesc = buffDesc .. "<img src='FightBuffHint." .. buffData.iconName .. "'/>&nbsp;"
    end
  end
  REF.BuffDesc.UIHtmlLabel.text = WU.GetString("MaidCafe_BuffDesc", buffDesc)
end

function OnRecordChange(isNormal, activityId, data)
  if data == nil then
    return
  end
  m_records = data.records or _ENV["!"]({})
  local dungeonRef = fif(isNormal, _ENV["$"](REF.NormalDungeons), _ENV["$"](REF.HardDungeons))
  local dungeonList = fif(isNormal, m_normalDungeonList, m_hardDungeonList)
  for i = 1, #dungeonList do
    local ref = _ENV["$"](dungeonRef["Dungeon" .. i])
    local record = GetDungeonRecord(activityId, ref["@dungeonId"], ref["@balanceDungeonId"])
    ref["@record"] = record
    ref.Bg.UISprite.graify = not record.unlocked
    if ref.Road then
      ref.Road.UITexture.graify = not record.finished
    end
    local starRef = ref.Stars
    WU.SetActive(starRef, record.doneTimes > 0 and ref["@dungeonId"] == ref["@balanceDungeonId"])
    if record.doneTimes > 0 then
      for j = 0, #starRef - 1 do
        starRef[j].root.UISprite.spriteName = "star_" .. fif(j < #record.targetsDone, "b", "b_dark")
      end
    end
  end
end

function GetDungeonRecord(acId, dungeonId, balanceDungeonId)
  local _, record = table.find(m_records, function(k, v)
    return v.dungeonId == dungeonId
  end)
  local _, balanceRecord = table.find(m_records, function(k, v)
    return v.dungeonId == balanceDungeonId
  end)
  if dungeonId ~= balanceDungeonId then
    balanceRecord.unlocked = record.unlocked
  end
  if record == nil or balanceRecord == nil then
    error("GamePlay", string.format("dungeon%s's or dungeon%s's record is not in fci/activity/record/%s/%s", dungeonId, balanceDungeonId, PB.enum.ActivityType.MaidCafe_DaemonMode, acId))
  end
  return balanceRecord
end

function OnClickDungeon(go)
  local ref = _ENV["$"](go)
  local ac = m_activityManager.GetActivitySync(PB.enum.ActivityType.MaidCafe_DaemonMode, fif(ref["@normal"], m_curNormalActivityId, m_curHardActivityId))
  if ACU.GetStatus(ac) == PB.enum.ActivityStatus.PreHeat or ACU.GetStatus(ac) == PB.enum.ActivityStatus.None then
    WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
    return
  end
  if not ACU.IsOpenForDoing(ac) then
    WU.ShowHintText(WU.GetString("Window_Activity_Close"))
    return
  end
  local record = ref["@record"]
  if not record.unlocked then
    WU.ShowHintText(WU.GetString("Error_MustFinishPreDun"))
    return
  end
  local dungeonId = record.dungeonId
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  local _, cartoon = PB.all("CartoonConfig"):find(function(k, v)
    return v.dungeonId == ref["@dungeonId"]
  end)
  if dungeonReward.unlockLevel and this:GetData("fci/baseinfo/").level < dungeonReward.unlockLevel then
    WU.ShowHintText(WU.GetString("EventActivity_Level_Not_Enough", dungeonReward.unlockLevel))
    return
  end
  this:SetData("WindowDungeon/WheelMode", ref["@dungeonId"] ~= ref["@balanceDungeonId"])
  this:SetData("EventActivity/CurrentActivity", ref["@activity"])
  this:SetData("WindowDungeon/DungeonId", ref["@dungeonId"])
  this:SetData("ActorGroup/DungeonType", dungeonReward.type)
  this:SetData("MaidCafe/ScrollPos/" .. m_currentDungeonMode, REF.ScrollView.transform.localPosition.x)
  if cartoon and not IsCartoonPlayed(cartoon.id) then
    PlayCartoon(cartoon.id)
  else
    WU.AcquireWindowAsync("EventStagePrepare")
  end
end

function IsCartoonPlayed(cartoonId)
  if cartoonId == nil or cartoonId == 0 then
    return true
  end
  local data = DB:GetData("activityViewed") or {}
  local id = tonumber(cartoonId .. m_curNormalActivityId)
  if data[PB.enum.ActivityType.MaidCafe_DaemonMode] and data[PB.enum.ActivityType.MaidCafe_DaemonMode][id] and data[PB.enum.ActivityType.MaidCafe_DaemonMode][id].redpointValue then
    return true
  end
  return false
end

function PlayCartoon(cartoonId)
  local id = tonumber(cartoonId .. m_curNormalActivityId)
  ACU.MarkActivityViewed(PB.enum.ActivityType.MaidCafe_DaemonMode, id)
  WU.EnterCartoonLevel(cartoonId, "Welfare,EventMaidCafeStage,EventStagePrepare", "Welfare/MaidCafe")
end

function OnStarRewardsChange(info)
  if info == nil then
    return
  end
  local rewardsInfo = info.rewardSummary
  local totalStar = rewardsInfo[m_curNormalActivityId].totalStar
  table.sort(m_starRewardList, function(a, b)
    return a.star < b.star
  end)
  local maxStars = m_starRewardList:last().star
  local count = m_starRewardList:count()
  local nextIndex, next = table.find(m_starRewardList, function(k, v)
    return v.star >= totalStar
  end)
  local nextStar = next.star
  local preIndex = nextIndex - 1
  local preStar
  if nextIndex == 1 then
    preStar = 0
  else
    preStar = m_starRewardList[nextIndex - 1].star
  end
  local progress = preIndex / count + 1 / count * (totalStar - preStar) / (nextStar - preStar)
  REF.Progress.UIProgressBar.value = progress
  for i = 0, #REF.StarRewardsGrid - 1 do
    local ref = REF.StarRewardsGrid[i]
    WU.SetActive(ref.root, i < count)
    if i < count then
      local x = REF.Progress.UISprite.width / count * (i + 1)
      local y = ref.root.transform.localPosition.y
      ref.root.transform.localPosition = {
        x = x,
        y = y,
        z = 1
      }
      SetStarRewardsView(ref, rewardsInfo, i)
    end
  end
  WU.SetActive(REF.StarRewardsProgress, true)
end

function SetStarRewardsView(ref, rewardsInfo, index)
  local reward = m_starRewardList[index + 1]
  local targetStar = reward.star
  local rewardsGotList = _ENV["!"](rewardsInfo[m_curNormalActivityId].rewardGot)
  local totalStar = rewardsInfo[m_curNormalActivityId].totalStar
  local rewardGot = rewardsGotList:has(targetStar)
  local canReward = targetStar <= totalStar and not rewardGot
  ref["@canReward"] = canReward
  ref["@rewardGot"] = rewardGot
  ref["@star"] = targetStar
  ref["@index"] = index + 1
  if canReward then
    ref.Glow.EffectGenerator.m_EffectName = "UI_Cafe"
  end
  WU.SetActive(ref.Glow, canReward)
  WU.SetActive(ref.Icon, not canReward)
  if rewardGot then
    ref.Icon.UISprite.spriteName = "coffee_01"
  else
    ref.Icon.UISprite.spriteName = "coffee_03"
  end
  ref.Icon.UISprite:MakePixelPerfect()
  ref.Label.UILabel.text = targetStar
end

function OnClickStarReward(go)
  local ref = _ENV["$"](go)
  local path = "fci/activity/star-reward/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curNormalActivityId
  local rewardsInfo = this:GetData(path).rewardSummary[m_curNormalActivityId]
  if ref["@canReward"] then
    this:GameRequest(path):Post({
      star = ref["@star"]
    }, function(resp)
      table.insert(rewardsInfo.rewardGot, ref["@star"])
      this:SetData(path, this:GetData(path))
      DBH.ResChange(resp.resChange)
      WU.ShowRewards(resp.resChange)
    end)
  elseif ref["@index"] then
    local reward = m_starRewardList[ref["@index"]].reward
    local title = WU.GetString("MaidCafe_StarRewardsTitle")
    local buttonTitle
    local content = ""
    if ref["@rewardGot"] then
      buttonTitle = WU.GetString("WindowGacha_Close")
    else
      content = WU.GetString("MaidCafe_StarRewardsHint", rewardsInfo.totalStar, ref["@star"])
    end
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](reward, title, content, ref["@rewardGot"], buttonTitle)
    end)
  end
end

function OnClickCollection()
  WU.AcquireWindowAsync("JourneyStory", function()
    this:SetData("JourneyStory/Type", PB.enum.CartoonStoryType.EventActivity)
    this:SetData("JourneyStory/Entrance", {
      window = "Welfare,EventMaidCafeStage,JourneyStory",
      extra = "Welfare/MaidCafe"
    })
  end)
end

function UpdateWindow(delta)
  local deltaPosX = REF.ScrollView.transform.localPosition.x - m_initDragPos
  local newPosX = REF.StarRewardsProgress.transform.localPosition.x + deltaPosX
  newPosX = math.clamp(deltaPosX, m_progressBarClamp.left, m_progressBarClamp.right)
  REF.StarRewardsProgress.transform.localPosition = {
    x = newPosX,
    y = REF.StarRewardsProgress.transform.localPosition.y,
    z = 0
  }
end

function OnClickChangeDungeonMode()
  local mode = fif(m_currentDungeonMode == 1, 2, 1)
  local status, ac
  if mode == 2 then
    if m_curHardActivityId then
      ac = m_activityManager.GetActivitySync(PB.enum.ActivityType.MaidCafe_DaemonMode, m_curHardActivityId)
    end
    if ac.timestampStart <= CS.GameTime.serverUtc then
      this:SetData("MaidCafe/CurrentDungeonMode", mode)
    else
      WU.ShowHintText(WU.GetString("Activity_DungeonIsNotUnlock"))
    end
  else
    this:SetData("MaidCafe/CurrentDungeonMode", mode)
  end
end

function OnCurrentDungeonMode(dungeonMode)
  if dungeonMode == nil then
    dungeonMode = 1
  end
  m_currentDungeonMode = dungeonMode
  WU.SetActive(REF.StarRewardsProgress, dungeonMode == 1)
  WU.SetActive(REF.NormalDungeons, dungeonMode == 1)
  WU.SetActive(REF.HardDungeons, dungeonMode == 2)
  REF.ScrollView.UIScrollView:ResetPosition()
  REF.TextureBg.UITexture.width = dMode[dungeonMode].BGSize.width
  REF.TextureBg.UITexture.height = dMode[dungeonMode].BGSize.height
  REF.TextureBg.UITexture.mainTexturePath = dMode[dungeonMode].BG
  REF.ModeChange.UISprite.spriteName = dMode[dungeonMode].spriteName
  local scrollPos = this:GetData("MaidCafe/ScrollPos/" .. m_currentDungeonMode)
  if scrollPos then
    REF.ScrollView.UIScrollView:ResetPosition()
    REF.ScrollView.UIScrollView:MoveRelative({
      x = scrollPos - m_initDragPos,
      y = 0,
      z = 0
    })
    REF.ScrollView.UIScrollView:RestrictWithinBounds(true)
  end
end

function InitDungeons(activity, isNormal)
  if activity == nil then
    return
  end
  local activityId = activity.activityId
  local dungeonInfo = PB.get("EventDungeon", activityId, PB.enum.ActivityType.MaidCafe_DaemonMode)
  if dungeonInfo == nil then
    warnging("No Dungeon Info with activity " .. activityId)
    return
  end
  local dungeonRef = fif(isNormal, _ENV["$"](REF.NormalDungeons), _ENV["$"](REF.HardDungeons))
  local dungeonList = {}
  for _, v in pairs(dungeonInfo.dungeonId) do
    if not _ENV["!"](dungeonInfo.hideDungeonId):has(v) then
      table.insert(dungeonList, v)
    end
  end
  for i = 1, #dungeonList do
    local ref = _ENV["$"](dungeonRef["Dungeon" .. i])
    local balanceDungeon = DU.GetBalanceDungeon(dungeonList[i])
    ref["@dungeonId"] = dungeonList[i]
    ref["@balanceDungeonId"] = balanceDungeon
    ref["@normal"] = isNormal
    ref["@activity"] = activity
  end
  if isNormal then
    m_normalDungeonList = dungeonList
    if m_curNormalActivityId then
      this:Unbind("fci/activity/record/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curNormalActivityId, OnRecordChangeNormal)
      this:Unbind(string.format("fci/activity/star-reward/%s/%s", PB.enum.ActivityType.MaidCafe_DaemonMode, m_curNormalActivityId), OnStarRewardsChange)
    end
    m_curNormalActivityId = activityId
    this:BindRemote(DB:GameRequest("fci/activity/record/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curNormalActivityId), OnRecordChangeNormal)
    this:BindRemote(DB:GameRequest("fci/activity/star-reward/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curNormalActivityId), OnStarRewardsChange)
  else
    m_hardDungeonList = dungeonList
    if m_curHardActivityId then
      this:Unbind("fci/activity/record/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curHardActivityId, OnRecordChangeHard)
    end
    m_curHardActivityId = activityId
    this:BindRemote(DB:GameRequest("fci/activity/record/" .. PB.enum.ActivityType.MaidCafe_DaemonMode .. "/" .. m_curHardActivityId), OnRecordChangeHard)
  end
end

function OnRecordChangeNormal(data)
  OnRecordChange(true, m_curNormalActivityId, data)
end

function OnRecordChangeHard(data)
  OnRecordChange(false, m_curHardActivityId, data)
end
