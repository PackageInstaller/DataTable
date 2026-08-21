local WU, DB, REF = require("Common/WindowUtil")(this)
local IU = require("Common/ItemUtil")
local m_callback, m_effectScaled, m_type, m_id

function Start()
  WU.BindButtonEvent(REF["$"], OnClick)
end

function OnClick(go)
  if m_callback ~= nil then
    m_callback(go)
  else
    WU.ShowResourceDetail(m_type, m_id)
  end
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetData(type, id)
  m_type = type
  m_id = id
  SetBG(0)
  SetGray(false)
  SetEffect(false)
  REF.TextureReward.UITexture.mainTexturePath = IU.GetResourceIconPath(type, id)
end

function SetGray(gray)
  REF.TextureReward.UITexture.graify = gray
  REF.SpriteBG.UISprite.graify = gray
end

function SetBG(bg)
  REF.SpriteBG.UISprite.spriteName = "Back/back_icon_bg_" .. bg
end

function SetEffect(showEffect)
  WU.SetActive(REF.EffectReward, showEffect)
  if showEffect and not m_effectScaled then
    local rootScale = REF.root.transform.localScale
    local effectScale = REF.EffectReward.transform.localScale
    REF.EffectReward.transform.localScale = {
      x = rootScale.x * effectScale.x,
      y = rootScale.y * effectScale.y,
      z = 1
    }
    m_effectScaled = true
  end
end
