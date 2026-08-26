-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallViewContainer", package.seeall)

local ArcadeHallViewContainer = class("ArcadeHallViewContainer", BaseViewContainer)

function ArcadeHallViewContainer:buildViews()
	local views = {}

	self._scene = ArcadeHallScene.New()

	table.insert(views, ArcadeHallView.New())
	table.insert(views, TabViewGroup.New(1, "Right/#go_currency"))
	table.insert(views, self._scene)

	return views
end

function ArcadeHallViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._curencyView = ArcadeCurrencyView.New({
			ArcadeEnum.AttributeConst.DiamondCount
		})

		return {
			self._curencyView
		}
	end
end

function ArcadeHallViewContainer:getSceneView()
	return self._scene
end

function ArcadeHallViewContainer:playerActOnDirection(direction)
	if not direction or not self:isCanMove() then
		return
	end

	self._scene:playerActOnDirection(direction)
end

function ArcadeHallViewContainer:isCanMove()
	local var_5_0 = self._scene

	if self._scene then
		var_5_0 = self._scene:isCanMove()
		var_5_0 = var_5_0 and not self:isOpenView()
	end

	return var_5_0
end

function ArcadeHallViewContainer:isOpenView()
	for _, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		local viewName = param.ViewName

		if viewName and ViewMgr.instance:isOpen(viewName) then
			return true
		end
	end
end

return ArcadeHallViewContainer
