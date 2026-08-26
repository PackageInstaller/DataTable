-- chunkname: @modules/logic/season/controller/Activity104HeroGroupController.lua

module("modules.logic.season.controller.Activity104HeroGroupController", package.seeall)

local Activity104HeroGroupController = class("Activity104HeroGroupController", BaseController)

function Activity104HeroGroupController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function Activity104HeroGroupController:reInit()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
end

function Activity104HeroGroupController:_onGetInfoFinish()
	HeroGroupModel.instance:setParam()
end

function Activity104HeroGroupController:openGroupFightView(battleId, episodeId)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(battleId, episodeId)

	local hasUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local userDungeonMO = DungeonModel.instance:getEpisodeInfo(episodeId)
	local hasRecord = userDungeonMO and userDungeonMO.star == DungeonEnum.StarType.Advanced and userDungeonMO.hasRecord
	local pass_model_record = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")
	local isAdvance = Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId)

	if hasUnlock and hasRecord and not string.nilorempty(pass_model_record) and not isAdvance then
		pass_model_record = cjson.decode(pass_model_record)

		if pass_model_record[tostring(episodeId)] then
			FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
			FightRpc.instance:sendGetFightRecordGroupRequest(episodeId)

			return
		end
	end

	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

function Activity104HeroGroupController:_onGetFightRecordGroupReply(fightGroupMO)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, self._onGetFightRecordGroupReply, self)
	HeroGroupModel.instance:setReplayParam(fightGroupMO)
	Activity104Controller.instance:openSeasonHeroGroupFightView()
end

Activity104HeroGroupController.instance = Activity104HeroGroupController.New()

return Activity104HeroGroupController
