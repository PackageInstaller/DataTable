inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local m_id

function ResetState()
  m_id = nil
end

function Draw()
  if m_id and 0 < m_id then
    local equipInfo = PB.get("EquipInfo", m_id)
    if equipInfo then
      REF.TextureIcon.UITexture.mainTexturePath = "Texture/EquipIcon/" .. equipInfo.icon
      REF.SpriteEquipPos.UISprite.spriteName = EU.EquipPosSpriteNameTable[equipInfo.pos + 1]
    else
      error("EquipInfo", "Cannot find EquipInfo by id: " .. tostring(m_id))
    end
  end
end

function SetData(id)
  m_id = id
  MarkAsDirty()
end
