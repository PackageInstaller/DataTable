local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_resMazePointCount
local m_levelExpList = PB.all("MazeResearchLevel")
local m_allRelic = PB.all("MazeEquipmentInfo")
local m_mazeActivityId

function SetupWindow()
  REF.WidgetTabSlotRelic["$SetTab"](WU.GetString("Maze_Relic"), "ChaoticSpace", "sacred")
  REF.WidgetTabSlotBag["$SetTab"](WU.GetString("Maze_Store"), "ChaoticSpace", "warehouse")
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  REF.TabWrapContent[0].root.UIToggle.value = true
  _ENV["$"](REF.WidgetMazeRelic).ScrollView.gameObject:SetActive(false)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](function()
    OnNavigation(false)
  end)
  _ENV["$"](nav)["$$SetHomeCallback"](function()
    OnNavigation(true)
  end)
end

function UninitWindow()
  local nav = WU.FindWindow("Navigation")
  if nav then
    _ENV["$"](nav)["$$Load"]()
  end
end

function OnNavigation(isHome)
  if isHome then
    WU.RecycleWindow("MazeInterEvent")
    this:BroadcastGameEvent("OnNavigation", "City")
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function RefreshTab()
  for i = 1, #REF.TabWrapContent do
    REF.TabWrapContent[i - 1].root.UIToggle.optionCanBeNone = true
    REF.TabWrapContent[i - 1].root.UIToggle.value = false
    REF.TabWrapContent[i - 1].root.UIToggle.optionCanBeNone = false
  end
end
