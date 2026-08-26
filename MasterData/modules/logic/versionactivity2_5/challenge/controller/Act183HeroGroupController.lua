-- chunkname: @modules/logic/versionactivity2_5/challenge/controller/Act183HeroGroupController.lua

module("modules.logic.versionactivity2_5.challenge.controller.Act183HeroGroupController", package.seeall)

local Act183HeroGroupController = class("Act183HeroGroupController", BaseController)

function Act183HeroGroupController:enterFight(episodeId, readyUseBadgeNum, conditionstatusMap)
	self._episodeId = episodeId
	self._readyUseBadgeNum = readyUseBadgeNum

	local snapshotId = Act183Helper.getEpisodeSnapShotType(episodeId)

	if not snapshotId then
		logError(string.format("编队快照类型不存在 episodeId = %s", episodeId))

		return
	end

	Act183Model.instance:recordEpisodeSelectConditions(conditionstatusMap)
	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._enterFight, self)
end

function Act183HeroGroupController:_enterFight()
	local config = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if not config then
		logError(string.format("关卡配置不存在 episodeId = %s", self._episodeId))

		return
	end

	Act183Model.instance:recordEpisodeReadyUseBadgeNum(self._readyUseBadgeNum)
	DungeonFightController.instance:enterFight(config.chapterId, self._episodeId)
end

function Act183HeroGroupController:saveGroupData(heroGroupMO, heroGroupType, episodeId, callback, callbackObj)
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, self:getMainList(heroGroupMO), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.Common
	local snapshotSubId = 1

	if heroGroupType == ModuleEnum.HeroGroupType.General then
		snapshotId = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		snapshotSubId = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if snapshotId and snapshotSubId then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", snapshotId, snapshotSubId))
	end
end

function Act183HeroGroupController:getMainList(heroGroupMO)
	local mainUids = {}
	local count = 0
	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		if not battleCO.playerMax then
			local playerMax = ModuleEnum.HeroCountInGroup

			for i = 1, playerMax do
				if not heroGroupMO.heroList[i] then
					local uid = "0"

					if tonumber(heroGroupMO.heroList[i]) < 0 then
						uid = "0"
					end

					mainUids[i] = heroGroupMO.heroList[i]

					if heroGroupMO.heroList[i] ~= "0" and heroGroupMO.heroList[i] ~= 0 then
						count = count + 1
					end
				end
			end

			return mainUids, count
		end
	end
end

Act183HeroGroupController.instance = Act183HeroGroupController.New()

return Act183HeroGroupController
