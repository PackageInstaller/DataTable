-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairViewContainer", package.seeall)

local VersionActivity1_8FactoryRepairViewContainer = class("VersionActivity1_8FactoryRepairViewContainer", BaseViewContainer)

function VersionActivity1_8FactoryRepairViewContainer:buildViews()
	local repairView = VersionActivity1_8FactoryRepairView.New()

	self._gameMap = VersionActivity1_8FactoryRepairGameMap.New()

	local pieceView = VersionActivity1_8FactoryRepairPieceView.New()

	return {
		repairView,
		self._gameMap,
		pieceView,
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function VersionActivity1_8FactoryRepairViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		navigateView
	}
end

function VersionActivity1_8FactoryRepairViewContainer:getPipes()
	return self._gameMap
end

function VersionActivity1_8FactoryRepairViewContainer:getPipesXYByPosition(position)
	return self._gameMap:getXYByPosition(position)
end

function VersionActivity1_8FactoryRepairViewContainer:onContainerInit()
	VersionActivity1_8StatController.instance:startStat()
end

function VersionActivity1_8FactoryRepairViewContainer:onContainerClose()
	VersionActivity1_8StatController.instance:statAbort()
end

return VersionActivity1_8FactoryRepairViewContainer
