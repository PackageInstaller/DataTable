-- chunkname: @modules/live2d/Live2dSpecialLogic.lua

module("modules.live2d.Live2dSpecialLogic", package.seeall)

local Live2dSpecialLogic = class("Live2dSpecialLogic")
local _alwaysFadeList = {
	"pikelesi"
}

function Live2dSpecialLogic.setAlwaysFade(cubismController, resPath, value)
	local fade = false

	if value then
		for i, v in ipairs(_alwaysFadeList) do
			if string.find(resPath, v) then
				fade = true

				break
			end
		end
	end

	cubismController:SetAlwaysFade(fade)
end

local fakeUIEffectList = {
	{
		id = 306501,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	},
	{
		id = 306502,
		effect = "Drawables/bone/effect-Bone",
		frameVisible = 1
	}
}

function Live2dSpecialLogic.getFakeUIEffect(resPath)
	for i, v in ipairs(fakeUIEffectList) do
		if string.find(resPath, v.id) then
			return v, string.split(v.effect, "|")
		end
	end
end

return Live2dSpecialLogic
