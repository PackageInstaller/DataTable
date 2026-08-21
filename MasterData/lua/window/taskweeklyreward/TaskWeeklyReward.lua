local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local m_allData, m_info

function SetupWindow()
  m_allData = PB.all("WeekActivePointReward")
  WU.TraverseChildren(REF.Grid, function(go, i)
    WU.BindButtonEvent(REF.Grid[i].ButtonGet, OnGetRewardClick)
  end)
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/week-activepoint/"), OnWeeklyActivePointChange)
end

function OnWeeklyActivePointChange(info)
  m_info = info
  WU.TraverseChildren(REF.Grid, function(go, i)
    SetView(m_allData[i + 1], _ENV["$"](go))
  end)
end

function SetView(data, ref)
  _ENV["$"](ref.ButtonGet)["@weekActivePoint"] = data.activePoint
  ref.WidgetIconSlot["$SetData"](data.reward[1].type, data.reward[1].id, data.reward[1].count)
  ref.LabelProgress.UIHtmlLabel.text = m_info.weekActivePoint .. "/" .. data.activePoint
  local _, got = table.find(m_info.rewardGot, function(k, v)
    return v == data.activePoint
  end)
  WU.SetActive(ref.ButtonGet, m_info.weekActivePoint >= data.activePoint and got == nil)
  WU.SetActive(ref.SpriteGot, got ~= nil)
  WU.SetActive(ref.LabelProgress, m_info.weekActivePoint < data.activePoint)
end

function OnGetRewardClick(go)
  local ref = _ENV["$"](go)
  this:GameRequest("fci/week-activepoint/reward/"):Post({
    weekActivePoint = ref["@weekActivePoint"]
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    m_info.rewardGot = result.rewardGot
    this:SetData("fci/week-activepoint/", m_info)
  end)
end
