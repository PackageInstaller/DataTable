local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function SetupWindow()
end

function SetChannels(channels, callback)
  if 1 < #channels then
    local grid = REF.ChannelsGrid
    for i = 1, #grid do
      local widget = grid[i - 1]
      if i <= #channels then
        local channel = channels[i]
        widget.Text.UIHtmlLabel.text = WU.GetString("Purchase_Channel_" .. tostring(channel))
        WU.ClearButtonEvent(widget.Button)
        WU.BindButtonEvent(widget.Button, function()
          callback(channel)
          WU.RecycleWindow(this)
        end)
        widget["$gameObject"]:SetActive(true)
      else
        widget["$gameObject"]:SetActive(false)
      end
    end
    grid.UIGrid:Reposition()
    grid.UIGrid.repositionNow = true
  end
end
