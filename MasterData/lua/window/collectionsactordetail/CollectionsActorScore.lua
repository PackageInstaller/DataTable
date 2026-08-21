local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_actorIndex, m_actorId

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
end

function SetData(actorIds, actorScoreData)
  for i = REF.GridScores.transform.childCount + 1, #actorIds do
    CS.NGUITools.AddChild(REF.GridScores.gameObject, REF.GridScores[0]["$gameObject"])
  end
  for i = 1, REF.GridScores.transform.childCount do
    WU.ToggleRendering(REF.GridScores[i - 1].root, i <= #actorIds)
  end
  for i = 1, #actorIds do
    local id = actorIds[i]
    local _, qualityInfo = table.find(actorScoreData, function(k, v)
      return v.id == id
    end)
    qualityInfo = qualityInfo and qualityInfo.qualityInfo
    SetScoreSlot(REF.GridScores[i - 1], id, qualityInfo)
  end
  REF.GridScores.UIGrid:Reposition()
  REF.ScrollViewScores.UIScrollView:ResetPosition()
end

function SetScoreSlot(ref, id, qualityInfo)
  local actorConfig = PB.get("ActorConfig", id)
  ref.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
  ref.SpriteSmallActorName.UISprite.spriteName = "actor_name_s_" .. actorConfig.animRes
  ref.SpriteActorTypeBg.UISprite.spriteName = "actor_type_bg_0"
  ref.SpriteActorType.UISprite.spriteName = "actor_type_" .. id
  ref.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
  for j = 1, 4 do
    local _, q = table.find(qualityInfo, function(k, v)
      return v.quality == j
    end)
    if q then
      ref.NodeLabelScores[j - 1]["$UILabel"].color = CS.NGUIMath.HexToColor(1757806591)
    else
      ref.NodeLabelScores[j - 1]["$UILabel"].color = CS.NGUIMath.HexToColor(3217744383)
    end
  end
end
