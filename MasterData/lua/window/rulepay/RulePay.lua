local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")

function SetupWindow()
  for idx = 1, #REF.TabGrid - 1 do
    local ref = REF.TabGrid[idx]
    local gasket = ref.root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.Toggle.current.value then
        local stringIdx = idx + 1
        REF.Description.UIHtmlLabel.text = WU.GetString("Error_Description" .. stringIdx)
        REF.ScrollViewHelpE.UIScrollView:ResetPosition()
      end
    end)
  end
end

function InitWindow()
end

function UninitWindow()
end
