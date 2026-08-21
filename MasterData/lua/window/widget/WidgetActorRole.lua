local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local IC = require("Common/IconConfig")
local m_clickCallback, m_dragCallback
local BGName = {
  "journey_wiki_actor_bg_1",
  "journey_wiki_actor_bg_2"
}
local m_dragDelta = 0

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, function()
    if m_clickCallback then
      m_clickCallback(REF["$gameObject"])
    end
  end)
  WU.BindDragEvent(REF.ButtonSlot, OnDraging)
  WU.BindPressEvent(REF.ButtonSlot, OnPress, "empty")
end

function SetActorByRoleId(roleId, bgType, solidColor)
  bgType = bgType or 1
  if roleId and 0 < roleId then
    local role = PB.get("Role", roleId)
    if role then
      REF.SpriteBG.UISprite.spriteName = BGName[bgType]
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. role.animRes
      REF.TextureActorHead.UITexture.solidColor = solidColor
      if solidColor then
        REF.TextureActorHead.UITexture.color = CS.NGUIMath.HexToColor(1299091199)
      else
        REF.TextureActorHead.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
      end
      REF.ActorName.UISprite.spriteName = "actor_name_" .. role.animRes
      REF.ActorName.UISprite:MakePixelPerfect()
      REF.ActorNameEn.UISprite.spriteName = "actor_name_s_" .. role.animRes
    else
      error("Actor", "Role.xlsx error, Can't find id " .. tostring(roleId))
    end
  end
end

function SetNew(isNew)
  REF.SpriteRedPoint.gameObject:SetActive(isNew)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetDragCallback(callback)
  m_dragCallback = callback
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, pressed)
  if pressed then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  else
    local val = 0
    if m_dragDelta.x < -100 then
      val = 1
    elseif m_dragDelta.x > 100 then
      val = -1
    end
    if m_dragCallback then
      m_dragCallback(val)
    end
  end
end
