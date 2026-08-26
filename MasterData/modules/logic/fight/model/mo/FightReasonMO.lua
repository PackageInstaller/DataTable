-- chunkname: @modules/logic/fight/model/mo/FightReasonMO.lua

module("modules.logic.fight.model.mo.FightReasonMO", package.seeall)

local FightReasonMO = pureTable("FightReasonMO")

function FightReasonMO:init(info)
	self.type = info.type
	self.content = info.content
	self.episodeId = tonumber(self.content)
	self.battleId = info.battleId
	self.multiplication = info.multiplication
	self.data = info.data

	self:_parseData()
end

function FightReasonMO:_parseData()
	if not self.episodeId then
		return
	end

	local co = DungeonConfig.instance:getEpisodeCO(self.episodeId)

	if co.type == DungeonEnum.EpisodeType.WeekWalk or co.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		local dataList = string.splitToNumber(self.data, "#")

		self.layerId = dataList[2]
		self.elementId = dataList[3]
	elseif co.type == DungeonEnum.EpisodeType.Meilanni then
		local dataList = string.splitToNumber(self.data, "#")

		self.battleId = dataList[#dataList]
		self.eventEpisodeId = dataList[3]
	elseif co.type == DungeonEnum.EpisodeType.Dog then
		local dataList = string.splitToNumber(self.data, "#")

		self.fromChessGame = true
		self.actId = dataList[1]
		self.actElementId = dataList[2]
		self.battleId = dataList[3]
		self.actEpisodeId = dataList[4]
	elseif co.type == DungeonEnum.EpisodeType.TowerPermanent or co.type == DungeonEnum.EpisodeType.TowerBoss or co.type == DungeonEnum.EpisodeType.TowerLimited or co.type == DungeonEnum.EpisodeType.TowerBossTeach then
		local dataList = string.splitToNumber(self.data, "#")

		TowerModel.instance:setRecordFightParam(dataList[1], dataList[2], dataList[3], dataList[4], dataList[5])
	elseif co.type == DungeonEnum.EpisodeType.TowerDeep then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest()
		TowerModel.instance:setRecordFightParam(nil, nil, nil, nil, self.episodeId)
	elseif co.type == DungeonEnum.EpisodeType.TowerCompose then
		TowerComposeRpc.instance:sendTowerComposeGetInfoRequest()

		local dataParams = cjson.decode(self.data)

		TowerComposeModel.instance:setRecordFightParam(dataParams.themeId, dataParams.layerId, self.episodeId, true)
		TowerComposeModel.instance:setCurFightPlaneId(self.data, true)
	elseif co.type == DungeonEnum.EpisodeType.Season166Base or co.type == DungeonEnum.EpisodeType.Season166Train then
		Season166Model.instance:unpackFightReconnectData(self.data)
	elseif co.type == DungeonEnum.EpisodeType.Act183 then
		Act183Controller.instance:onReconnectFight(self.episodeId)
	elseif co.type == DungeonEnum.EpisodeType.Abyss then
		local dataParams = cjson.decode(self.data)

		AbyssController.instance:onReconnectFight(dataParams)
	end
end

return FightReasonMO
