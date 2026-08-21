inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id, m_callback, m_custom

function ResetState()
  m_id = nil
  REF.SpriteItemBg.UISprite.spriteName = "icon_bg_0"
  REF.SpriteEmptyPill.gameObject:SetActive(false)
  REF.SpriteGlobal.gameObject:SetActive(false)
end

function Draw()
  if m_id then
    if m_id ~= 0 then
      local pillInfo = PB.get("ExtremeChallengeBuffItem", m_id)
      if pillInfo then
        REF.NodeItem.gameObject:SetActive(true)
        REF.SpriteEmptyPill.gameObject:SetActive(false)
        REF.SpriteGlobal.gameObject:SetActive(pillInfo.isDragfastGlobal)
        REF.TexturePill.UITexture.mainTexturePath = "Texture/ItemIcon/Design_Page_" .. pillInfo.iconId
        REF.SpriteItemBg.UISprite.spriteName = "icon_bg_" .. pillInfo.quality
      else
        error("TowerPill", "Cannot findTowerPill by id: " .. tostring(m_id))
      end
    end
  else
    if m_custom and m_custom.notShowEmpty then
      REF.SpriteEmptyPill.gameObject:SetActive(false)
    else
      REF.SpriteEmptyPill.gameObject:SetActive(true)
    end
    REF.NodeItem.gameObject:SetActive(false)
  end
end

function SetData(id)
  ResetState()
  m_id = id
  MarkAsDirty()
end

function OnClick()
  if m_callback then
    m_callback()
  end
end

function ShowCustom(custom)
  m_custom = custom
end
