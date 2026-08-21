local WU, DB, REF = require("Common/WindowUtil")(this)
local m_callback

function Start()
  WU.BindButtonEvent(REF["$"], OnClick)
  WU.BindKeyEvent(REF["$"], OnKey)
end

function SetCallback(callback)
  m_callback = callback
end

function OnClick()
  WU.RecordButtonClick(989)
  if m_callback ~= nil then
    m_callback()
  else
    local attachedWindow = REF["$"]:queryParent("UILuaWindow")
    if attachedWindow ~= nil then
      WU.RecycleWindow(attachedWindow)
    end
  end
end

function OnKey(go, keycode)
  OnClick()
end
