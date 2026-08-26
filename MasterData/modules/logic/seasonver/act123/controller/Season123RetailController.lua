-- chunkname: @modules/logic/seasonver/act123/controller/Season123RetailController.lua

module("modules.logic.seasonver.act123.controller.Season123RetailController", package.seeall)

local Season123RetailController = class("Season123RetailController", BaseController)

function Season123RetailController:onOpenView(actId)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, self.handleStartEnterBattle, self)
	Season123RetailModel.instance:init(actId)
end

function Season123RetailController:onCloseView()
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, self.handleStartEnterBattle, self)
	Season123RetailModel.instance:release()
end

function Season123RetailController:enterRetailFightScene()
	local ticketNum = Season123RetailModel.instance:getUTTUTicketNum()
	local actId = Season123RetailModel.instance.activityId

	if ticketNum <= 0 then
		local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(ticketId)

		if currencyCO then
			GameFacade.showToast(ToastEnum.NotEnoughId, currencyCO.name)
		end

		return
	end

	local episodeId = Season123RetailModel.instance:getEpisodeId()

	if episodeId then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = Season123RetailModel.instance.episodeCO

		self:startBattle(actId, episodeId)
	end
end

function Season123RetailController:startBattle(actId, episodeId)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", actId, episodeId))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	Season123Model.instance:setBattleContext(actId, nil, nil, episodeId)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

function Season123RetailController:handleStartEnterBattle(param)
	if not Season123RetailModel.instance.lastSendEpisodeCfg then
		return
	end

	local lastEpisodeCfg = Season123RetailModel.instance.lastSendEpisodeCfg
	local actId = param.actId

	if lastEpisodeCfg and actId == Season123RetailModel.instance.activityId then
		DungeonFightController.instance:enterSeasonFight(lastEpisodeCfg.chapterId, lastEpisodeCfg.id)
	end
end

Season123RetailController.instance = Season123RetailController.New()

LuaEventSystem.addEventMechanism(Season123RetailController.instance)

return Season123RetailController
