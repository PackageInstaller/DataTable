-- chunkname: @modules/logic/weather/eggs/SceneEggRandomShow.lua

module("modules.logic.weather.eggs.SceneEggRandomShow", package.seeall)

local SceneEggRandomShow = class("SceneEggRandomShow", SceneBaseEgg)

function SceneEggRandomShow:_onEnable()
	self:setGoListVisible(true)
end

function SceneEggRandomShow:_onDisable()
	self:setGoListVisible(false)
end

function SceneEggRandomShow:_onInit()
	self:setGoListVisible(false)
end

return SceneEggRandomShow
