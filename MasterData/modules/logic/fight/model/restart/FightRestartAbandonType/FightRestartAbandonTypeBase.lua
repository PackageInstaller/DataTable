-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonTypeBase.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonTypeBase", package.seeall)

local FightRestartAbandonTypeBase = class("FightRestartAbandonTypeBase", UserDataDispose)

function FightRestartAbandonTypeBase:episodeCostIsEnough()
	self._box_type = MessageBoxIdDefine.RestartStage62

	if not string.nilorempty(self._episode_config.failCost) then
		local arr = string.splitToNumber(self._episode_config.failCost, "#")

		if arr[3] == 0 then
			return true
		end

		local item_config, item_icon = ItemModel.instance:getItemConfigAndIcon(arr[1], arr[2])

		if item_config then
			local box_type = MessageBoxIdDefine.RestartStage62
			local own_count = ItemModel.instance:getItemQuantity(arr[1], arr[2])
			local challenge_cost = string.splitToNumber(self._episode_config.cost, "#")[3]
			local is_enough = false

			if arr[1] == 2 and arr[2] == 4 then
				local fightParam = FightModel.instance:getFightParam()
				local episodeId = fightParam and fightParam.episodeId

				is_enough = true

				local config = DungeonConfig.instance:getEpisodeCO(episodeId)

				if config then
					::label_1_0::

					local chapterConfig = DungeonConfig.instance:getChapterCO(config.chapterId)

					if chapterConfig and chapterConfig.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(chapterConfig.type) > 0 then
						box_type = MessageBoxIdDefine.DungeonEquipRestart
						is_enough = true
					end
				end
			else
				box_type = MessageBoxIdDefine.RestartStage63
				is_enough = challenge_cost <= own_count - arr[3]
			end

			self._box_type = box_type
			self._cost_item_config = item_config

			if is_enough then
				return true
			else
				GameFacade.showMessageBox(self._box_type, MsgBoxEnum.BoxType.Yes_No, function()
					GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, item_icon, item_config.name)
				end, function()
					FightGameMgr.restartMgr:cancelRestart()
				end, nil, nil, nil, nil, self._cost_item_config.name)

				return false
			end
		end
	else
		return true
	end

	return false
end

function FightRestartAbandonTypeBase:confirmNotice()
	if self._cost_item_config then
		GameFacade.showMessageBox(self._box_type, MsgBoxEnum.BoxType.Yes_No, function()
			FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)

			if self.IS_DEAD then
				ToastController.instance:showToast(-80)

				return
			end

			self:startAbandon()
		end, function()
			FightGameMgr.restartMgr:cancelRestart()
		end, nil, nil, nil, nil, self._cost_item_config)
	end
end

function FightRestartAbandonTypeBase:_onPushEndFight()
	self.IS_DEAD = true

	FightGameMgr.restartMgr:cancelRestart()

	if self._box_type then
		ViewMgr.instance:closeView(ViewName.MessageBoxView)
	end
end

function FightRestartAbandonTypeBase:abandon()
	if self.confirmNotice then
		FightController.instance:registerCallback(FightEvent.PushEndFight, self._onPushEndFight, self, LuaEventSystem.High)
		self:confirmNotice()
	else
		self:startAbandon()
	end
end

function FightRestartAbandonTypeBase:releaseEvent()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._onPushEndFight, self)
end

function FightRestartAbandonTypeBase:canRestart()
	return
end

function FightRestartAbandonTypeBase:startAbandon()
	return
end

return FightRestartAbandonTypeBase
