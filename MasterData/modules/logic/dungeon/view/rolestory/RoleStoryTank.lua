-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryTank.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryTank", package.seeall)

local RoleStoryTank = class("RoleStoryTank", UserDataDispose)

function RoleStoryTank:ctor(rootGO)
	self:__onInit()

	self._rootGo = rootGO
	self._txtTaskDesc = gohelper.findChildTextMesh(self._rootGo, "bg/taskDesc")
	self._imageIcon = gohelper.findChildImage(self._rootGo, "bg/icon")
	self._btnTaskReward = gohelper.findChildButtonWithAudio(self._rootGo, "bg/reward/btnReward")
	self._goRewardFinished = gohelper.findChild(self._rootGo, "bg/reward/#go_rewardFinished")
	self._goRewardRed = gohelper.findChild(self._rootGo, "bg/reward/btnReward/reddoticon")

	self.addClickCb(self, self._btnTaskReward, self._btntaskOnClick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.WeekTaskChange, self.refreshTask, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function RoleStoryTank:onOpen()
	self:refreshTask()
	self:checkGetTask()
end

function RoleStoryTank:_onCurrencyChange()
	self:refreshTask()
end

function RoleStoryTank:refreshTask()
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageIcon, "216_1")

	local hasGet = RoleStoryModel.instance:getWeekHasGet()
	local cur = RoleStoryModel.instance:getWeekProgress()
	local max = 1

	self._txtTaskDesc.text = max <= cur and formatLuaLang("rolestory_weektask_desc", string.format(" <color=#D26636>(%s/%s)</color>", cur, max)) or formatLuaLang("rolestory_weektask_desc", string.format(" (%s<color=#D26636>/%s</color>)", cur, max))

	local state = 1

	if hasGet then
		state = 3
	elseif max <= cur then
		state = 2
	end

	gohelper.setActive(self._goRewardFinished, state == 3)
	gohelper.setActive(self._btnTaskReward, state == 2)

	if state == 2 then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory)
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory)
		local maxCount = currencyCO.maxLimit

		gohelper.setActive(self._goRewardRed, quantity < maxCount)
	else
		gohelper.setActive(self._goRewardRed, false)
	end
end

function RoleStoryTank:checkGetTask()
	local hasGet = RoleStoryModel.instance:getWeekHasGet()
	local cur = RoleStoryModel.instance:getWeekProgress()
	local max = 1

	if max <= cur and not hasGet then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory)
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory)
		local maxCount = currencyCO.maxLimit

		if quantity < maxCount then
			HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
		end
	end
end

function RoleStoryTank:_btntaskOnClick()
	local hasGet = RoleStoryModel.instance:getWeekHasGet()
	local cur = RoleStoryModel.instance:getWeekProgress()
	local max = 1

	if max <= cur and not hasGet then
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoleStory)
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.RoleStory)
		local maxCount = currencyCO.maxLimit

		if maxCount <= quantity then
			GameFacade.showToast(ToastEnum.RoleStoryTickMaxCount)
		else
			HeroStoryRpc.instance:sendHeroStoryWeekTaskGetRequest()
		end
	end
end

function RoleStoryTank:onDestroy()
	self:__onDispose()
end

RoleStoryTank.prefabPath = "ui/viewres/dungeon/rolestory/rolestorytank.prefab"

return RoleStoryTank
