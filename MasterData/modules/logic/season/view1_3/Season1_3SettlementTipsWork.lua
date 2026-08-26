-- chunkname: @modules/logic/season/view1_3/Season1_3SettlementTipsWork.lua

module("modules.logic.season.view1_3.Season1_3SettlementTipsWork", package.seeall)

local Season1_3SettlementTipsWork = class("Season1_3SettlementTipsWork", BaseWork)

function Season1_3SettlementTipsWork:onStart(context)
	self._context = context

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if PopupController.instance:getPopupCount() > 0 then
		PopupController.instance:setPause("fightsuccess", false)

		self._showPopupView = true
	else
		self:_showEquipGet()
	end
end

function Season1_3SettlementTipsWork:_showEquipGet()
	PopupController.instance:setPause("fightsuccess", false)

	local reward_list = {}

	tabletool.addValues(reward_list, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(reward_list, FightResultModel.instance:getMaterialDataList())

	local equip_cards = {}

	for i = #reward_list, 1, -1 do
		local data = reward_list[i]

		if data.materilType == MaterialEnum.MaterialType.EquipCard then
			local tar_reward = table.remove(reward_list, i)

			table.insert(equip_cards, tar_reward.materilId)
		end
	end

	self._showEquipCard = {}
	self._choiceCards = {}

	local onlyShowNewCard = self._context.onlyShowNewCard

	for i, cardId in ipairs(equip_cards) do
		if SeasonConfig.instance:getEquipIsOptional(cardId) then
			table.insert(self._choiceCards, cardId)
		elseif onlyShowNewCard then
			if Activity104Model.instance:isNew104Equip(cardId) then
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
	elseif #self._choiceCards > 0 then
		TaskDispatcher.runDelay(self._showChoiceCardView, self, delayTime)
	else
		self:onDone(true)
	end
end

function Season1_3SettlementTipsWork:_onCloseViewFinish(viewName)
	if self._showPopupView then
		if PopupController.instance:getPopupCount() == 0 then
			self._showPopupView = nil

			self:_showEquipGet()
		end
	else
		local getViewName = SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView)

		if viewName == getViewName then
			if self:_showChoiceCardView() then
				return
			end

			self:onDone(true)
		end
	end
end

function Season1_3SettlementTipsWork:_showGetCardView()
	Activity104Controller.instance:openSeasonCelebrityCardGetlView({
		is_item_id = true,
		data = self._showEquipCard
	})
end

function Season1_3SettlementTipsWork:_showChoiceCardView()
	if self._choiceCards and #self._choiceCards > 0 then
		local cardId = table.remove(self._choiceCards, 1)
		local cardUid = Activity104Model.instance:getItemEquipUid(cardId)

		if cardUid then
			local param = {}

			param.actId = Activity104Model.instance:getCurSeasonId()
			param.costItemUid = cardUid

			Activity104Controller.instance:openSeasonEquipSelectChoiceView(param)

			return true
		end
	end
end

function Season1_3SettlementTipsWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return Season1_3SettlementTipsWork
