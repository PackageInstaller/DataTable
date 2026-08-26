-- chunkname: @modules/logic/survival/view/collectionRoom/SurvivalCollectionRoomViewContainer.lua

module("modules.logic.survival.view.collectionRoom.SurvivalCollectionRoomViewContainer", package.seeall)

local SurvivalCollectionRoomViewContainer = class("SurvivalCollectionRoomViewContainer", BaseViewContainer)

function SurvivalCollectionRoomViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		SurvivalCollectionRoomView.New(),
		ShelterSceneUnitView.New()
	}
end

function SurvivalCollectionRoomViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setCloseCheck(self.closeClick, self)

		return {
			navView
		}
	end
end

function SurvivalCollectionRoomViewContainer:closeClick()
	SurvivalController.instance:exitMap()
end

return SurvivalCollectionRoomViewContainer
