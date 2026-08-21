local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_clickCallback, m_activityId

function Start()
  WU.BindButtonEvent(REF.TextureCG, OnClick)
end

function SetData(activityId, actorId)
  m_activityId = activityId
  REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. PB.get("ActorConfig", actorId).animRes
  REF.TextureCG.UITexture.mainTexturePath = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, activityId).smallCgRes
  WU.ModifyPortrait(REF.TextureActor, actorId, 6)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function OnClick()
  if m_clickCallback then
    m_clickCallback()
  else
    WU.ShowItemDetail(PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_activityId).cgItem.id)
  end
end
