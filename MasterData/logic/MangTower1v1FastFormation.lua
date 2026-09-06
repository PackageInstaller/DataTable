-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/model/MangTower1v1FastFormation.lua

module("logic.extensions.mangtower.model.MangTower1v1FastFormation", package.seeall)

local MangTower1v1FastFormation = class("MangTower1v1FastFormation", FastFormation)

function MangTower1v1FastFormation:_getCurFormId()
	return 10
end

function MangTower1v1FastFormation:_getCurFormation()
	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_1V1, nil)
end

MangTower1v1FastFormation.instance = MangTower1v1FastFormation.New()

return MangTower1v1FastFormation
