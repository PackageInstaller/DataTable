-- chunkname: @modules/logic/weather/eggs/SceneEggRandomDisplayOne.lua

module("modules.logic.weather.eggs.SceneEggRandomDisplayOne", package.seeall)

local SceneEggRandomDisplayOne = class("SceneEggRandomDisplayOne", SceneBaseEgg)

function SceneEggRandomDisplayOne:_onEnable()
	return
end

function SceneEggRandomDisplayOne:_onDisable()
	return
end

function SceneEggRandomDisplayOne:_onInit()
	if not self._goList then
		return
	end

	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))

	local randomIndex = math.random(1, #self._goList)

	for i, go in pairs(self._goList) do
		gohelper.setActive(go, i == randomIndex)
	end
end

return SceneEggRandomDisplayOne
