local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local m_allAwards, m_curAwards
local mTotalStar = 0
local mActivityId = 0
local mCurrentSummary = {}

function SetupWindow()
end

function InitWindow()
  local rewardSummary = this:GetData("Event/RewardSummary")
  local activityId = this:GetData("Event/ActivityId")
  mActivityId = activityId
  m_allAwards = PB.all("EventReward"):where(function(k, v)
    return v.activityId == activityId
  end):toarray():sort(function(a, b)
    return a.star < b.star
  end)
  if rewardSummary.rewardSummary then
    UpdateRewardSummary(rewardSummary.rewardSummary)
  end
  LU.Bind(REF.WrapContent, {
    updateRow = OnAwardItemShow
  })
  LU.Set(REF.WrapContent, #m_allAwards)
  ScrollToFirstReward()
end

function ScrollToFirstReward()
  local currentAwardIndex = 0
  local rewardNotFound = true
  for k, item in pairs(m_allAwards) do
    if item.isReachStar and not item.hasGotReward then
      rewardNotFound = false
      break
    else
      currentAwardIndex = currentAwardIndex + 1
    end
  end
  if rewardNotFound then
    currentAwardIndex = 0
  end
  local itemHeight = REF.WrapContent.UIWrapContent.itemSize
  if 1 < currentAwardIndex then
    currentAwardIndex = currentAwardIndex - 0.5
  end
  local moveDistance = currentAwardIndex * itemHeight
  if moveDistance < 0 then
    moveDistance = 0
  end
  REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, moveDistance, 0))
  REF.ScrollView.UIScrollView:RestrictWithinBounds(true)
end

function IsRewardGot(star)
  if mCurrentSummary then
    for k, v in pairs(mCurrentSummary.rewardGot) do
      if v == star then
        return true
      end
    end
  end
  return false
end

function UpdateSummaryImpl()
  if m_allAwards == nil then
    return
  end
  if mCurrentSummary then
    mTotalStar = fif(mCurrentSummary.totalStar, mCurrentSummary.totalStar, 0)
    REF.LabelStarCount.UILabel.text = mTotalStar
    for k, item in pairs(m_allAwards) do
      item.isReachStar = mTotalStar >= item.star
      item.hasGotReward = IsRewardGot(item.star)
    end
  else
    REF.LabelStarCount.UILabel.text = "0"
    for k, item in pairs(m_allAwards) do
      item.isReachStar = false
      item.hasGotReward = false
    end
  end
end

function UpdateRewardSummary(rewardSummary)
  if m_allAwards == nil then
    return
  end
  mCurrentSummary = rewardSummary[mActivityId]
  UpdateSummaryImpl()
end

function OnAwardItemShow(rowRef, wrapIndex, realIndex)
  if realIndex < 0 or m_allAwards == nil or realIndex >= #m_allAwards then
    return
  end
  local awards = m_allAwards[realIndex + 1]
  local hasGotReward = awards.hasGotReward
  local reachReward = awards.isReachStar
  rowRef.StarNumber.UILabel.text = awards.star
  for i = 0, #rowRef.Grid - 1 do
    if awards.reward == nil then
      rowRef.Grid[i].root.gameObject:SetActive(true)
      rowRef.Grid[i].root["$SetClickCallback"](nil)
    else
      rowRef.Grid[i].root.gameObject:SetActive(i < #awards.reward)
      if i < #awards.reward then
        local award = awards.reward[i + 1]
        rowRef.Grid[i].root["$SetData"](award.type, award.id, award.count)
        rowRef.Grid[i].root["$SetClickCallback"](function()
          WU.ShowResourceDetail(award.type, award.id)
        end)
      end
    end
  end
  rowRef.Grid.UIGrid:Reposition()
  WU.ClearButtonEvent(rowRef.ButtonReward)
  if hasGotReward then
    rowRef.SpriteGet.gameObject:SetActive(true)
    rowRef.ButtonReward.gameObject:SetActive(false)
    WU.SetActive(rowRef.ButtonGrayGet, false)
  elseif reachReward then
    rowRef.SpriteGet.gameObject:SetActive(false)
    rowRef.ButtonReward.gameObject:SetActive(true)
    WU.SetActive(rowRef.ButtonGrayGet, false)
    WU.BindButtonEvent(rowRef.ButtonReward, function()
      OnRewardClick({
        star = awards.star
      })
    end)
  else
    rowRef.SpriteGet.gameObject:SetActive(false)
    rowRef.ButtonReward.gameObject:SetActive(false)
    WU.SetActive(rowRef.ButtonGrayGet, true)
  end
end

function OnRewardClick(param)
  local rewardParams = {
    activity_id = mActivityId,
    star = param.star
  }
  this:GameRequest("fci/event-dungeon/star-reward"):TimeOut(WU.GetDefaultHttpTimeOut):Post(rewardParams, function(response)
    DBH.ResChange(response.resChange)
    WU.ShowRewards(response.resChange)
    table.insert(mCurrentSummary.rewardGot, param.star)
    UpdateSummaryImpl()
    LU.Set(REF.WrapContent, #m_allAwards, false)
    local hasReward = DU.DoesEventActivityHasStarReward(this:GetData("Event/RewardSummary").rewardSummary, mActivityId)
    RU.SetRedMark(string.format("Activity/%s/%s/Reward", PB.enum.ActivityType.EventDungeon, mActivityId), hasReward)
  end)
end
