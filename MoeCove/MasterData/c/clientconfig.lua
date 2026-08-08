
--require("Config").Load()

Config.table.UIConfigTable = 
{
    source = require "UIConfigTable",
    compound = nil,
}

---@param name string
---@return table|nil
function Config.GetUIConfigInfo(name)
    return Config.CommonGetInfo("UIConfigTable", name)
end

Config.table.AudioConfigTable = {
	-- autogen, bgm_job_huashan...
	[1] = "bgm_city1.mp3",
	[2] = "bgm_city1.mp3",

	Battle = "bgm_battle1.mp3",

	World = {"bgm_world1.mp3", "bgm_world2.mp3"},
	Sea = "bgm_sea1.mp3",
	SE = "Audio/SE/SE_%s.mp3",
	OPSE = "Audio/OPSE/OPSE_%s.mp3",
}

GlobalSetting =
{
	ServerTimeSync = 60,
}