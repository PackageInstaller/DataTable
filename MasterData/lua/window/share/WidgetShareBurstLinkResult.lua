local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetShareInfo(data)
  local group = data.groupData["1"].members
  local result = data.resultInfo
  local actorPool = data.actorPool
  REF.LabelWinTimes.UISprite.spriteName = "share_onlinebattle_" .. tostring(result.winNum)
  for i = 0, #REF.GroupActors - 1 do
    local actorUid = group[i + 1].actorUid
    local _, actor = table.find(actorPool, function(k, v)
      return v.uid == actorUid
    end)
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      local actorData = {
        animRes = actorConfig.animRes,
        unlock = true,
        kind = actorConfig.kind,
        id = actorConfig.id
      }
      REF.GroupActors[i]["$$SetData"](actorData)
      REF.GroupActors[i]["$$SetSelected"](false)
    else
      REF.GroupActors[i]["$$SetEmpty"]()
    end
  end
end
