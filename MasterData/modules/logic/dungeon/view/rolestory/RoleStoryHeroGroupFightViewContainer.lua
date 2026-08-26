-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryHeroGroupFightViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewContainer", package.seeall)

local RoleStoryHeroGroupFightViewContainer = class("RoleStoryHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function RoleStoryHeroGroupFightViewContainer:buildViews()
	self._heroGroupFairyLandView = HeroGroupFairyLandView.New()
	self._heroGroupFightView = RoleStoryHeroGroupFightView.New()

	return {
		self._heroGroupFairyLandView,
		self._heroGroupFightView,
		HeroGroupAnimView.New(),
		HeroGroupListView.New(),
		RoleStoryHeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

function RoleStoryHeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()
		local showHome = not self:_checkHideHomeBtn()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			showHome,
			helpId ~= nil
		}, helpId, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local currencyParam = self:getCurrencyParam()
		local currencyView = CurrencyView.New(currencyParam)

		currencyView.foreHideBtn = true

		return {
			currencyView
		}
	end
end

function RoleStoryHeroGroupFightViewContainer:getCurrencyParam()
	local hidePower = self:_checkHidePowerCurrencyBtn()
	local param = {}

	if not hidePower then
		local episodeId = HeroGroupModel.instance.episodeId
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local costs = GameUtil.splitString2(episodeConfig.cost, true)

		if costs then
			for i, v in ipairs(costs) do
				if v[1] == MaterialEnum.MaterialType.Currency then
					table.insert(param, v[2])
				else
					table.insert(param, {
						isIcon = true,
						type = v[1],
						id = v[2]
					})
				end
			end
		end
	end

	return param
end

return RoleStoryHeroGroupFightViewContainer
