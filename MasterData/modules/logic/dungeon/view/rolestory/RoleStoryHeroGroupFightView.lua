-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryHeroGroupFightView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightView", package.seeall)

local RoleStoryHeroGroupFightView = class("RoleStoryHeroGroupFightView", HeroGroupFightView)

function RoleStoryHeroGroupFightView:onInitView()
	RoleStoryHeroGroupFightView.super.onInitView(self)

	self._gotarget = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")

	gohelper.setActive(self._gotarget, false)
end

function RoleStoryHeroGroupFightView:_refreshCost(visible)
	gohelper.setActive(self._gocost, visible)

	local remainCount = self:_getfreeCount()

	gohelper.setActive(self._gopower, not self._enterAfterFreeLimit)
	gohelper.setActive(self._gocount, not self._enterAfterFreeLimit and remainCount > 0)
	gohelper.setActive(self._gonormallackpower, false)
	gohelper.setActive(self._goreplaylackpower, false)

	if self._enterAfterFreeLimit or remainCount > 0 then
		local str = tostring(-1 * math.min(self._multiplication, remainCount))

		self._txtCostNum.text = str
		self._txtReplayCostNum.text = str
		self._txtcostcount.text = string.format("<color=#B3AFAC>%s</color><color=#B26161>%s</color>", luaLang("p_dungeonmaplevel_costcount"), str)

		if remainCount >= self._multiplication then
			self:_refreshBtns(false)

			return
		end
	end

	local costs = GameUtil.splitString2(self.episodeConfig.cost, true)
	local cost1 = costs[1]
	local powerIcon

	if cost1[1] == MaterialEnum.MaterialType.Currency and cost1[2] == CurrencyEnum.CurrencyType.Power then
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)

		powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")
	else
		powerIcon = ItemModel.instance:getItemSmallIcon(cost1[2])
	end

	self._simagepower:LoadImage(powerIcon)
	recthelper.setSize(self._simagepower.transform, 100, 100)
	self:_refreshCostPower()
end

function RoleStoryHeroGroupFightView:_onClickStart()
	local costs = GameUtil.splitString2(self.episodeConfig.cost, true)
	local remainCount = self:_getfreeCount()
	local multi = (self._multiplication or 1) - remainCount
	local items = {}

	for i, v in ipairs(costs) do
		table.insert(items, {
			type = v[1],
			id = v[2],
			quantity = v[3] * multi
		})
	end

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

		return
	end

	self:_closemultcontent()
	self:_enterFight()
end

function RoleStoryHeroGroupFightView:_refreshCostPower()
	local costs = GameUtil.splitString2(self.episodeConfig.cost, true)
	local cost1 = costs[1]

	if not cost1[3] then
		local value = 0
		local showPower = value > 0

		if self._enterAfterFreeLimit then
			showPower = false
		end

		gohelper.setActive(self._gopower, showPower)
		self:_refreshBtns(showPower)

		if not showPower then
			return
		end

		local multiCost = value * ((self._multiplication or 1) - self:_getfreeCount())

		self._txtusepower.text = string.format("-%s", multiCost)

		local isHardChapter = self._chapterConfig.type == DungeonEnum.ChapterType.Hard
		local quantity = ItemModel.instance:getItemQuantity(cost1[1], cost1[2])

		if multiCost <= quantity then
			local usePowerColor = isHardChapter and "#FFFFFF" or "#070706"

			SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#070706" or usePowerColor)
		else
			local usePowerColor = isHardChapter and "#C44945" or "#800015"

			SLFramework.UGUI.GuiHelper.SetColor(self._txtusepower, self._replayMode and "#800015" or usePowerColor)
			gohelper.setActive(self._gonormallackpower, not self._replayMode)
			gohelper.setActive(self._goreplaylackpower, self._replayMode)
		end
	end
end

return RoleStoryHeroGroupFightView
