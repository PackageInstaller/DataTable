-- chunkname: @modules/logic/versionactivity2_4/pinball/controller/PinballStatHelper.lua

module("modules.logic.versionactivity2_4.pinball.controller.PinballStatHelper", package.seeall)

local PinballStatHelper = class("PinballStatHelper")

function PinballStatHelper:ctor()
	self._gameBeginDt = 0
	self._cityBeginDt = 0
	self._useBallList = {}
end

function PinballStatHelper:resetGameDt()
	self._gameBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function PinballStatHelper:resetCityDt()
	self._cityBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function PinballStatHelper:setCurUseBallList(list)
	self._useBallList = list
end

function PinballStatHelper:sendGameFinish()
	local episodeId = PinballModel.instance.leftEpisodeId
	local episodeCo = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][episodeId]

	if not episodeCo then
		return
	end

	local rewardList = {}

	for type, num in pairs(PinballModel.instance.gameAddResDict) do
		table.insert(rewardList, {
			id = type,
			num = num
		})
	end

	StatController.instance:track(StatEnum.EventName.act178_game_finish, {
		[StatEnum.EventProperties.EpisodeId_Num] = episodeCo.id,
		[StatEnum.EventProperties.EpisodeType_Num] = episodeCo.type,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self._gameBeginDt,
		[StatEnum.EventProperties.Act178BallList] = self._useBallList,
		[StatEnum.EventProperties.Act178RewardInfo] = rewardList,
		[StatEnum.EventProperties.Act178CityObj] = self:_getCityInfo()
	})
end

function PinballStatHelper:sendExitCity()
	StatController.instance:track(StatEnum.EventName.act178_interface_exit, {
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self._cityBeginDt,
		[StatEnum.EventProperties.Act178CityObj] = self:_getCityInfo()
	})
end

function PinballStatHelper:sendResetCity()
	StatController.instance:track(StatEnum.EventName.act178_reset, {
		[StatEnum.EventProperties.Act178CityObj] = self:_getCityInfo()
	})
end

function PinballStatHelper:_getCityInfo()
	local cityInfo = {}

	cityInfo.wood = PinballModel.instance:getResNum(PinballEnum.ResType.Wood)
	cityInfo.mine = PinballModel.instance:getResNum(PinballEnum.ResType.Mine)
	cityInfo.stone = PinballModel.instance:getResNum(PinballEnum.ResType.Stone)
	cityInfo.food = PinballModel.instance:getResNum(PinballEnum.ResType.Food)
	cityInfo.play = PinballModel.instance:getResNum(PinballEnum.ResType.Play)
	cityInfo.complaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint)
	cityInfo.score = PinballModel.instance:getResNum(PinballEnum.ResType.Score)
	cityInfo.day = PinballModel.instance.day
	cityInfo.building_list = {}

	for _, buildingMo in pairs(PinballModel.instance._buildingInfo) do
		table.insert(cityInfo.building_list, string.format("%d_%d", buildingMo.baseCo.id, buildingMo.level))
	end

	cityInfo.talent_list = {}

	for _, talentMo in pairs(PinballModel.instance._unlockTalents) do
		table.insert(cityInfo.talent_list, talentMo.co.id)
	end

	return cityInfo
end

PinballStatHelper.instance = PinballStatHelper.New()

return PinballStatHelper
