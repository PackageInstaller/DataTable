-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129ViewContainer.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129ViewContainer", package.seeall)

local Activity129ViewContainer = class("Activity129ViewContainer", BaseViewContainer)

function Activity129ViewContainer:buildViews()
	local views = {}

	self.heroView = Activity129HeroView.New()
	self.entranceView = Activity129EntranceView.New()
	self.rewardView = Activity129RewardView.New()

	table.insert(views, self.heroView)
	table.insert(views, self.entranceView)
	table.insert(views, self.rewardView)
	table.insert(views, Activity129View.New())
	table.insert(views, Activity129PrizeView.New())
	table.insert(views, Activity129ResultView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_CurrenyBar"))

	return views
end

function Activity129ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self.overrideClose, self)

		return {
			self._navigateButtonsView
		}
	end

	if tabContainerId == 2 then
		local currencyId = Activity129Config.instance:getConstValue1(self.viewParam.actId, Activity129Enum.ConstEnum.CostId)
		local currencyParam = {
			currencyId
		}

		self.currencyView = CurrencyView.New(currencyParam)
		self.currencyView.foreHideBtn = true

		return {
			self.currencyView
		}
	end
end

function Activity129ViewContainer:overrideClose()
	local selectPoolId = Activity129Model.instance:getSelectPoolId()

	if selectPoolId then
		Activity129Model.instance:setSelectPoolId()

		return
	end

	self:closeThis()
end

return Activity129ViewContainer
