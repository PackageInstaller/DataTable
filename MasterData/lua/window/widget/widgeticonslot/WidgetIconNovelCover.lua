inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id

function ResetState()
  m_id = nil
end

function Draw()
  if m_id and 0 < m_id then
    REF.SpriteIcon.UISprite.spriteName = "book_" .. m_id
  end
end

function SetData(id)
  m_id = id
  MarkAsDirty()
end
