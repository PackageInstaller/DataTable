inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_id, m_count, m_type, m_data

function ResetState()
  REF.SpriteUp.gameObject:SetActive(false)
  REF.ShowBeatBonus.gameObject:SetActive(false)
  m_id = nil
  m_count = nil
  m_type = nil
  m_data = nil
end

function Draw()
  if m_type ~= nil then
    local resourceQuality = PB.get("ResourceQuality", m_type)
    local quality = 0
    if resourceQuality then
      quality = resourceQuality.quality
    else
      error("ResourceQuality", "Cannot find ResourceQuality by type: " .. tostring(m_type))
    end
    REF.SpriteIconBG.UISprite.spriteName = "icon_bg_" .. quality
    REF.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/" .. PB.enum.ResourceType.__keys[m_type] .. "_" .. (m_id or 0)
  end
  if m_count ~= nil then
    REF.LabelBottomRight.UILabel.text = m_count
    REF.LabelBottomRight.gameObject:SetActive(true)
  else
    REF.LabelBottomRight.gameObject:SetActive(false)
  end
  if m_data ~= nil then
    REF.SpriteUp.gameObject:SetActive(m_data.dropUp or false)
    REF.ShowBeatBonus.gameObject:SetActive(m_data.showBeat or false)
  end
end

function SetData(id, count, type)
  m_id = id
  m_count = count
  m_type = type
  MarkAsDirty()
end

function ShowCustom(data)
  m_data = data
  MarkAsDirty()
end
