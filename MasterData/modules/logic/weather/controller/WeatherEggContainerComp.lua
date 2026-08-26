-- chunkname: @modules/logic/weather/controller/WeatherEggContainerComp.lua

module("modules.logic.weather.controller.WeatherEggContainerComp", package.seeall)

local WeatherEggContainerComp = class("WeatherEggContainerComp")

function WeatherEggContainerComp:ctor()
	return
end

function WeatherEggContainerComp:onSceneHide()
	TaskDispatcher.cancelTask(self._switchEgg, self)

	for i, v in ipairs(self._serialEggList) do
		v:onDisable()
	end

	for i, v in ipairs(self._parallelEggList) do
		v:onDisable()
	end
end

function WeatherEggContainerComp:onSceneShow()
	for i, v in ipairs(self._parallelEggList) do
		v:onEnable()
	end

	self:_startTimer()
end

function WeatherEggContainerComp:onReportChange(report)
	for i, v in ipairs(self._serialEggList) do
		v:onReportChange(report)
	end

	for i, v in ipairs(self._parallelEggList) do
		v:onReportChange(report)
	end
end

function WeatherEggContainerComp:onInit(sceneId, isMainScene)
	self._context = {
		isMainScene = isMainScene
	}
	self._sceneId = sceneId

	local sceneConfig = lua_scene_switch.configDict[sceneId]

	self._eggList = sceneConfig.eggList
	self._eggSwitchTime = sceneConfig.eggSwitchTime
	self._serialEggList = {}
	self._parallelEggList = {}
	self._index = 0
end

function WeatherEggContainerComp:_startTimer()
	TaskDispatcher.cancelTask(self._switchEgg, self)

	if #self._serialEggList > 0 then
		self._time = self._time or Time.time

		TaskDispatcher.runRepeat(self._switchEgg, self, 0)
	end
end

function WeatherEggContainerComp:_switchEgg()
	if not self._time or Time.time - self._time <= self._eggSwitchTime then
		return
	end

	self._time = Time.time

	local egg = self._serialEggList[self._index]

	if egg then
		egg:onDisable()
	end

	local index = self:getNextIndex()
	local egg = self._serialEggList[index]

	if egg then
		egg:onEnable()
	end
end

function WeatherEggContainerComp:getNextIndex()
	self._index = self._index + 1

	if self._index > #self._serialEggList then
		self._index = 1
	end

	return self._index
end

function WeatherEggContainerComp:getSceneNode(nodePath)
	return gohelper.findChild(self._sceneGo, nodePath)
end

function WeatherEggContainerComp:getGoList(path)
	local list = string.split(path, "|")

	for i, v in ipairs(list) do
		local go = self:getSceneNode(v)

		list[i] = go

		if not go then
			logError(string.format("WeatherEggContainerComp can not find go by path:%s", v))
		end
	end

	return list
end

function WeatherEggContainerComp:initSceneGo(sceneGo)
	self._sceneGo = sceneGo

	for i, id in ipairs(self._eggList) do
		local eggConfig = lua_scene_eggs.configDict[id]
		local cls = _G[eggConfig.actionClass]

		if cls then
			local actionInstance = cls.New()
			local goList = self:getGoList(eggConfig.path)

			actionInstance:init(self._sceneGo, goList, eggConfig, self._context)

			if eggConfig.parallel == 1 then
				table.insert(self._parallelEggList, actionInstance)
			else
				table.insert(self._serialEggList, actionInstance)
			end
		else
			logError(string.format("WeatherEggContainerComp can not find egg action class by id:%d cls:[%s]", id, eggConfig.actionClass))
		end
	end

	self:_startTimer()
end

function WeatherEggContainerComp:onSceneClose()
	TaskDispatcher.cancelTask(self._switchEgg, self)

	for i, v in ipairs(self._serialEggList) do
		v:onSceneClose()
	end

	for i, v in ipairs(self._parallelEggList) do
		v:onSceneClose()
	end
end

return WeatherEggContainerComp
