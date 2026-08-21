local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local m_actor

function Start()
end

function OnEnable()
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    if actorConfig then
      REF.Main.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Main)
      REF.Sub.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Sub)
      local skills = SE.GetActorSkills(m_actor.id)
      local listGasket = fif(actorConfig.kind == PB.enum.ActorType.Main, REF.Main, REF.Sub)
      local skillCount = #skills
      for i = 0, #listGasket - 1 do
        local slotRef = listGasket[i]
        slotRef["$gameObject"]:SetActive(i < skillCount)
        if i < skillCount then
          slotRef["$$SetData"](m_actor, skills[i + 1])
        end
      end
    end
  end
end
