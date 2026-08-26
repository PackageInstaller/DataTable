-- chunkname: @modules/logic/survival/model/shelter/SurvivalMapInfoMo.lua

module("modules.logic.survival.model.shelter.SurvivalMapInfoMo", package.seeall)

local SurvivalMapInfoMo = pureTable("SurvivalMapInfoMo")

function SurvivalMapInfoMo:init(data)
	self.mapId = data.mapId
	self.rainId = data.rainId
	self.disasterIds = GameUtil.copyArray(data.disasterId)
	self.taskId = data.taskId

	if self.taskId and self.taskId > 0 then
		self.taskCo = SurvivalConfig.instance:getTaskCo(SurvivalEnum.TaskModule.MapMainTarget, self.taskId)
	end

	self.disasterCos = {}

	for i, id in ipairs(self.disasterIds) do
		local disasterCo = lua_survival_disaster.configDict[id]

		table.insert(self.disasterCos, disasterCo)
	end

	self.rainCo = lua_survival_rain.configDict[self.rainId]

	local groupMapperCo = lua_survival_map_group_mapping.configDict[self.mapId]

	if groupMapperCo then
		self.groupId = groupMapperCo.id or 0
	end

	self.groupCo = lua_survival_map_group.configDict[self.groupId]

	if self.groupCo then
		self.mapType = self.groupCo.type or 0
	end

	self.level = 0
end

return SurvivalMapInfoMo
