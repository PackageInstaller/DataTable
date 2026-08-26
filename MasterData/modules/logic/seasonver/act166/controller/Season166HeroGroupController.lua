-- chunkname: @modules/logic/seasonver/act166/controller/Season166HeroGroupController.lua

module("modules.logic.seasonver.act166.controller.Season166HeroGroupController", package.seeall)

local Season166HeroGroupController = class("Season166HeroGroupController", BaseController)

function Season166HeroGroupController:onOpenViewInitData(actId, episodeId)
	local battleContext = Season166Model.instance:getBattleContext()

	if battleContext then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(battleContext.episodeId)

		if episodeCO then
			HeroGroupTrialModel.instance:setTrialByBattleId(episodeCO.battleId)
		end
	end

	Season166HeroGroupEditModel.instance:init(actId, episodeId)
	Season166HeroGroupQuickEditModel.instance:init(actId, episodeId)
end

function Season166HeroGroupController:onCloseViewCleanData()
	self:saveCurrentHeroGroup()
end

function Season166HeroGroupController:cleanAssistHeroGroup()
	local assistMO = Season166HeroSingleGroupModel.instance.assistMO

	if not assistMO then
		return
	end

	Season166HeroSingleGroupModel.instance:removeFrom(assistMO.id)
	Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(nil)
end

function Season166HeroGroupController:openHeroGroupView(battleId, episodeId)
	local context = Season166Model.instance:getBattleContext()

	if not context then
		return
	end

	Season166HeroGroupModel.instance:setParam(battleId, episodeId)
	Season166HeroGroupModel.instance:cleanAssistData()

	HeroGroupModel.instance.battleId = battleId

	local maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	Season166HeroSingleGroupModel.instance:setMaxHeroCount(maxHeroCount)
	Season166HeroGroupModel.instance:setCurGroupId(1)
	Season166Controller.instance:openHeroGroupFightView({
		actId = context.actId,
		battleId = context.battleId,
		episodeId = context.episodeId
	})
end

function Season166HeroGroupController.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(curGroupMO.clothId) then
		return
	end

	local list = PlayerClothModel.instance:getList()

	for _, clothMO in ipairs(list) do
		if PlayerClothModel.instance:hasCloth(clothMO.id) then
			HeroGroupModel.instance:replaceCloth(clothMO.id)

			return true
		end
	end
end

function Season166HeroGroupController:saveCurrentHeroGroup()
	local actId = Season166HeroGroupModel.instance.actId

	if not actId then
		return
	end

	local seasonMO = Season166Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local heroGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if not heroGroupMO then
		return
	end

	if heroGroupMO.isHaveTrial then
		return
	end

	self:syncHeroGroup(heroGroupMO, 1, actId)
end

function Season166HeroGroupController:syncHeroGroup(heroGroupMO, groupIndex, actId)
	Season166HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)

	local context = Season166Model.instance:getBattleContext()
	local extraData = {}

	extraData.groupIndex = groupIndex
	extraData.heroGroup = heroGroupMO

	if Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Base, context.episodeId, true, extraData)
	elseif Season166HeroGroupModel.instance:isSeason166TrainEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Train, context.episodeId, true, extraData)
	elseif Season166HeroGroupModel.instance:isSeason166TeachEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Teach, context.episodeId, true, extraData)
	end
end

function Season166HeroGroupController:sendStartAct166Battle(configId, chapterId, episodeId, talentId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
	local actId = Season166HeroGroupModel.instance.actId
	local episodeType = episodeId and lua_episode.configDict[episodeId].type

	if not episodeType then
		logError("episodeType is nil, episodeId = " .. episodeId)

		return
	end

	Activity166Rpc.instance:sendStartAct166BattleRequest(actId, episodeType, configId, talentId, chapterId, episodeId, fightParam, multiplication, endAdventure, useRecord, isRestart, callback, callbackObj)
end

Season166HeroGroupController.instance = Season166HeroGroupController.New()

return Season166HeroGroupController
