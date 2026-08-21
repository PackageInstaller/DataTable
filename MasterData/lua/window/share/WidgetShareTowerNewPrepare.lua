local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")

function SetShareInfo(data)
  local mainActors = table.toarray(table.where(data.selectActors, function(k, v)
    return v.kind == 1
  end))
  local subActors = table.toarray(table.where(data.selectActors, function(k, v)
    return v.kind == 2
  end))
  REF.LabelLayer.UILabel.text = data.curFloor
  for i = 1, #REF.MainGrid do
    local selectActor = mainActors[i]
    local ref = REF.MainGrid[i - 1]
    WU.SetActive(ref.root, selectActor ~= nil)
    if selectActor then
      ref["$$SetData"](selectActor.actor.id)
    end
  end
  for i = 1, #REF.SubGrid do
    local selectActor = subActors[i]
    local ref = REF.SubGrid[i - 1]
    WU.SetActive(ref.root, selectActor ~= nil)
    if selectActor then
      ref["$$SetData"](selectActor.actor.id)
    end
  end
end
