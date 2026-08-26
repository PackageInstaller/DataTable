-- chunkname: @modules/logic/tower/model/TowerDeepGroupMo.lua

module("modules.logic.tower.model.TowerDeepGroupMo", package.seeall)

local TowerDeepGroupMo = pureTable("TowerDeepGroupMo")

function TowerDeepGroupMo:init()
	self.teamsDataMap = {}
	self.teamsDataList = {}
end

function TowerDeepGroupMo:reInit()
	self.teamsDataMap = {}
	self.teamsDataList = {}
end

function TowerDeepGroupMo:updateGroupData(info)
	if not info then
		return
	end

	self.archiveId = 0

	if info.currDeep and info.currDeep > 0 then
		self.curDeep = info.currDeep or TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
	end

	self:updateTeamsInfo(info)
end

function TowerDeepGroupMo:updateArchiveData(info)
	if not info then
		return
	end

	self.archiveId = info.archiveNo or 0

	if info.group and info.group.currDeep > 0 then
		self.curDeep = info.group.currDeep or TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
	end

	self.createTime = info.createTime and tonumber(info.createTime) > 0 and tonumber(info.createTime) / 1000 or ServerTime.now()

	self:updateTeamsInfo(info.group)
end

function TowerDeepGroupMo:updateTeamsInfo(info)
	self.teamsDataMap = {}
	self.teamsDataList = {}

	for index, teamInfo in ipairs(info.teams) do
		local teamMo = {}

		teamMo.id = teamInfo.teamNo
		teamMo.heroList = {}

		for _index, heroInfo in ipairs(teamInfo.heroes) do
			local heroMo = {}

			heroMo.heroId = heroInfo.heroId
			heroMo.trialId = heroInfo.trialId

			table.insert(teamMo.heroList, heroMo)
		end

		teamMo.deep = teamInfo.deep
		self.teamsDataMap[teamMo.id] = teamMo

		table.insert(self.teamsDataList, teamMo)
	end
end

function TowerDeepGroupMo:checkHasTeamData()
	for index, teamMo in pairs(self.teamsDataMap) do
		if teamMo.heroList and #teamMo.heroList > 0 then
			return true
		end
	end

	return false
end

function TowerDeepGroupMo:getTeamDataMap()
	return self.teamsDataMap
end

function TowerDeepGroupMo:getTeamDataList()
	return self.teamsDataList
end

function TowerDeepGroupMo:getAllHeroData()
	local allHeroDataList = {}

	for teamIndex, teamMo in ipairs(self.teamsDataList) do
		for index, heroData in ipairs(teamMo.heroList) do
			table.insert(allHeroDataList, heroData)
		end
	end

	return allHeroDataList
end

function TowerDeepGroupMo:getAllUsedHeroId()
	local allUsedHeroList = {}

	for teamIndex, teamMo in ipairs(self.teamsDataList) do
		for index, heroData in ipairs(teamMo.heroList) do
			if heroData.heroId > 0 then
				table.insert(allUsedHeroList, heroData.heroId)
			elseif heroData.trialId > 0 then
				local trialConfig = lua_hero_trial.configDict[heroData.trialId][0]

				table.insert(allUsedHeroList, trialConfig.heroId)
			end
		end
	end

	return allUsedHeroList
end

return TowerDeepGroupMo
