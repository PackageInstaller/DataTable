-- chunkname: @modules/logic/dungeon/model/RoleStoryDispatchHeroListModel.lua

module("modules.logic.dungeon.model.RoleStoryDispatchHeroListModel", package.seeall)

local RoleStoryDispatchHeroListModel = class("RoleStoryDispatchHeroListModel", ListScrollModel)

function RoleStoryDispatchHeroListModel:onOpenDispatchView(storyMo, dispatchMo)
	self.storyMo = storyMo
	self.dispatchMo = dispatchMo
	self.maxSelectCount = dispatchMo.config.count

	self:refreshEffectHero()
	self:initHeroList()
end

function RoleStoryDispatchHeroListModel:canShowTalk(talkCfg)
	if not talkCfg then
		return false
	end

	local heroId = tonumber(talkCfg.heroid) or 0

	if not heroId or heroId == 0 then
		return true
	end

	return self:getSelectedIndex(heroId) ~= nil
end

function RoleStoryDispatchHeroListModel:refreshEffectHero()
	self.effectHeroDict = self.dispatchMo:getEffectHeros()
end

function RoleStoryDispatchHeroListModel:isEffectHero(heroId)
	return self.effectHeroDict[heroId]
end

function RoleStoryDispatchHeroListModel:refreshHero()
	self:resortHeroList()
	self:setList(self.heroList)
end

function RoleStoryDispatchHeroListModel:resortHeroList()
	table.sort(self.heroList, RoleStoryDispatchHeroListModel._sortFunc)
end

function RoleStoryDispatchHeroListModel._sortFunc(heroMo1, heroMo2)
	local heroMo1Dispatched = heroMo1:isDispatched()
	local heroMo2Dispatched = heroMo2:isDispatched()

	if heroMo1Dispatched ~= heroMo2Dispatched then
		return heroMo2Dispatched
	end

	local heroMo1IsEffect = heroMo1:isEffectHero()
	local heroMo2IsEffect = heroMo2:isEffectHero()

	if heroMo1IsEffect ~= heroMo2IsEffect then
		return heroMo1IsEffect
	end

	if heroMo1.rare ~= heroMo2.rare then
		return heroMo1.rare > heroMo2.rare
	end

	if heroMo1.level ~= heroMo2.level then
		return heroMo1.level > heroMo2.level
	end

	return heroMo1.heroId > heroMo2.heroId
end

function RoleStoryDispatchHeroListModel:initHeroList()
	if self.heroList then
		return
	end

	self.heroList = {}
	self.heroDict = {}

	for _, heroMo in ipairs(HeroModel.instance:getList()) do
		if not self.heroDict[heroMo.heroId] then
			local dispatchHeroMo = RoleStoryDispatchHeroMo.New()

			dispatchHeroMo:init(heroMo, self.storyMo.id, self:isEffectHero(heroMo.heroId))
			table.insert(self.heroList, dispatchHeroMo)

			self.heroDict[dispatchHeroMo.heroId] = dispatchHeroMo
		end
	end
end

function RoleStoryDispatchHeroListModel:initSelectedHeroList(heros)
	self.selectedHeroList = {}
	self.selectedHeroIndexDict = {}

	if heros then
		for index, heroId in ipairs(heros) do
			local dispatchHeroMo = self:getDispatchHeroMo(heroId)

			if dispatchHeroMo then
				table.insert(self.selectedHeroList, dispatchHeroMo)

				self.selectedHeroIndexDict[heroId] = index
			else
				logError("not found dispatched hero id : " .. tostring(heroId))
			end
		end
	end
end

function RoleStoryDispatchHeroListModel:sendDispatch()
	if not self.storyMo or not self.dispatchMo then
		return
	end

	local state = self.dispatchMo:getDispatchState()

	if state ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local costs = GameUtil.splitString2(self.dispatchMo.config.consume, true)
	local count = 1
	local items = {}

	for i, v in ipairs(costs) do
		table.insert(items, {
			type = v[1],
			id = v[2],
			quantity = v[3] * count
		})
	end

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, icon, notEnoughItemName)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, icon, notEnoughItemName)
		end

		return
	end

	local heroIds = self:getDispatchHeros()

	if #heroIds ~= self.maxSelectCount then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLessMinHero)

		return
	end

	local list = {}

	for i, v in ipairs(heroIds) do
		table.insert(list, v.heroId)
	end

	if self.storyMo:isScoreFull() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchTips, MsgBoxEnum.BoxType.Yes_No, function()
			HeroStoryRpc.instance:sendHeroStoryDispatchRequest(self.storyMo.id, self.dispatchMo.id, list)
		end)

		return
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchRequest(self.storyMo.id, self.dispatchMo.id, list)
end

function RoleStoryDispatchHeroListModel:isEnoughHeroCount()
	local heroIds = self:getDispatchHeros()

	return #heroIds >= self.maxSelectCount
end

function RoleStoryDispatchHeroListModel:sendReset()
	if not self.storyMo or not self.dispatchMo then
		return
	end

	local state = self.dispatchMo:getDispatchState()

	if state ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchResetTips, MsgBoxEnum.BoxType.Yes_No, function()
		if self.dispatchMo:getDispatchState() == RoleStoryEnum.DispatchState.Dispatching then
			HeroStoryRpc.instance:sendHeroStoryDispatchResetRequest(self.storyMo.id, self.dispatchMo.id)
		end
	end)
end

function RoleStoryDispatchHeroListModel:sendGetReward()
	if not self.storyMo or not self.dispatchMo then
		return
	end

	local state = self.dispatchMo:getDispatchState()

	if state ~= RoleStoryEnum.DispatchState.Canget then
		return
	end

	if self.storyMo:isScoreFull() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchRewardTips)
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchCompleteRequest(self.storyMo.id, self.dispatchMo.id)
end

function RoleStoryDispatchHeroListModel:clickHeroMo(mo)
	if not mo then
		return
	end

	if mo:isDispatched() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchSelectTips)

		return
	end

	if self.selectedHeroIndexDict[mo.heroId] then
		self:deselectMo(mo)
	else
		self:selectMo(mo)
	end
end

function RoleStoryDispatchHeroListModel:selectMo(mo)
	if not mo then
		return
	end

	if self.selectedHeroIndexDict[mo.heroId] then
		return
	end

	if #self.selectedHeroList == self.maxSelectCount then
		return
	end

	table.insert(self.selectedHeroList, mo)

	self.selectedHeroIndexDict[mo.heroId] = #self.selectedHeroList

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function RoleStoryDispatchHeroListModel:deselectMo(mo)
	if not mo then
		return
	end

	local deleteIndex = self.selectedHeroIndexDict[mo.heroId]

	if not deleteIndex then
		return
	end

	table.remove(self.selectedHeroList, deleteIndex)

	self.selectedHeroIndexDict[mo.heroId] = nil

	for index, heroMo in ipairs(self.selectedHeroList) do
		self.selectedHeroIndexDict[heroMo.heroId] = index
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function RoleStoryDispatchHeroListModel:getDispatchHeroMo(heroId)
	return self.heroDict[heroId]
end

function RoleStoryDispatchHeroListModel:getSelectedIndex(heroId)
	return self.selectedHeroIndexDict[heroId]
end

function RoleStoryDispatchHeroListModel:getDispatchHeros()
	return self.selectedHeroList
end

function RoleStoryDispatchHeroListModel:getDispatchHeroIndexDict()
	return self.selectedHeroIndexDict
end

function RoleStoryDispatchHeroListModel:resetSelectHeroList()
	self.selectedHeroList = {}
	self.selectedHeroIndexDict = {}
end

function RoleStoryDispatchHeroListModel:onCloseDispatchView()
	self:clear()
end

function RoleStoryDispatchHeroListModel:clearSelectedHeroList()
	self.selectedHeroList = nil
	self.selectedHeroIndexDict = nil
end

function RoleStoryDispatchHeroListModel:clear()
	self:clearSelectedHeroList()

	self.heroList = nil
	self.heroDict = nil

	RoleStoryDispatchHeroListModel.super.clear(self)
end

RoleStoryDispatchHeroListModel.instance = RoleStoryDispatchHeroListModel.New()

return RoleStoryDispatchHeroListModel
