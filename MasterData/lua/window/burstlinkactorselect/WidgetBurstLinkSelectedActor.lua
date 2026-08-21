local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function Start()
  for index = 1, 6 do
    local id = -1
    if index % 2 == 0 then
      id = -2
    end
    _ENV["$"](REF.Members)["WidgetIconSlot" .. index]["$SetActorCustom"]({id = id, isLock = false})
  end
end

function SetActors(actors, callback)
  local nextSelectIndex = 7
  for index = 1, 6 do
    local actor = actors[index]
    if actor then
      SetActorByIndex(actor, index, callback)
    else
      local id = -1
      if index % 2 == 0 then
        id = -2
      end
      _ENV["$"](REF.Members)["WidgetIconSlot" .. index]["$SetActorCustom"]({id = id, isLock = false})
      if index < nextSelectIndex then
        nextSelectIndex = index
      end
    end
  end
  SetNextHightlight(nextSelectIndex)
end

function SetActorByIndex(actor, index, callback)
  if 1 <= index and index <= 6 and actor then
    actor.quality = nil
    actor.star = nil
    actor.level = nil
    actor.isLock = false
    local actorForDisplay = {}
    table.copy(actor, actorForDisplay, true)
    actorForDisplay.talentInfo = {}
    _ENV["$"](REF.Members)["WidgetIconSlot" .. index]["$SetActorCustom"](actorForDisplay)
    if callback then
      _ENV["$"](REF.Members)["WidgetIconSlot" .. index]["$SetClickCallback"](callback)
    end
    _ENV["$"](_ENV["$"](REF.Members)["WidgetIconSlot" .. index])["@actor"] = actor
  end
end

function SetNextHightlight(nextSelectIndex)
  if nextSelectIndex < 7 then
    local actorType = PB.enum.ActorType.Main
    if nextSelectIndex % 2 == 0 then
      actorType = PB.enum.ActorType.Sub
    end
    _ENV["$"](REF.Members)["WidgetIconSlot" .. nextSelectIndex]["$SetHighlightType"](actorType)
    _ENV["$"](REF.Members)["WidgetIconSlot" .. nextSelectIndex]["$SetHighlighted"](true)
  end
end
