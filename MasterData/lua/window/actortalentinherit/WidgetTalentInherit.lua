local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local SE = require("Common/SkillEffect")
local m_equips, m_lastBindUid, m_isLeft, m_lastBindUid, m_lastBindEquipUids

function Start()
  WU.BindButtonEvent(REF.DownAlphaControl, function()
    this:BroadcastGameEvent("TalentInherit/Switch", m_isLeft)
  end)
end

function SetMixedActor(resultActor, isFromDecrepitView)
  if resultActor ~= nil then
    REF.DownAlphaControl.BoxCollider2D.enabled = false
    REF.SpriteQualityOld.UISprite.spriteName = REF.SpriteQualityNew.UISprite.spriteName
    REF.SpriteQualityNew.UISprite.spriteName = "quality_0" .. tostring(resultActor.quality)
    local actorConfig = PB.get("ActorConfig", resultActor.id)
    REF.TextureActorOld.UITexture.mainTexturePath = REF.TextureActor.UITexture.mainTexturePath
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
    REF.ActorLevelLabel.UILabel.text = WU.GetString("Window_Level", resultActor.level)
    REF.ActorSkillLabel.UILabel.text = resultActor.showSkillCount
    for i = 0, #REF.StarList - 1 do
      if i < resultActor.showStar then
        REF.StarList[i]["$gameObject"]:SetActive(true)
      else
        REF.StarList[i]["$gameObject"]:SetActive(false)
      end
    end
    REF.WidgetTalentRow4["$SetTalent"](resultActor, false, false, nil, true, true)
    SetEquipData(resultActor)
    if isFromDecrepitView then
      WU.ToggleRendering(REF.TitleLabel, false)
      WU.ToggleRendering(REF.LabelDecrepitValue, true)
      WU.ToggleRendering(REF.LabelDecrepitName, true)
      REF.LabelDecrepitValue.UILabel.text = resultActor.cultivationTotal
    else
      WU.ToggleRendering(REF.TitleLabel, true)
      WU.ToggleRendering(REF.LabelDecrepitValue, false)
      WU.ToggleRendering(REF.LabelDecrepitName, false)
    end
  end
end

function SetActorInfo(actor, isLeft, isFromDecrepitView)
  if actor ~= nil then
    m_isLeft = isLeft
    REF.SpriteQualityNew.UISprite.spriteName = "quality_0" .. tostring(actor.quality)
    REF.SpriteQualityOld.UISprite.spriteName = "quality_0" .. tostring(actor.quality)
    local actorConfig = PB.get("ActorConfig", actor.id)
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
    REF.TextureActorOld.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
    REF.ActorLevelLabel.UILabel.text = WU.GetString("Window_Level", actor.level)
    local curLevelSum = SE.GetSkillCount(actor)
    REF.ActorSkillLabel.UILabel.text = curLevelSum
    for i = 0, #REF.StarList - 1 do
      if i < actor.star then
        REF.StarList[i]["$gameObject"]:SetActive(true)
      else
        REF.StarList[i]["$gameObject"]:SetActive(false)
      end
    end
    SetEquipData(actor)
    REF.WidgetTalentRow4["$SetTalent"](actor, false, false, nil, true, true)
    if isFromDecrepitView then
      WU.ToggleRendering(REF.TitleLabel, false)
      WU.ToggleRendering(REF.LabelDecrepitValue, true)
      WU.ToggleRendering(REF.LabelDecrepitName, true)
      REF.LabelDecrepitValue.UILabel.text = actor.cultivationTotal or 0
    else
      WU.ToggleRendering(REF.TitleLabel, true)
      WU.ToggleRendering(REF.LabelDecrepitValue, false)
      WU.ToggleRendering(REF.LabelDecrepitName, false)
    end
  end
end

function SetEquipData(actorInfo)
  if actorInfo ~= nil and actorInfo.uid ~= 0 then
    if actorInfo.bodyEquips == nil then
      if m_lastBindUid ~= nil then
        this:Unbind("fci/actor/" .. m_lastBindUid, SetEquipByRemoteActor)
      end
      m_lastBindUid = actorInfo.uid
      this:Bind("fci/actor/" .. actorInfo.uid, SetEquipByRemoteActor)
    else
      SetEquipByRemoteActor(actorInfo)
    end
  end
end

function SetEquipByRemoteActor(actor)
  if actor ~= nil then
    if m_lastBindEquipUids ~= nil then
      for i = 1, #m_lastBindEquipUids do
        this:Unbind("fci/equip/" .. m_lastBindEquipUids[i], SetDetailSlot)
      end
    end
    m_lastBindEquipUids = {}
    for _, pos in pairs(PB.enum.EquipPos) do
      local equipUid = actor.bodyEquips[tostring(pos)]
      local ref = REF.EquipList[pos]
      if equipUid ~= nil then
        table.insert(m_lastBindEquipUids, equipUid)
        this:Bind("fci/equip/" .. equipUid, SetDetailSlot)
      else
        SetEquip(ref)
      end
    end
  end
end

function SetDetailSlot(equip)
  if equip ~= nil then
    local equipInfo = PB.get("EquipInfo", equip.id)
    if equipInfo ~= nil then
      local ref = REF.EquipList[equipInfo.pos]
      SetEquip(ref, equip)
    end
  end
end

function SetEquip(ref, equip)
  if equip == nil then
    ref["$gameObject"]:SetActive(false)
    return
  end
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    ref.SpriteIconBG.UISprite.spriteName = "icon_bg_" .. equipInfo.quality
    ref.TextureIcon.UITexture.mainTexturePath = "Texture/EquipIcon/" .. equipInfo.icon
    ref.SpriteEquipPos.UISprite.spriteName = EU.EquipPosSpriteNameTable[equipInfo.pos + 1]
  end
  ref.LabelBottomRight.UILabel.text = WU.GetString("Window_Level", equip.level)
  ref["$gameObject"]:SetActive(true)
end
