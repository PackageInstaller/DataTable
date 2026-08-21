inherit("Window/Widget/WidgetIconSlot/WidgetIconBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_id, m_actorUid, m_callback

function Start()
  WU.BindButtonEvent(REF.root, OnClick)
end

function SetData(id, actorUid)
  WU.SetActive(REF.WidgetIconSkin, true)
  WU.SetActive(REF.SpriteRandom, false)
  m_id = id
  m_actorUid = actorUid
  local unlocked = this:GetData("fci/unlockedSkins")[m_id]
  local isNew = this:GetData("fci/newSkins")[m_id]
  local actor = this:GetData("fci/actor/" .. m_actorUid)
  if id ~= 0 then
    REF.WidgetIconSkin["$SetData"](id)
  else
    REF.WidgetIconSkin["$SetDefault"](actor.id)
  end
  SetAlpha(not unlocked)
  WU.SetActive(REF.SpriteLocked, not unlocked)
  WU.SetActive(REF.SpriteNew, unlocked and isNew)
  WU.SetActive(REF.LabelInUse, actor.actorSkin == m_id and not actor.randomSkin)
  REF.LabelName.UILabel.text = WU.GetString("ActorSkinName_" .. m_id)
end

function SetSelected(selected)
  WU.SetActive(REF.SpriteBgHint, selected)
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetAlpha(transparent)
  REF.SpriteIconBG.UISprite.alpha = fif(transparent, 0.705, 1)
  REF.TextureHead.UITexture.alpha = fif(transparent, 0.784, 1)
  REF.SpriteBg1.UISprite.alpha = fif(transparent, 0.612, 1)
  REF.SpriteBg2.UISprite.alpha = fif(transparent, 0.25, 0.2)
  REF.LabelName.UILabel.alpha = fif(transparent, 0.5, 1)
  REF.LabelInUse.UILabel.alpha = fif(transparent, 0.5, 1)
end

function SetRandom(unlocked, inUse)
  WU.SetActive(REF.WidgetIconSkin, false)
  WU.SetActive(REF.SpriteRandom, true)
  WU.SetActive(REF.SpriteNew, false)
  WU.SetActive(REF.SpriteLocked, false)
  SetAlpha(not unlocked)
  WU.SetActive(REF.LabelInUse, inUse)
  REF.LabelName.UILabel.text = WU.GetString("Window_ActorSkin_Random")
end

function OnClick()
  if m_callback then
    m_callback()
  end
end
