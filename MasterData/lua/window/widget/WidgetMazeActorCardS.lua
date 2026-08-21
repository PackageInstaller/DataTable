local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local IC = require("Common/IconConfig")
local PosSprites = {
  [0] = "pos_1st",
  [1] = "pos_2nd",
  [2] = "pos_3rd",
  [3] = "pos_sub",
  [4] = "pos_sub",
  [5] = "pos_sub"
}
local CheckBox = {"check_box", "check_box"}
local MaskName = {
  nil,
  "Texture/Mask/actor_head_rectangle_sub_mask"
}
local m_clickCallback, m_actor, m_uid

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, function(go)
    if m_clickCallback then
      m_clickCallback(REF["$gameObject"])
    end
  end)
end

local function OnActor(actor)
  if actor ~= nil then
    SetActor(actor)
  end
end

function ResetState()
  REF.SpriteTips.gameObject:SetActive(false)
  REF.SpriteSelected.gameObject:SetActive(false)
  REF.SpriteMemOrder.gameObject:SetActive(false)
  REF.SpriteIsLocked.gameObject:SetActive(false)
  REF.RecommendEffect.gameObject:SetActive(false)
  REF.ShowLock.gameObject:SetActive(false)
  REF.LabelLvValue.gameObject:SetActive(true)
  REF.RightBottom.gameObject:SetActive(true)
  REF.AlphaControl.gameObject:SetActive(true)
  REF.SpriteIsSub.gameObject:SetActive(false)
end

function BindActor(uidOrActor)
  ResetState()
  local uid = uidOrActor
  if type(uidOrActor) == "table" then
    uid = uidOrActor.uid
  end
  if m_uid ~= nil then
    this:Unbind("fci/mazeactor/" .. m_uid, OnActor)
  end
  m_uid = uid
  this:Bind("fci/mazeactor/" .. uid, OnActor)
end

function SetActorCustom(customActor)
  ResetState()
  if customActor ~= nil and customActor.id ~= nil then
    local actorConfig = PB.get("ActorConfig", customActor.id)
    if actorConfig then
      local quality = customActor.quality or 0
      local index = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        index = 2
        REF.SpriteIsSub.UISprite.spriteName = "rolelist_sub_m_" .. quality
      end
      REF.TextureActorHead.UITexture.maskTexturePath = MaskName[index]
      REF.SpriteSelected.UISprite.spriteName = CheckBox[index]
      REF.MainRecommend.gameObject:SetActive(true)
      REF.SpriteIsSub.gameObject:SetActive(index == 2)
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. actorConfig.animRes
      REF.RightBottom.UISprite.spriteName = "head_mask_" .. quality
      REF.SpriteBG.UISprite.spriteName = "head_bg_" .. quality
    end
  end
end

function SetActor(actorWrap)
  if actorWrap == nil then
    return
  end
  local actor = actorWrap.actor
  local attrs = actor.attrs
  local hp = actorWrap.hp
  local maxHp = 0
  for k, v in pairs(attrs) do
    if v.type == PB.enum.AttrType.Hp then
      maxHp = maxHp + v.value
    end
  end
  local per = hp / maxHp
  REF.SpriteProgress.UISprite.fillAmount = per
  if actor then
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      local index = 1
      if actorConfig.kind == PB.enum.ActorType.Sub then
        index = 2
        REF.SpriteIsSub.UISprite.spriteName = "rolelist_sub_m_" .. actor.quality
      end
      REF.RightBottom.UISprite.spriteName = "head_mask_" .. actor.quality
      REF.SpriteBG.UISprite.spriteName = "head_bg_" .. actor.quality
      REF.TextureActorHead.UITexture.maskTexturePath = MaskName[index]
      REF.SpriteSelected.UISprite.spriteName = CheckBox[index]
      REF.MainRecommend.gameObject:SetActive(true)
      REF.SpriteIsSub.gameObject:SetActive(index == 2)
      REF.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadRectangle/actor_head_" .. actorConfig.animRes
    end
    REF.LabelLvValue.UILabel.text = WU.GetString("Window_Level", actor.level)
    REF.StarLabel.UILabel.text = actor.star
    REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
    REF.SpriteActorTypeBG.UISprite.spriteName = "actor_type_bg_" .. actor.quality
    REF.SpriteIsLocked.gameObject:SetActive(actor.isLock)
    if m_actor ~= actor then
      m_actor = actor
      REF.Visual.UIPlayTween:Play(true)
    end
  end
end

function ShowCustom(data)
  REF.ShowLock.gameObject:SetActive(data.lock ~= nil and data.lock)
  if data.showLevel ~= nil then
    REF.LabelLvValue.gameObject:SetActive(data.showLevel)
  end
  if data.showStar ~= nil then
    REF.RightBottom.gameObject:SetActive(data.showStar)
  end
  if data.showActorInfo ~= nil then
    REF.ActorInfo.gameObject:SetActive(data.showActorInfo)
  end
end

function SetTips(tipKey)
  local tipConfig = IC.TipsConfig[tipKey]
  REF.SpriteTips.gameObject:SetActive(tipConfig ~= nil)
  if tipConfig then
    REF.SpriteTips.UISprite.atlasPath = tipConfig.atlas
    REF.SpriteTips.UISprite.spriteName = tipConfig.sprite
  end
end

function SetMemberOrder(index)
  REF.SpriteMemOrder.gameObject:SetActive(true)
  REF.SpriteMemOrder.UISprite.spriteName = PosSprites[index]
end

function SetHighlighted(flag)
  REF.SpriteSelected.gameObject:SetActive(flag)
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function SetMemberLink(flag)
  REF.RecommendEffect.gameObject:SetActive(flag)
end

function SetAlpha(alpha)
  REF.Visual.UIWidget.alpha = alpha
end

function SetHP(fillAmount)
  REF.SpriteProgress.UISprite.fillAmount = fillAmount
end
