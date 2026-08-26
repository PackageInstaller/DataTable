-- chunkname: @modules/logic/character/controller/CharacterRecommedController.lua

module("modules.logic.character.controller.CharacterRecommedController", package.seeall)

local CharacterRecommedController = class("CharacterRecommedController", BaseController)

function CharacterRecommedController:onInit()
	return
end

function CharacterRecommedController:onInitFinish()
	return
end

function CharacterRecommedController:addConstEvents()
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self._onCurrencyChange, self)
	MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, self._onFirstEnterMain, self)
end

function CharacterRecommedController:reInit()
	return
end

function CharacterRecommedController:_onFirstEnterMain()
	CharacterRecommedModel.instance:initTracedHeroDevelopGoalsMO()

	if not self._tradeIcon then
		self:loadTrade()
	end
end

function CharacterRecommedController:_respBeginFight()
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	if recordFarmItem and not recordFarmItem.isFormHeroTraced then
		return
	end

	local episodeId = FightResultModel.instance:getEpisodeId()
	local item = CharacterRecommedModel.instance:getEpisodeOrChapterTracedItem(episodeId)

	if item then
		local recordFarmItem = {}

		recordFarmItem.type = item.materilType
		recordFarmItem.id = item.materilId
		recordFarmItem.quantity = item.quantity
		recordFarmItem.sceneType = SceneType.Main
		recordFarmItem.openedViewNameList = self:getRecommedViewDict()
		recordFarmItem.isFormHeroTraced = true

		JumpModel.instance:setRecordFarmItem(recordFarmItem)
	end
end

function CharacterRecommedController:_onCurrencyChange()
	self:dispatchEvent(CharacterRecommedEvent.OnRefreshTraced)
end

function CharacterRecommedController:openRecommedView(heroId, fromView, uiSpine, hideRecommedEnum)
	local heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)
	local isShowRecommendTab = heroRecommendMO and (heroRecommendMO:isShowTeam() or heroRecommendMO:isShowEquip())

	if isShowRecommendTab then
		if not CharacterRecommedEnum.TabSubType.RecommedGroup then
			local defaultTabId = CharacterRecommedEnum.TabSubType.DevelopGoals
			local param = {
				heroId = heroId,
				fromView = fromView,
				defaultTabId = defaultTabId,
				uiSpine = uiSpine,
				hideTab = hideRecommedEnum
			}

			ViewMgr.instance:openView(ViewName.CharacterRecommedView, param)
			CharacterRecommedHeroListModel.instance:setMoList(heroId)
		end
	end
end

function CharacterRecommedController:jump(mo)
	mo = mo or CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if not mo then
		return
	end

	local tracedItems = mo:getTracedItems()

	if not tracedItems or #tracedItems == 0 then
		self:jumpLevelUp(mo)

		return
	end

	self:jumpDungeonView()
end

function CharacterRecommedController:jumpLevelUp(mo)
	if mo:getDevelopGoalsType() == CharacterRecommedEnum.DevelopGoalsType.RankLevel then
		local isCurRankMaxLv, heroMo = mo:isCurRankMaxLv()

		if not heroMo or not heroMo:isOwnHero() then
			return
		end

		if isCurRankMaxLv then
			self:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Rank)
			CharacterController.instance:openCharacterRankUpView(heroMo)
		else
			CharacterController.instance:openCharacterView(heroMo)
			CharacterController.instance:openCharacterLevelUpView(heroMo)
			self:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Level)
		end
	else
		local isMaxLv, heroMo = mo:isMaxTalentLv()

		if not heroMo or not heroMo:isOwnHero() then
			return
		end

		if not isMaxLv and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			if heroMo.rank >= CharacterEnum.TalentRank then
				CharacterController.instance:openCharacterTalentView({
					isBack = true,
					heroid = heroMo.heroId,
					heroMo = heroMo
				})
			elseif heroMo.config.heroType == CharacterEnum.HumanHeroType then
				GameFacade.showToast(ToastEnum.CharacterType6, heroMo.config.name)
			else
				GameFacade.showToast(ToastEnum.Character, heroMo.config.name)
			end
		end
	end
end

function CharacterRecommedController:jumpDungeonView()
	self._recommedViewDict = JumpController.instance:getCurrentOpenedView()

	DungeonController.instance:enterDungeonView(true)
	self:dispatchEvent(CharacterRecommedEvent.OnJumpView, CharacterRecommedEnum.JumpView.Dungeon)
end

function CharacterRecommedController:onJumpReturnRecommedView()
	local tradeMo = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if not self._recommedViewDict then
		self._recommedViewDict = {}

		if tradeMo then
			local info = {
				viewName = ViewName.CharacterRecommedView,
				viewParam = {
					defaultTabId = CharacterRecommedEnum.TabSubType.DevelopGoals,
					heroId = tradeMo._heroId
				}
			}

			table.insert(self._recommedViewDict, info)
		end
	end

	for _, openedViewTable in ipairs(self._recommedViewDict) do
		if tradeMo then
			if not tradeMo._heroId then
				local heroId = openedViewTable.viewParam.heroId

				if openedViewTable.viewName == ViewName.CharacterRecommedView then
					local tabId = CharacterRecommedEnum.TabSubType.DevelopGoals

					openedViewTable.viewParam.defaultTabId = tabId
					openedViewTable.viewParam.defaultTabIds = {}
					openedViewTable.viewParam.defaultTabIds[2] = tabId

					CharacterRecommedHeroListModel.instance:setMoList(heroId)
				elseif openedViewTable.viewName == ViewName.CharacterView and heroId then
					openedViewTable.viewParam = HeroModel.instance:getByHeroId(heroId)
				end

				openedViewTable.viewParam.heroId = heroId

				ViewMgr.instance:openView(openedViewTable.viewName, openedViewTable.viewParam)
			end
		end
	end
end

function CharacterRecommedController:getRecommedViewDict()
	return self._recommedViewDict
end

function CharacterRecommedController:loadTrade()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = MultiAbLoader.New()

	self._loader:addPath(CharacterRecommedEnum.TracedIconPath)
	self._loader:startLoad(self._onLoadFinish, self)
end

function CharacterRecommedController:_onLoadFinish()
	self._tradeIcon = self._loader:getFirstAssetItem():GetResource()

	self:dispatchEvent(CharacterRecommedEvent.OnLoadFinishTracedIcon)
end

function CharacterRecommedController:getTradeIcon()
	if not self._tradeIcon then
		self:loadTrade()
	end

	return self._tradeIcon
end

function CharacterRecommedController:replaceHeroGroup()
	return
end

CharacterRecommedController.instance = CharacterRecommedController.New()

return CharacterRecommedController
