local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_initNodeTalentPos, m_initNodeDescPos

function SetupWindow()
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        REF.LabelHelp.UIHtmlLabel.text = WU.GetString("Help_" .. go.name)
        REF.ScrollViewHelp.UIScrollView:ResetPosition()
      end
    end)
  end)
end

function InitWindow()
  local activeTab = this:GetData("ActorInfoTab")
  REF[activeTab].UIToggle.value = true
  REF.ScrollViewTab.UIScrollView:ResetPosition()
  local index = REF[activeTab].transform:GetSiblingIndex()
  if 4 < index then
    local itemHeight = REF.TabGrid.UIGrid.cellHeight
    local m_moveDistance = index * itemHeight
    REF.ScrollViewTab.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, m_moveDistance, 0))
    REF.ScrollViewTab.UIScrollView:RestrictWithinBounds(true)
  end
end
