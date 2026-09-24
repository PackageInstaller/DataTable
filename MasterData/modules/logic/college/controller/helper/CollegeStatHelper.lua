-- chunkname: @modules/logic/college/controller/helper/CollegeStatHelper.lua

module("modules.logic.college.controller.helper.CollegeStatHelper", package.seeall)

local CollegeStatHelper = class("CollegeStatHelper")

function CollegeStatHelper:startStat()
	self.beginDt = ServerTime.now()
end

function CollegeStatHelper:statBtnClick(name, btnName)
	StatController.instance:track(StatEnum.EventName.College_ButtonClick, {
		[StatEnum.EventProperties.College_InterfaceName] = name,
		[StatEnum.EventProperties.College_ButtonName] = btnName
	})
end

function CollegeStatHelper:statViewClose(name, beginTime)
	local costTime = ServerTime.now() - beginTime

	if costTime <= 0.5 then
		return
	end

	StatController.instance:track(StatEnum.EventName.College_CloseView, {
		[StatEnum.EventProperties.College_InterfaceName] = name,
		[StatEnum.EventProperties.College_UseTime] = costTime
	})
end

function CollegeStatHelper:statElementTime(id, time)
	StatController.instance:track(StatEnum.EventName.College_MapElement, {
		[StatEnum.EventProperties.College_ElementId] = id,
		[StatEnum.EventProperties.College_Time] = tostring(time)
	})
end

function CollegeStatHelper:statExit()
	if not self.beginDt then
		return
	end

	local sceneMo = CollegeModel.instance:getSceneMo()

	if not sceneMo then
		return
	end

	local costTime = ServerTime.now() - self.beginDt

	self.beginDt = nil

	local actorList, actorNames = self:buildActors(sceneMo)

	StatController.instance:track(StatEnum.EventName.College_Exit, {
		[StatEnum.EventProperties.College_Stage] = sceneMo.prop.stage,
		[StatEnum.EventProperties.College_Round] = sceneMo.prop.round,
		[StatEnum.EventProperties.College_Actor] = actorList,
		[StatEnum.EventProperties.College_ActorList] = actorNames,
		[StatEnum.EventProperties.College_Currency] = self:buildCurrency(sceneMo),
		[StatEnum.EventProperties.College_Building] = self:buildBuilding(sceneMo),
		[StatEnum.EventProperties.College_Location] = self:buildLocation(sceneMo),
		[StatEnum.EventProperties.College_UseTime] = costTime
	})
end

function CollegeStatHelper:buildActors(sceneMo)
	local t, t2 = {}, {}

	for i, v in ipairs(sceneMo.characterBox.characters) do
		local data = {}

		data.id = v.id
		data.name = v.co.name
		data.level = v.level
		data.entry = {}

		for _, vv in ipairs(v.entries) do
			table.insert(data.entry, vv.id)
		end

		if v.inLocationStatus then
			data.dest = v.inLocationStatus.co.name
		end

		table.insert(t, data)
		table.insert(t2, data.name)
	end

	return t, t2
end

function CollegeStatHelper:buildCurrency(sceneMo)
	local t = {}

	for i, v in ipairs(lua_college_item.configList) do
		local data = {}

		data.id = v.id
		data.name = v.name
		data.num = sceneMo.bag:getItemCount(v.id)
		data.output = CollegeAttrHelper.getBuildingProduce(v.id) + CollegeAttrHelper.getAreaProduce(v.id) + CollegeAttrHelper.getOtherProduce(v.id)

		table.insert(t, data)
	end

	return t
end

function CollegeStatHelper:buildBuilding(sceneMo)
	local t = {}

	for i, v in ipairs(sceneMo.buildingBox.buildings) do
		if v.unlock then
			local data = {}

			data.id = v.id
			data.name = v.co.name
			data.level = v.level

			table.insert(t, data)
		end
	end

	return t
end

function CollegeStatHelper:buildLocation(sceneMo)
	local t = {}

	for i, v in ipairs(sceneMo.worldMap.areas) do
		if v.unlock then
			local data = {}

			data.id = v.id
			data.name = v.co.name
			data.progress = v.explorationProp.progress

			table.insert(t, data)
		end
	end

	return t
end

CollegeStatHelper.instance = CollegeStatHelper.New()

return CollegeStatHelper
