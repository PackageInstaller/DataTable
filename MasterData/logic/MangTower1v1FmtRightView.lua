-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower1v1FmtRightView.lua

module("logic.extensions.mangtower.view.MangTower1v1FmtRightView", package.seeall)

local MangTower1v1FmtRightView = class("MangTower1v1FmtRightView", FormationRightView)

function MangTower1v1FmtRightView:_getCurFormation()
	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_1V1, nil)
end

return MangTower1v1FmtRightView
