-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingMissionFmtView", package.seeall)

local LightKingMissionFmtView = class("LightKingMissionFmtView", MissionFmtView)

function LightKingMissionFmtView:onEnter()
	local challengeType = LightKingModel.instance:getCurChallengeType()

	self._isHideZdl = challengeType == 1 or challengeType == 3

	LightKingMissionFmtView.super.onEnter(self)
end

function LightKingMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return LightKingConfig.instance:getCreepsCfg(monsterCfg.creepsMasterId)
end

function LightKingMissionFmtView:_getMonsterCo()
	return LightKingModel.instance:getCurStageCfg()
end

function LightKingMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	local challengeType = LightKingModel.instance:getCurChallengeType()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function LightKingMissionFmtView:_onClickPower()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员战斗力:？？？")
	else
		LightKingMissionFmtView.super._onClickPower(self)
	end
end

function LightKingMissionFmtView:_onClickSpeed()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员速度:？？？")
	else
		LightKingMissionFmtView.super._onClickSpeed(self)
	end
end

function LightKingMissionFmtView:_selectItem(index, isUp)
	if self._isHideZdl then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		LightKingMissionFmtView.super._selectItem(self, index, isUp)
	end
end

return LightKingMissionFmtView
