inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_id, m_callback

function ResetState()
  m_id = nil
end

function Draw()
  if m_id then
    REF.TextureHead.UITexture.mainTexturePath = "Texture/ItemIcon/head_frame_" .. m_id
  end
end

function SetData(id)
  ResetState()
  WU.SetActive(REF.SpriteIconBG, true)
  m_id = id
  MarkAsDirty()
end

function OnClick()
  if m_callback then
    m_callback()
  end
end
