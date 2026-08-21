local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_emoteRender

function Awake()
end

function Start()
  m_emoteRender = CS.EmoteManager.Instance:CreateRender("Emote/Render/GachaEmoteRender")
end

function PlayByActorID(actorId, index, windowType)
  local boardInfo = PB.get("BoardActorConfig", actorId)
  local spriteActor = REF[string.format("SpriteActor%d", index)]
  if boardInfo and spriteActor then
    local ps = spriteActor.transform.localPosition
    spriteActor["$InitRender"](m_emoteRender, index - 1, false)
    spriteActor["$SetAutoPlay"](false)
    spriteActor["$SetSpeechMode"](2)
    spriteActor["$SetEmoteDisplay"](REF.EmoteDisplay)
    spriteActor["$SetBoardActorConfig"](boardInfo, index)
    spriteActor["$PlayRandomAnimation"](true, true)
    spriteActor["$SetWindowType"](windowType)
    return true
  end
  return false
end

function OnEnable()
end

function OnDestroy()
  if CS.EmoteManager.Instance ~= nil then
    CS.EmoteManager.Instance:DestroyRender(m_emoteRender)
  end
end

function OnDisable()
end
