local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local m_actor, m_skillGroup, m_defaultSkill

function Start()
  WU.BindButtonEvent(REF["$"], OnActorSkillDetail)
end

function SetData(actor, skillGroup)
  m_actor = actor
  m_skillGroup = skillGroup
  if m_actor and m_skillGroup then
    m_defaultSkill = m_skillGroup[1]
    local skillLevel = SE.GetSkillLevel(m_actor, m_defaultSkill.skillId)
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    if not m_defaultSkill.isPassive then
      local actorCombo = SE.GetActorSkillCombo(m_defaultSkill.skillId)
      if REF.SpriteType then
        REF.SpriteType.UISprite.spriteName = "skill/" .. actorCombo.kindIcon
      else
        error("Skill", "mismatch slot of pos " .. this.transform.localPosition:ToString() .. " with actor " .. m_actor.id .. " skill " .. m_defaultSkill.skillId)
      end
    end
    REF.TextureSkill.UITexture.mainTexturePath = SE.GetSkillTexturePath(m_defaultSkill, actorConfig.id)
    local unlocked, unlockStarCount = SE.IsSkillUnlocked(m_actor, m_defaultSkill)
    if m_defaultSkill.isPassive then
      local showUnlockEffect = false
      REF.NodeLocked.gameObject:SetActive(not unlocked)
      if unlocked and not SE.IsSkillRead(m_actor, m_defaultSkill.skillId) and m_actor.uid then
        showUnlockEffect = true
        this:GameRequest("fci/actor/" .. m_actor.uid .. "/skill-read/" .. m_defaultSkill.skillId):Post({isRead = true}, function(result)
          SE.SetSkillRead(m_actor, m_defaultSkill.skillId)
        end)
      end
      WU.SetActive(REF.EffectUnlock, showUnlockEffect)
    end
    REF.LabelLevel.gameObject:SetActive(unlocked)
    local levelLimit = PB.get("ActorSkillMaxLevel", m_actor.id, m_actor.star)
    local isLevelLimit = skillLevel >= levelLimit.maxLevel[m_defaultSkill.displayIndex]
    WU.SetActive(REF.EffectCanLevelup, not isLevelLimit and unlocked)
    if unlocked then
      REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", skillLevel)
    end
  end
end

function OnActorSkillDetail()
  if m_actor and m_defaultSkill then
    this:SetData("Skill/DisplayIndex", m_defaultSkill.displayIndex)
    WU.AcquireWindowAsync("ActorSkillDetail")
  end
end
