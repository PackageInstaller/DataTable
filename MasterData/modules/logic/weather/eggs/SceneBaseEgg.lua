-- chunkname: @modules/logic/weather/eggs/SceneBaseEgg.lua

module("modules.logic.weather.eggs.SceneBaseEgg", package.seeall)

local SceneBaseEgg = class("SceneBaseEgg")

function SceneBaseEgg:ctor()
	return
end

function SceneBaseEgg:onEnable()
	self:_onEnable()
end

function SceneBaseEgg:_onEnable()
	return
end

function SceneBaseEgg:onDisable()
	self:_onDisable()
end

function SceneBaseEgg:_onDisable()
	return
end

function SceneBaseEgg:onReportChange(report)
	self:_onReportChange(report)
end

function SceneBaseEgg:_onReportChange(report)
	return
end

function SceneBaseEgg:init(sceneGo, goList, eggConfig, context)
	self._sceneGo = sceneGo
	self._context = context
	self._goList = goList
	self._eggConfig = eggConfig

	self:_onInit()
end

function SceneBaseEgg:setGoListVisible(value)
	if not self._goList then
		return
	end

	for _, go in pairs(self._goList) do
		gohelper.setActive(go, value)
	end
end

function SceneBaseEgg:playAnim(name)
	for _, go in pairs(self._goList) do
		gohelper.setActive(go, true)

		local animator = go and go:GetComponent("Animator")

		if animator then
			animator:Play(name, 0, 0)
		else
			logError("go has no animator animName:" .. name)
		end
	end
end

function SceneBaseEgg:_onInit()
	return
end

function SceneBaseEgg:onSceneClose()
	self._goList = nil

	self:_onSceneClose()
end

function SceneBaseEgg:_onSceneClose()
	return
end

return SceneBaseEgg
