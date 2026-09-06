-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidepeticonView.lua

module("logic.extensions.treasureraider.view.TreasureraidepeticonView", package.seeall)

local TreasureraidepeticonView = class("TreasureraidepeticonView", CustomRightCell)

TreasureraidepeticonView.prefabUrl = "ui/views/treasureraider/treasureraidepeticonview.prefab"

function TreasureraidepeticonView:buildUI()
	self._imgTired = goutil.findChild(self.mainGO, "imgTired")
end

function TreasureraidepeticonView:setTire(tired)
	goutil.setActive(self._imgTired, tired)
end

return TreasureraidepeticonView
