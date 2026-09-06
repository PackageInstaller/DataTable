-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/CopyFormationRightView.lua

module("logic.extensions.plotcopy.view.CopyFormationRightView", package.seeall)

local CopyFormationRightView = class("CopyFormationRightView", FormationRightView)

function CopyFormationRightView:getAllShowPetList()
	return PlotCopyModel.instance:getAllShowPetList()
end

function CopyFormationRightView:_getCurFormation()
	return PlotCopyModel.instance:_getCurFormation()
end

return CopyFormationRightView
