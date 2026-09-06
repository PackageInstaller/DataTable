-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/model/MangTower3v3FastFormation.lua

module("logic.extensions.mangtower.model.MangTower3v3FastFormation", package.seeall)

local MangTower3v3FastFormation = class("MangTower3v3FastFormation", FastFormation)

function MangTower3v3FastFormation:_getCurFormId()
	return 10
end

function MangTower3v3FastFormation:_getCurFormation()
	local tab = MangTowerModel.instance:getSelectFmtTab()

	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tab)
end

MangTower3v3FastFormation.instance = MangTower3v3FastFormation.New()

return MangTower3v3FastFormation
