-- chunkname: @modules/logic/seasonver/act123/view/Season123SettlementTipsWork.lua

module("modules.logic.seasonver.act123.view.Season123SettlementTipsWork", package.seeall)

local Season123SettlementTipsWork = class("Season123SettlementTipsWork", BaseWork)

function Season123SettlementTipsWork:onStart(context)
	self._context = context

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if PopupController.instance:getPopupCount() > 0 then
		PopupController.instance:setPause("fightsuccess", false)

		self._showPopupView = true
	else
		self:_showEquipGet()
	end
end

function Season123SettlementTipsWork:_showEquipGet()
	PopupController.instance:setPause("fightsuccess", false)

	local reward_list = {}

	tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

	local equip_cards = {}

	for i = #reward_list, 1, -1 do
		local data = reward_list[i]

		if data.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			local tar_reward = table.remove(reward_list, i)

			table.insert(equip_cards, tar_reward.materilId)
		end
	end

	self._showEquipCard = {}

	local onlyShowNewCard = self._context.onlyShowNewCard

	for i, cardId in ipairs(equip_cards) do
		if onlyShowNewCard then
			if Season123Model.instance:isNewEquipBookCard(cardId) then
				table.insert(self._showEquipCard, cardId)
			end
		else
			table.insert(self._showEquipCard, cardId)
		end
	end

	local delayTime = self._context.delayTime

	if #self._showEquipCard > 0 then
		local idDict = {}

		for i = #self._showEquipCard, 1, -1 do
			local cardId = self._showEquipCard[i]

			if idDict[cardId] then
				table.remove(self._showEquipCard, i)
			else
				idDict[cardId] = true
			end
		end

		TaskDispatcher.runDelay(self._showGetCardView, self, delayTime)
	else
		self:onDone(true)
	end
end

function Season123SettlementTipsWork:_onCloseViewFinish(viewName)
	if self._showPopupView then
		if PopupController.instance:getPopupCount() == 0 then
			self._showPopupView = nil

			self:_showEquipGet()
		end
	else
		local getViewName = ViewName.Season123CelebrityCardGetView

		if viewName == getViewName then
			self:onDone(true)
		end
	end
end

function Season123SettlementTipsWork:_showGetCardView()
	Season123Controller.instance:openSeasonCelebrityCardGetView({
		is_item_id = true,
		data = self._showEquipCard
	})
end

function Season123SettlementTipsWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return Season123SettlementTipsWork
