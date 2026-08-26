-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/Act183DungeonViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonViewContainer", package.seeall)

local Act183DungeonViewContainer = class("Act183DungeonViewContainer", BaseViewContainer)

function Act183DungeonViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	self._mainView = Act183DungeonView.New()

	table.insert(views, self._mainView)
	table.insert(views, Act183DungeonView_Animation.New())
	table.insert(views, Act183DungeonView_Detail.New())

	return views
end

function Act183DungeonViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:_getHelpId()

		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			helpId ~= nil
		}, helpId)

		return {
			self.navigateView
		}
	end
end

function Act183DungeonViewContainer:_getHelpId()
	local isShowedHelp_Dungeon = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183EnterDungeon)
	local isShowedHelp_Repress = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183Repress)

	if isShowedHelp_Dungeon and isShowedHelp_Repress then
		return HelpEnum.HelpId.Act183DungeonAndRepress
	elseif isShowedHelp_Repress ~= isShowedHelp_Dungeon then
		if isShowedHelp_Repress then
			return HelpEnum.HelpId.Act183Repress
		else
			return HelpEnum.HelpId.Act183EnterDungeon
		end
	end
end

function Act183DungeonViewContainer:getMainView()
	return self._mainView
end

function Act183DungeonViewContainer:refreshHelpId()
	local helpId = self:_getHelpId()

	if helpId ~= nil then
		self.navigateView:setHelpId(helpId)
	end
end

function Act183DungeonViewContainer:onContainerInit()
	self.addEventCb(self, HelpController.instance, HelpEvent.RefreshHelp, self.refreshHelpId, self)
end

return Act183DungeonViewContainer
