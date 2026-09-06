-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/TiredView.lua

module("logic.extensions.dragonlords.view.TiredView", package.seeall)

local TiredView = class("TiredView", CustomRightCell)

TiredView.prefabUrl = "ui/views/timelimitedchallenge/dragonlords/dragonlordstiredview.prefab"

function TiredView:buildUI()
	self._imgTired = goutil.findChild(self.mainGO, "imgTired")
end

function TiredView:isTired(tired)
	goutil.setActive(self._imgTired, tired)
end

return TiredView
