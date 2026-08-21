inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_id = 0

function ResetState()
end

function Draw()
  local img = PB.get("ChatImage", 1, m_id)
  REF.SpriteIconBG.UISprite.spriteName = "icon_bg_0"
  if img ~= nil then
    REF.SpriteIcon.UISprite.atlasPath = img.atlas
    REF.SpriteIcon.UISprite.spriteName = img.sprite
  else
    error("ChatImage.xlsx", " type 1 id " .. tostring(m_id))
  end
end

function SetData(id)
  if id < 0 then
    CustomId(id)
    return
  end
  m_id = id
  MarkAsDirty()
end

function CustomId(id)
end
