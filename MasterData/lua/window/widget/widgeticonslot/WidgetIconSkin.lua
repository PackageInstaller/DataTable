inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local m_id, m_default, m_actorId, m_callback, m_custom

function ResetState()
  m_id = nil
  m_default = nil
  m_actorId = nil
  REF.SpriteIconBG.UISprite.alpha = 1
  REF.TextureHead.UITexture.alpha = 1
  REF.SpriteIconBG.UISprite.spriteName = "icon_bg_0"
  WU.ToggleRendering(REF.SpritePaletteBG, true)
end

function Draw()
  if m_id and m_id ~= 0 then
    local resActorSkin = PB.get("ActorSkin", m_id)
    if resActorSkin then
      local actorId, resConfig
      for i = 1, #resActorSkin.actorIds do
        local tResConfig = PB.get("ActorConfig", resActorSkin.actorIds[i])
        if tResConfig and (resActorSkin.ignoreActorOpenTime or AU.IsActorOpen(tResConfig.id, tResConfig.openTime)) then
          actorId = tResConfig.id
          resConfig = tResConfig
          break
        end
      end
      if resConfig ~= nil then
        REF.SpriteIconBG.UISprite.spriteName = "icon_bg_" .. resActorSkin.quality
        REF.TextureHead.UITexture.mainTexturePath = "Texture/ActorSkinHead/ActorSkinHead_" .. resConfig.skinUIRes
        local paletteIndex = AU.GetActorPaletteIndex(actorId, m_id)
        if paletteIndex then
          REF.SpritePaletteBG.UISprite.spriteName = "ActorSkin_number_" .. resActorSkin.displayIndex
        end
      else
        error("ActorSkin", string.format("Cannot find Actor by actorId: %s, skinId: %s", tostring(actorId), tostring(m_id)))
      end
    else
      error("ActorSkin", "Cannot find ActorSkin by id: " .. tostring(m_id))
    end
  end
  if m_default then
    local resConfig = PB.get("ActorConfig", m_actorId)
    REF.SpriteIconBG.UISprite.spriteName = "icon_bg_0"
    REF.TextureHead.UITexture.mainTexturePath = "Texture/ActorSkinHead/ActorSkinHead_" .. resConfig.skinUIRes
    WU.ToggleRendering(REF.SpritePaletteBG, false)
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

function SetDefault(actorId)
  ResetState()
  m_default = true
  m_actorId = actorId
  MarkAsDirty()
end
