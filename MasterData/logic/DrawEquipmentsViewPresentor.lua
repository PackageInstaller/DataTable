-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/view/DrawEquipmentsViewPresentor.lua

module("logic.extensions.drawequipments.view.DrawEquipmentsViewPresentor", package.seeall)

local DrawEquipmentsViewPresentor = class("DrawEquipmentsViewPresentor", ViewWithGuidePresentor)

function DrawEquipmentsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawEquipmentsViewPresentor:dependWhatResources()
	return {
		"ui/views/drawequipments/drawequipmentsview.prefab"
	}
end

function DrawEquipmentsViewPresentor:buildViews()
	return {
		DrawEquipmentsView.New()
	}
end

function DrawEquipmentsViewPresentor:getTempResources()
	local openPoolId = self:getFirstParam()

	if not openPoolId then
		return
	end

	local pool = DrawEquipmentsModel.instance:getPoolById(openPoolId)

	return {
		pool:getPoolBgk()
	}
end

function DrawEquipmentsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DrawEquipmentsViewPresentor
