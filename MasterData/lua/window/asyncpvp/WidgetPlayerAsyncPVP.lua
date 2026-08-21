local WU, DB, REF = require("Common/WindowUtil")(this)
local m_callback

function Start()
  WU.BindButtonEvent(REF["$"], OnClick)
end

function OnClose()
end

function SetData(actorInfo)
  REF.LabelName.UILabel.text = actorInfo.name
  REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", actorInfo.level)
  WU.ToggleRendering(REF.NodeDefeated, actorInfo.isWin)
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](actorInfo)
end

function OnClick(go)
  if m_callback then
    m_callback()
  end
end

function SetClickCallback(callback)
  m_callback = callback
  REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](m_callback)
end
