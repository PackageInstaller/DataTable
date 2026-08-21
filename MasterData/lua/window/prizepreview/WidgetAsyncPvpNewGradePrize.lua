local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_config
local m_segList = {}
local m_currentSelect = 0
local m_oldPositionY, m_startPositionY

function SetConfig(config)
  m_config = config
  m_segList = PB.all("AsyncPvpRankReward")
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateWidget
  })
  m_startPositionY = REF.ScrollView.UIScrollView.transform.localPosition.y - 87
  m_currentSelect = 0
  LU.Set(REF.WrapContent, #m_segList)
  REF.ToggleWeeklyReward["$SetClickCallback"](function()
    OnTabChange(0)
  end)
  REF.ToggleGradeReward["$SetClickCallback"](function()
    OnTabChange(1)
  end)
  SetSeasonReward()
end

function UpdateWidget(refRow, wrapIndex, rowIndex)
  if rowIndex == nil then
    return
  end
  local trueIndex = fif(m_currentSelect == 0, rowIndex + 1, rowIndex + 2)
  local currentSeg = m_segList[trueIndex]
  local rewards = fif(m_currentSelect == 0, currentSeg.weekRewards, currentSeg.disposableRewards)
  refRow.Icon.UISprite.spriteName = "icon_" .. currentSeg.segRank
  refRow.SpriteSeg.UISprite.spriteName = "illusion_level_" .. currentSeg.segRank
  refRow.SpriteSubSeg.UISprite.spriteName = "level_" .. currentSeg.subSegRank
  local rewardList = refRow.RewardList
  local activeCount = #rewards
  local isDynamicSet = activeCount < #rewardList
  if isDynamicSet then
    local gridWidth = rewardList.UIGrid.cellWidth
    local displacementX = gridWidth / activeCount
    rewardList.transform.localPosition = CS.UnityEngine.Vector3(displacementX, 0, 0)
  end
  WU.TraverseChildren(rewardList, function(go, index)
    local ref = _ENV["$"](go)
    local realIndex = index + 1
    local reward = rewards[realIndex]
    WU.SetActive(ref["$"], reward ~= nil)
    if reward ~= nil then
      ref["$$SetData"](reward.type, reward.id, reward.count)
      local isFrame = reward.type == PB.enum.ResourceType.ResPlayerHeadFrame
      WU.ToggleRendering(ref.SpriteIconBG, not isFrame)
      ref.Content.transform.localScale = fif(isFrame, {
        x = 1.3,
        y = 1.3,
        z = 1
      }, {
        x = 1,
        y = 1,
        z = 1
      })
    end
  end)
end

function OnTabChange(change)
  if m_currentSelect == change then
    return
  end
  m_currentSelect = change
  local scrollView = REF.ScrollView.UIScrollView
  local tempPosition = scrollView.transform.localPosition.y - m_startPositionY
  m_currentSelect = change
  LU.Set(REF.WrapContent, fif(change == 1, #m_segList - 1, #m_segList))
  if m_oldPositionY ~= nil then
    scrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_oldPositionY, 0))
    scrollView:RestrictWithinBounds(true)
  end
  m_oldPositionY = tempPosition
end

function SetSeasonReward()
  local iconSlot = _ENV["$"](REF.Left).WidgetIconSlot
  WU.SetActive(iconSlot, false)
  local baseInfo = this:GetData("AsyncPvpNew/BaseInfo")
  local currentGrade = math.clamp(baseInfo.curSeg, 1, #m_segList)
  if m_segList[currentGrade] == nil then
    return
  end
  local rewards = m_segList[currentGrade].weekRewards
  for i = 1, #rewards do
    if rewards[i].type == PB.enum.ResourceType.ResPlayerHeadFrame then
      WU.SetActive(iconSlot, true)
      iconSlot["$SetData"](rewards[i].type, rewards[i].id, rewards[i].count)
      WU.SetActive(_ENV["$"](iconSlot).SpriteIconBG, false)
      break
    end
  end
end
