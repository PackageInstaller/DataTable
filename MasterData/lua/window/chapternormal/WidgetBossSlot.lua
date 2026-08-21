local BASE = inherit("Window/ChapterNormal/WidgetDungeonBaseSlot", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local U = require("Common/Util")
local S = require("Common/Singleton")

function SetData(data)
  WU.SetActive(REF.SpriteCultivationPVP, data.isCultivationPVP)
  BASE.SetData(data)
end
