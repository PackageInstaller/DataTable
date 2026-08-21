local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")

function Awake()
end

function Start()
end

function PlayByActorID(actorId, windowType)
  local boardInfo = PB.get("BoardActorConfig", actorId)
  if boardInfo then
    REF.SpriteActor["$SetBoardActorConfig"](boardInfo)
    REF.SpriteActor["$PlayRandomAnimation"](true, true)
    REF.SpriteActor["$SetWindowType"](windowType)
    this:DelayInvokeInFrames(1, function()
      REF.SpriteActor["$OnGamePreferencesChanged"]()
    end)
    return true
  end
  return false
end

function OnEnable()
end

function OnDisable()
end
