-- chunkname: @modules/logic/explore/controller/ExploreStepController.lua

module("modules.logic.explore.controller.ExploreStepController", package.seeall)

local ExploreStepController = class("ExploreStepController", BaseController)

function ExploreStepController:initMap()
	if self._map then
		return
	end

	self._map = ExploreController.instance:getMap()
	self._hero = self._map:getHero()
	self._mapId = ExploreModel.instance:getMapId()

	local x, y = ExploreMapModel.instance:getHeroPos()

	self._cachePos = {
		x = x,
		y = y
	}
	self._stepList = {}
end

function ExploreStepController:onExploreStepPush(msg)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	self:initMap()

	for i, v in ipairs(msg.steps) do
		local data = cjson.decode(v.param)
		local index = #self._stepList

		while self._stepList[index] do
			if self._stepList[index].alwaysLast then
				index = index - 1
			else
				break
			end
		end

		if data.stepType == ExploreEnum.StepType.UpdateUnit or data.stepType == ExploreEnum.StepType.DelUnit then
			data.interact = cjson.decode(data.interact)
		end

		if data.stepType == ExploreEnum.StepType.UpdateUnit then
			for idx = #self._stepList, 1, -1 do
				local stepData = self._stepList[idx]

				if stepData.stepType == ExploreEnum.StepType.UpdateUnit then
					if stepData.interact.id == data.interact.id then
						table.remove(self._stepList, idx)

						index = index - 1

						break
					end
				else
					break
				end
			end
		end

		table.insert(self._stepList, index + 1, data)

		if data.stepType == ExploreEnum.StepType.RoleMove then
			ExploreMapModel.instance:updatHeroPos(data.x, data.y, data.direction)

			self._cachePos = data
		end
	end

	self:startStep()
end

function ExploreStepController:insertClientStep(stepData, index)
	self:initMap()

	if index then
		table.insert(self._stepList, index, stepData)
	else
		table.insert(self._stepList, stepData)
	end
end

function ExploreStepController:forceAsyncPos()
	self:initMap()
	self._hero:stopMoving(true)
	self._hero:setPosByNode(self._cachePos, true)
	self._hero:setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	self._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true)
end

function ExploreStepController:startStep()
	if self._curRunStep then
		return
	end

	if ExploreModel.instance:getStepPause() then
		return
	end

	if not self._stepList then
		return
	end

	if #self._stepList <= 0 then
		self:onStepAllDone()

		return
	end

	local data = table.remove(self._stepList, 1)
	local stepType = data.stepType
	local className = string.format("Explore%sStep", (not ExploreEnum.StepTypeToName[stepType] or nil) and "")
	local cls = _G[className]

	if cls then
		self._curRunStep = cls.New(data)
	else
		logError("未处理步骤类型" .. tostring(stepType))

		self._curRunStep = ExploreStepBase.New(data)
	end

	return self._curRunStep:onStart()
end

function ExploreStepController:onStepEnd()
	self._curRunStep = nil

	self:startStep()
end

function ExploreStepController:onStepAllDone()
	return
end

function ExploreStepController:getCurStepType()
	if not self._curRunStep then
		return
	end

	return self._curRunStep._data.stepType
end

function ExploreStepController:getStepIndex(stepType)
	if self._curRunStep and self._curRunStep._data.stepType == stepType then
		return 0
	end

	if not self._stepList then
		return -1
	end

	for index, data in ipairs(self._stepList) do
		if data.stepType == stepType then
			return index
		end
	end

	return -1
end

function ExploreStepController:clear()
	self._map = nil
	self._hero = nil

	if self._curRunStep then
		self._curRunStep:onDestory()

		self._curRunStep = nil
	end

	local list = self._stepList

	self._stepList = {}

	if list then
		for _, v in pairs(list) do
			if ExploreEnum.MustDoStep[v.stepType] then
				local className = string.format("Explore%sStep", (not ExploreEnum.StepTypeToName[v.stepType] or nil) and "")
				local cls = _G[className]
				local step = cls.New(v)

				step:onStart()
			end
		end
	end
end

ExploreStepController.instance = ExploreStepController.New()

return ExploreStepController
