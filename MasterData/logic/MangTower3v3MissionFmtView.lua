-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower3v3MissionFmtView.lua

module("logic.extensions.mission.view.MangTower3v3MissionFmtView", package.seeall)

local MangTower3v3MissionFmtView = class("MangTower3v3MissionFmtView", MissionFmtView)

function MangTower3v3MissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local creepsMasterId = params.creepsMasterIds
		local selectTab = MangTowerModel.instance:getSelectFmtTab()

		cCfg = MangTowerConfig.instance:getCreepCfg(checknumber(creepsMasterId[selectTab]))
	end

	return cCfg
end

function MangTower3v3MissionFmtView:onEnter()
	MangTower3v3MissionFmtView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
end

function MangTower3v3MissionFmtView:onExit()
	MangTower3v3MissionFmtView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
end

function MangTower3v3MissionFmtView:_onCurFormTabChange()
	self:_refreshFromation()
	self:_setHeroSkillEffect()
end

function MangTower3v3MissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function MangTower3v3MissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力:？？？")
end

function MangTower3v3MissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度:？？？")
end

function MangTower3v3MissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return MangTower3v3MissionFmtView
