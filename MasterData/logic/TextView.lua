-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/TextView.lua

module("logic.extensions.honourtower.view.TextView", package.seeall)

local TextView = class("TextView", CustomRightCell)

TextView.prefabUrl = "ui/views/honourtower/honourtowertextview.prefab"

function TextView:buildUI()
	self._imgTired = goutil.findChild(self.mainGO, "imgTired")
end

function TextView:isTired(tired)
	goutil.setActive(self._imgTired, tired)
end

return TextView
