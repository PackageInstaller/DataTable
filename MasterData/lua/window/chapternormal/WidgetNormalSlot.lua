local BASE = inherit("Window/ChapterNormal/WidgetDungeonBaseSlot", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")

function SetData(data)
  BASE.SetData(data)
  local ref = REF
  if REF.Group then
    ref = _ENV["$"](REF.Group)
    local dungeonMonster = PB.get("DungeonMonster", data.dungeonId)
    if dungeonMonster ~= nil and dungeonMonster.stageLockIcon ~= 0 and dungeonMonster.stageLockIcon ~= nil and REF.GroupFull then
      ref = _ENV["$"](REF.GroupFull)
    end
  end
  if data.isCultivationPVP then
    if REF.NormalContainer.gameObject.activeInHierarchy then
      WU.SetActive(REF.SpriteCultivationPVPNormal, true)
      WU.SetActive(REF.SpriteCultivationPVPReward, false)
    else
      WU.SetActive(REF.SpriteCultivationPVPReward, true)
      WU.SetActive(REF.SpriteCultivationPVPNormal, false)
    end
  else
    WU.SetActive(REF.SpriteCultivationPVPNormal, false)
    WU.SetActive(REF.SpriteCultivationPVPReward, false)
  end
end
