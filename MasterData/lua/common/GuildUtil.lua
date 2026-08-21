local WU, DB = require("Common/WindowUtil")()
local U = require("Common/Util")
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local GU = {}

function GU.IsGuildPresident(guildPlayer)
  guildPlayer = guildPlayer or DB:GetData("fci/guild-player")
  return guildPlayer and guildPlayer.type == PB.enum.GuildMemberType.President
end

function GU.IsGuildVicePresident(guildPlayer)
  guildPlayer = guildPlayer or DB:GetData("fci/guild-player")
  return guildPlayer and guildPlayer.type == PB.enum.GuildMemberType.VicePresident
end

function GU.IsGuildManager(guildPlayer)
  return GU.IsGuildPresident(guildPlayer) or GU.IsGuildVicePresident(guildPlayer)
end

function GU.CheckFunctionCD(messageTag)
  local guildPlayer = DB:GetData("fci/guild-player")
  local result = guildPlayer and guildPlayer.limitEndTime <= CS.GameTime.serverUtc
  if not result and messageTag then
    local timeLeft = math.max(0, guildPlayer.limitEndTime - CS.GameTime.serverUtc)
    WU.ShowMessageOK(WU.GetString(messageTag, WU.RenderTimeSpan(timeLeft, 32)))
  end
  return result
end

function GU.CheckSupportRequestCD(silent)
  local guildPlayer = DB:GetData("fci/guild-player")
  local result = guildPlayer and guildPlayer.donateLimitEndTime <= CS.GameTime.serverUtc
  if not result and not silent then
    local timeLeft = math.max(0, guildPlayer.donateLimitEndTime - CS.GameTime.serverUtc)
    WU.ShowMessageOK(WU.GetString("Window_GuildSupportRequestCD", WU.RenderTimeSpan(timeLeft, 32)))
  end
  return result
end

function GU.CheckDungeonCD(silent)
  local guildPlayer = DB:GetData("fci/guild-player")
  local result = guildPlayer and guildPlayer.guildDungeonLimitEndTime <= CS.GameTime.serverUtc
  if not result and not silent then
    local timeLeft = math.max(0, guildPlayer.guildDungeonLimitEndTime - CS.GameTime.serverUtc)
    WU.ShowMessageOK(WU.GetString("Window_GuildDungeonRequestCD", WU.RenderTimeSpan(timeLeft, 32)))
  end
  return result
end

function GU.GetMemberName(playerId)
  local result = ""
  local members = DB:GetData("fci/guild/members/")
  local _, member = table.find(members, function(k, v)
    return v.playerId == playerId
  end)
  if member then
    result = member.name
  end
  return result
end

function GU.GetDonateInfo(request)
  local receivedCount = 0
  local bestDonorPlayerId
  if request then
    local maxDonateCount = 0
    for playerId, count in pairs(request.donatesCount) do
      receivedCount = receivedCount + count
      if count > maxDonateCount then
        maxDonateCount = count
        bestDonorPlayerId = playerId
      end
    end
  end
  return receivedCount, bestDonorPlayerId
end

function GU.IsDonateFull(request)
  local receivedCount = 0
  if request then
    for playerId, count in pairs(request.donatesCount) do
      receivedCount = receivedCount + count
    end
  end
  return receivedCount >= PB.index("GuildMisc", 1).donateMaxCount
end

function GU.IsGuildDungeonOn()
  local start = false
  local open = false
  local activityManager = S:Get("ActivityManager")
  local dungeonActivity = activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.GuildDungeonV2)
  local activityInfo = dungeonActivity and dungeonActivity[1]
  if activityInfo ~= nil then
    local now = CS.GameTime.serverNow
    local nowDay = U.ToInt(now.DayOfWeek)
    if nowDay == 0 then
      nowDay = 7
    end
    local nowSeconds = CS.GameTime.serverUtc
    local startTime = activityInfo.timestampStart
    local endTime = activityInfo.timestampEnd
    if nowSeconds >= startTime and (nowSeconds < endTime or endTime == 0) then
      start = true
      for i, v in pairs(activityInfo.weekdays) do
        if v == nowDay then
          open = true
          break
        end
      end
    end
  end
  return start, open
end

function GU.HandleGuildDungeonSummary(summary)
  if summary == nil then
    return false
  end
  if summary.hasHandled then
    return true
  end
  local activityManager = S:Get("ActivityManager")
  local dungeonActivity = activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.GuildDungeonV2)
  if dungeonActivity == nil or dungeonActivity[1] == nil then
    warning("Activity not open but player enters the guild Dungeon!")
    return
  end
  local activityId = dungeonActivity[1].activityId
  local _, cDungeonRecord = table.find(summary.dungeonRecords, function(k, v)
    return v.dungeonType == PB.enum.DungeonType.ChallengeGuild
  end)
  if cDungeonRecord == nil then
    warning("DungeonGuild", "Lack challenge dungeon info in summary")
    return false
  end
  if cDungeonRecord.dungeonId == nil or cDungeonRecord.dungeonId == 0 then
    warning("DungeonGuild", "Lack challenge dungeon id in summary")
    return false
  end
  local cDungeonConfig = PB.get("GuildDungeon", cDungeonRecord.dungeonId, activityId)
  local dungeonConfigs = PB.all("GuildDungeon"):where(function(k1, v1)
    return v1.dungeonType == PB.enum.DungeonType.AssistGuild and v1.activityId == activityId
  end):toarray()
  table.sort(dungeonConfigs, function(a, b)
    return a.openDay < b.openDay
  end)
  local dungeonList = _ENV["!"]({})
  local isAllAssistDungeonPass = true
  for i = 1, #dungeonConfigs do
    local dungeonConfig = dungeonConfigs[i]
    if i == 5 then
      dungeonConfig.assistBuffId = cDungeonConfig.otherAssistBuffId
      dungeonConfig.buffSprite = cDungeonConfig.buffSprite
    end
    local _, dungeonRecord = table.find(summary.dungeonRecords, function(k, v)
      return v.dungeonId == dungeonConfig.dungeonId
    end)
    if dungeonRecord == nil then
      dungeonRecord = {
        progress = 0,
        dungeonType = PB.enum.DungeonType.AssistGuild,
        dungeonId = dungeonConfig.dungeonId,
        isFinished = false
      }
      isAllAssistDungeonPass = false
    elseif dungeonRecord.isFinished ~= true then
      isAllAssistDungeonPass = false
    end
    dungeonRecord.config = dungeonConfig
    dungeonRecord.isOpen = true
    table.insert(dungeonList, dungeonRecord)
  end
  cDungeonRecord.config = cDungeonConfig
  cDungeonRecord.isOpen = isAllAssistDungeonPass
  table.insert(dungeonList, cDungeonRecord)
  summary.dungeonRecords = dungeonList
  if summary.contribution == nil then
    summary.contribution = {}
  end
  if summary.challengeRecord == nil then
    summary.challengeRecord = {}
  end
  if summary.playerRentInfo == nil then
    summary.playerRentInfo = {}
  end
  local totalContribution = summary.contribution.contributionDegree or 0
  local rentContribution = summary.playerRentInfo.earnedScore or 0
  summary.contribution.fightContributionDegree = totalContribution - rentContribution
  summary.hasHandled = true
  return true
end

function GU.UpdateGuildDungeonRedPoint(closeAll)
  local summary = DB:GetData("DungeonGuild/Summary")
  local loginRedPointInfo = DB:GetData("DungeonGuild/RedPoint")
  if closeAll or summary == nil and loginRedPointInfo == nil then
    RU.SetRedMark("Relation/Guild/Dungeon/Contribution", false)
    RU.SetRedMark("Relation/Guild/Dungeon/ChallengePass", false)
    RU.SetRedMark("Relation/Guild/Dungeon/ChallengeScore", false)
    return
  end
  local currentScore, rewardGot, flag
  if summary == nil then
    currentScore = loginRedPointInfo.contribution
  else
    currentScore = summary.contribution and summary.contribution.contributionDegree
  end
  currentScore = currentScore or 0
  local contributionReward = DB:GetData("fci/guild-dungeon/v2/contribution/reward/")
  if contributionReward or loginRedPointInfo then
    if contributionReward == nil then
      rewardGot = loginRedPointInfo.contributionRewardGot
    else
      rewardGot = contributionReward.rewardRecords
    end
  end
  rewardGot = rewardGot or _ENV["!"]({})
  local rewards = PB.all("GuildDungeonContributionReward"):where(function(k, v)
    return v.score <= currentScore
  end):toarray()
  for i = 1, #rewards do
    local target = rewards[i].score
    local _, v = table.find(rewardGot, function(k, v)
      return v == target
    end)
    if v == nil then
      flag = true
      break
    end
  end
  RU.SetRedMark("Relation/Guild/Dungeon/Contribution", flag)
  local isFinish
  local challengeReward = DB:GetData("fci/guild-dungeon/v2/challenge-score/reward/")
  if summary == nil then
    isFinish = loginRedPointInfo.isChallengeFinish
  else
    isFinish = summary.dungeonRecords[6].isFinished
  end
  if challengeReward ~= nil then
    rewardGot = challengeReward.rewardRecords
  elseif loginRedPointInfo ~= nil then
    rewardGot = loginRedPointInfo.challengeRewardGot
  end
  rewardGot = rewardGot or _ENV["!"]({})
  local _, v = table.find(rewardGot, function(k, v)
    return v == 0
  end)
  flag = isFinish and not v
  RU.SetRedMark("Relation/Guild/Dungeon/ChallengePass", flag)
  if flag ~= true then
    local cDungeonId
    if summary == nil then
      currentScore = loginRedPointInfo.totalChallengeScore
      cDungeonId = loginRedPointInfo.challengeDungeonId
    else
      currentScore = summary.challengeTotalScore
      cDungeonId = summary.dungeonRecords[6].dungeonId
    end
    currentScore = currentScore or 0
    rewards = PB.all("GuildDungeonChallengeScoreReward"):where(function(k, v)
      return v.score <= (currentScore or 0) and v.dungeonId == cDungeonId
    end):toarray()
    for i = 1, #rewards do
      local target = rewards[i].score
      if target ~= 0 then
        do
          local _, v = table.find(rewardGot, function(k, v)
            return v == target
          end)
          if v == nil then
            flag = true
            break
          end
        end
      end
    end
  end
  RU.SetRedMark("Relation/Guild/Dungeon/ChallengeScore", flag)
end

return GU
