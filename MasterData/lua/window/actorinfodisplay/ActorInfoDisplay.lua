local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local SE = require("Common/SkillEffect")
local m_tabName
local m_repeatedContext = {}

function SetupWindow()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        this:SetData("ActorInfoTab", go.name)
      end
    end)
  end)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_tabName)
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local tabName = m_repeatedContext[#m_repeatedContext]
    table.remove(m_repeatedContext, #m_repeatedContext)
    SetSelectedTab(tabName)
  end
end

function InitWindow()
  ShowAllTab()
  this:Bind("Space/DisplayInfo", function(displayInfo)
    if displayInfo then
      REF.WidgetActorBarDisplay["$OnActorChange"](displayInfo.actorInfo, displayInfo.equips)
      this:SetData("ActorInfo/CurrentActorDisplay", displayInfo.actorInfo)
    end
  end)
  this:RegisterGameEvent("EventSwitchTab", function(tabName)
    SetSelectedTab(tabName)
  end)
  this:SetData("UseGenericChipForTalentReset", nil)
end

function SetSelectedTab(tabName)
  local len = #REF.TabGrid
  for i = 0, len - 1 do
    REF.TabGrid[i]["$UIToggle"].optionCanBeNone = true
    REF.TabGrid[i]["$UIToggle"].value = false
    REF.TabGrid[i]["$UIToggle"].optionCanBeNone = false
  end
  REF[tabName].UIToggle.value = true
  m_tabName = tabName
end

function Focus(on)
  if on then
    WU.SetWindowTitle("ActorInfoDisplay", "ActorInfo")
  end
end

function HideTab(tabName)
  REF[tabName].gameObject:SetActive(false)
end

function ShowAllTab()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    gasket.gameObject:SetActive(true)
  end)
end
