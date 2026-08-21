inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_callback, m_custom, m_count

function ResetState()
  m_count = 0
  REF.LabelCount.gameObject:SetActive(true)
end

function Draw()
  if m_count then
    if m_count ~= 0 then
      REF.LabelCount.UIHtmlLabel.text = m_count
    else
      REF.LabelCount.gameObject:SetActive(false)
    end
  end
end

function SetData(id, count, type)
  ResetState()
  m_count = count
  MarkAsDirty()
end

function OnClick()
  if m_callback then
    m_callback()
  end
end
