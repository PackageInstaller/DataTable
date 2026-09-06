-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareRightView.lua

module("logic.extensions.sharetask.view.ShareRightView", package.seeall)

local ShareRightView = class("ShareRightView", FormationRightView)

function ShareRightView:getAllShowPetList()
	return ShareTaskModel.instance:getAllShowPetList()
end

function ShareRightView:_getCurFormation()
	return ShareTaskModel.instance:_getCurFormation()
end

return ShareRightView
