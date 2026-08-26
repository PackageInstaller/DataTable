-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonInteractViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractViewContainer", package.seeall)

local OdysseyDungeonInteractViewContainer = class("OdysseyDungeonInteractViewContainer", BaseViewContainer)

function OdysseyDungeonInteractViewContainer:buildViews()
	local views = {}

	self.odysseyDungeonInteractFightView = OdysseyDungeonInteractFightView.New()

	table.insert(views, self.odysseyDungeonInteractFightView)
	table.insert(views, OdysseyDungeonInteractView.New())

	return views
end

function OdysseyDungeonInteractViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function OdysseyDungeonInteractViewContainer:getInteractFightView()
	return self.odysseyDungeonInteractFightView
end

return OdysseyDungeonInteractViewContainer
