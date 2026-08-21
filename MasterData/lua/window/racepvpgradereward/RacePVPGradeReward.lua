local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_curGrade

function InitWindow()
  local allSeg = PB.all("RacePVPSeg")
  m_curGrade = this:GetData("fci/RacePVPInfo").grade
  local index, _ = allSeg:find(function(k, v)
    return v.id == m_curGrade.id
  end)
  local realIndex = #allSeg - index
  SetSeasonReward()
  SetGradeReward()
  REF.ScrollView.UIScrollView:ResetPosition()
  if 1 < realIndex then
    local itemHeight = REF.Grades.UIGrid.cellHeight
    local gradeSeasonRewardHeight = REF.GradeSeasonReward.UIWidget.height
    local GradeTitleHeight = REF.GradeTitle.UIWidget.height
    local paddingHeight = REF.Table.UITable.padding.y
    local m_moveDistance = realIndex * itemHeight + gradeSeasonRewardHeight + GradeTitleHeight + paddingHeight * 2
    REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    REF.ScrollView.UIScrollView:RestrictWithinBounds(true)
  end
end

function SetSeasonReward()
  for i = 1, #REF.ItemContainer do
    local reward = PB.get("RacePVPSegReward", i).rewards[1]
    local item = REF.ItemContainer[i - 1]
    item.LabelGradeName.UILabel.text = WU.GetString("PVPREALRACE_GRADE_" .. i .. "_1")
    item.WidgetIconSlotTask["$SetData"](reward.type, reward.id, reward.count)
    item.WidgetIconSlotTask["$SetNameVisible"](false)
  end
end

function SetGradeReward()
  for i = 1, #REF.Grades do
    local index = #REF.Grades - i + 1
    local data = PB.get("RacePVPSeg", index)
    local item = REF.Grades[i - 1]
    WU.SetActive(item.root, data ~= nil)
    if data ~= nil then
      local bgColor = fif(data.id == m_curGrade.id, CS.NGUIMath.HexToColor(989855678), CS.NGUIMath.HexToColor(4294967295))
      item.BgLeft.UISprite.color = bgColor
      item.BgRight.UISprite.color = bgColor
      item.LabelTitle.UILabel.text = WU.GetString("PVPREALRACE_GRADE_" .. data.seg .. "_" .. data.subSeg)
      item.Icon.UISprite.spriteName = "rank_icon_" .. data.seg .. "_s"
      for j = 1, #item.RewardList do
        local slot = item.RewardList[j - 1]
        local reward = data.rewards[j]
        slot.root.gameObject:SetActive(reward ~= nil)
        if reward ~= nil then
          slot.root["$SetData"](reward.type, reward.id, reward.count)
        end
      end
      item.RewardList.UIGrid:Reposition()
    end
  end
  REF.Grades.UIGrid:Reposition()
end
