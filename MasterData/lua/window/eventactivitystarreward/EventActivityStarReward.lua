local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local ATU = require("Common/AutumnUtil")
local m_allAwards, m_curAwards, m_totalStar, m_activityType, m_activityId
local m_currentSummary = {}

function SetupWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = OnAwardItemShow
  })
end

function SetData(activityType, activityId)
  m_activityType = activityType
  m_activityId = activityId
  OnStarReward(this:GetData(string.format("fci/activity/star-reward/%s/%s", m_activityType, m_activityId)))
end

function OnStarReward(resp)
  if resp then
    local rewardSummary = resp.rewardSummary
    m_allAwards = PB.all("EventReward"):where(function(k, v)
      return v.activityId == m_activityId and v.activityType == m_activityType
    end):toarray():sort(function(a, b)
      return a.star < b.star
    end)
    if rewardSummary then
      UpdateRewardSummary(rewardSummary)
    end
    LU.Set(REF.WrapContent, #m_allAwards)
    this:DelayInvokeInFrames(2, ScrollToFirstReward)
  end
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
  if m_currentSummary then
    for k, v in pairs(m_currentSummary.rewardGot) do
      if v == star then
        return true
      end
    end
  end
  return false
end

function UpdateSummaryImpl(dataChanged)
  if m_allAwards == nil then
    return
  end
  if m_currentSummary then
    m_totalStar = m_currentSummary.totalStar
    REF.LabelStarCount.UILabel.text = m_totalStar
    for k, item in pairs(m_allAwards) do
      item.isReachStar = m_totalStar >= item.star
      item.hasGotReward = IsRewardGot(item.star)
    end
  else
    REF.LabelStarCount.UILabel.text = "0"
    for k, item in pairs(m_allAwards) do
      item.isReachStar = false
      item.hasGotReward = false
    end
  end
  if dataChanged then
    this:SetData(string.format("fci/activity/star-reward/%s/%s", m_activityType, m_activityId), {
      rewardSummary = {
        [m_activityId] = m_currentSummary
      }
    })
  end
end

function UpdateRewardSummary(rewardSummary)
  if m_allAwards == nil then
    return
  end
  m_currentSummary = rewardSummary[m_activityId]
  UpdateSummaryImpl(false)
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
        if award.type == PB.enum.ResourceType.ResMedal then
          local data = {name = false}
          rowRef.Grid[i].root["$ShowCustom"](data)
        end
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
    star = param.star
  }
  this:GameRequest(string.format("fci/activity/star-reward/%s/%s", m_activityType, m_activityId)):Post(rewardParams, function(resp)
    DBH.ResChange(resp.resChange)
    WU.ShowRewards(resp.resChange)
    table.insert(m_currentSummary.rewardGot, param.star)
    UpdateSummaryImpl(true)
    LU.Set(REF.WrapContent, #m_allAwards, false)
    ScrollToFirstReward()
  end)
end
