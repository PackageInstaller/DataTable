local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_callback

function Start()
  WU.BindButtonEvent(REF["$"], OnSlotClick)
  SetHighlight(false)
end

function SetData(index)
  REF.SpriteIcon.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", index)
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetHighlight(value)
  REF.SpriteSelected.gameObject:SetActive(value)
end

function OnSlotClick()
  if m_callback then
    m_callback(REF["$gameObject"])
  end
end
