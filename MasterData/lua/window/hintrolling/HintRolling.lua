local WU, DB, REF = require("Common/WindowUtil")(this)
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local m_speedDivide = 300
local m_messages, m_index
local m_closed = true

function InitWindow()
end

function OnClose()
  m_messages = {}
  m_index = 1
  WU.ToggleRendering(REF["$"], false)
  m_closed = true
end

function ShowHintText(messages)
  if m_closed then
    WU.ToggleRendering(REF["$"], true)
    m_closed = false
    m_messages = messages
    m_index = 1
    NextText()
  else
    table.append(m_messages, messages)
  end
end

function NextText()
  local message = m_messages[m_index]
  if message == nil then
    OnClose()
  else
    local label = REF.LabelHint.UIHtmlLabel
    label.text = message.content
    local screenWidth = CS.UIBaseProcess.DesignWidth
    local from = CS.UnityEngine.Vector3(label.width / 2 + screenWidth / 2, 0, 0)
    local to = CS.UnityEngine.Vector3(-label.width / 2 - screenWidth / 2, 0, 0)
    local tp = REF.LabelHint.TweenPosition
    local go = REF.LabelHint.gameObject
    tp.from = from
    tp.to = to
    go.transform.localPosition = from
    tp.duration = (from - to).magnitude / m_speedDivide
    tp:ResetToBeginning()
    tp:PlayForward()
    m_index = m_index + 1
    CS.EventDelegate.Add(tp.onFinished, NextText)
  end
end
