-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5BuildModel.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5BuildModel", package.seeall)

local VersionActivity1_5BuildModel = class("VersionActivity1_5BuildModel", BaseModel)

function VersionActivity1_5BuildModel:onInit()
	return
end

function VersionActivity1_5BuildModel:reInit()
	return
end

function VersionActivity1_5BuildModel:initBuildInfoList(info)
	self.selectBuildList = {}
	self.selectTypeList = {
		0,
		0,
		0
	}
	self.hadBuildList = {}
	self.buildGroupHadBuildCount = {
		0,
		0,
		0
	}

	for _, buildId in ipairs(info.selectIds) do
		table.insert(self.selectBuildList, buildId)
	end

	self:updateSelectTypeList()

	for _, buildId in ipairs(info.ownBuildingIds) do
		table.insert(self.hadBuildList, buildId)
	end

	self:updateGroupHadBuildCount()

	self.hasGainedReward = info.gainedReward
end

function VersionActivity1_5BuildModel:addHadBuild(buildId)
	if tabletool.indexOf(self.hadBuildList, buildId) then
		return
	end

	table.insert(self.hadBuildList, buildId)
	self:updateGroupHadBuildCount()

	local buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCo(buildId)

	self:setSelectBuildId(buildCo)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, buildId)
end

function VersionActivity1_5BuildModel:updateSelectBuild(buildIdList)
	tabletool.clear(self.selectBuildList)

	for _, buildId in ipairs(buildIdList) do
		table.insert(self.selectBuildList, buildId)
	end

	self:updateSelectTypeList()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateSelectBuild)
end

function VersionActivity1_5BuildModel:updateGainedReward(gained)
	self.hasGainedReward = gained

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward)
end

function VersionActivity1_5BuildModel:updateSelectTypeList()
	for i = 1, #self.selectTypeList do
		self.selectTypeList[i] = 0
	end

	for _, buildId in ipairs(self.selectBuildList) do
		if self:checkBuildIdIsSelect(buildId) then
			local buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCo(buildId)

			self.selectTypeList[buildCo.group] = buildCo.type
		end
	end
end

function VersionActivity1_5BuildModel:checkBuildIdIsSelect(build)
	return tabletool.indexOf(self.selectBuildList, build)
end

function VersionActivity1_5BuildModel:checkBuildIsHad(buildId)
	return tabletool.indexOf(self.hadBuildList, buildId)
end

function VersionActivity1_5BuildModel:updateGroupHadBuildCount()
	for i = 1, #self.buildGroupHadBuildCount do
		self.buildGroupHadBuildCount[i] = 0
	end

	for i, buildId in ipairs(self.hadBuildList) do
		local buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCo(buildId)
		local group = buildCo.group

		self.buildGroupHadBuildCount[group] = self.buildGroupHadBuildCount[group] + 1
	end
end

function VersionActivity1_5BuildModel:getCanBuildCount(groupId)
	return self.buildGroupHadBuildCount[groupId]
end

function VersionActivity1_5BuildModel:getSelectBuildIdList()
	return self.selectBuildList
end

function VersionActivity1_5BuildModel:getSelectType(groupId)
	return self.selectTypeList[groupId]
end

function VersionActivity1_5BuildModel:getSelectTypeList()
	return self.selectTypeList
end

function VersionActivity1_5BuildModel:setSelectBuildId(buildCo)
	self.selectTypeList[buildCo.group] = buildCo.type

	tabletool.clear(self.selectBuildList)

	for groupId, type in pairs(self.selectTypeList) do
		if type ~= VersionActivity1_5DungeonEnum.BuildType.None then
			buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(groupId, type)

			table.insert(self.selectBuildList, buildCo.id)
		end
	end
end

function VersionActivity1_5BuildModel:getHadBuildCount()
	return #self.hadBuildList
end

function VersionActivity1_5BuildModel:getBuildCoByGroupIndex(groupIndex)
	local selectType = self:getSelectType(groupIndex)

	if selectType == VersionActivity1_5DungeonEnum.BuildType.None then
		return nil
	end

	return VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(groupIndex, selectType)
end

function VersionActivity1_5BuildModel.getTextByType(type, text)
	local color = VersionActivity1_5DungeonEnum.BuildType2TextColor[type]

	color = color or VersionActivity1_5DungeonEnum.BuildType2TextColor[VersionActivity1_5DungeonEnum.BuildType.None]

	return string.format("<color=%s>%s</color>", color, text)
end

VersionActivity1_5BuildModel.instance = VersionActivity1_5BuildModel.New()

return VersionActivity1_5BuildModel
