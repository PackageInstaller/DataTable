-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower1v1FmtLeftView.lua

module("logic.extensions.mangtower.view.MangTower1v1FmtLeftView", package.seeall)

local MangTower1v1FmtLeftView = class("MangTower1v1FmtLeftView", FormationLeftView)

function MangTower1v1FmtLeftView:onEnter()
	MangTower1v1FmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
end

function MangTower1v1FmtLeftView:onExit()
	MangTower1v1FmtLeftView.super.onExit(self)
end

function MangTower1v1FmtLeftView:_getCurFormId()
	return 0
end

function MangTower1v1FmtLeftView:_getCurFormation()
	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_1V1, nil)
end

function MangTower1v1FmtLeftView:_getCurrTeamId()
	return 1
end

function MangTower1v1FmtLeftView:_saveCurrFmt()
	MangTowerController.instance:saveCurrNormalFormation()
end

return MangTower1v1FmtLeftView
