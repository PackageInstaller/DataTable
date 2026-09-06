-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBMissionFmtView.lua

module("logic.extensions.fbbchallenge.view.mission.FBBMissionFmtView", package.seeall)

local FBBMissionFmtView = class("FBBMissionFmtView", MissionFmtView)

function FBBMissionFmtView:onEnter()
	self._isHideZdl = true

	FBBMissionFmtView.super.onEnter(self)
end

function FBBMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return FbbchallengeConfig.instance:getCreepsCfg(monsterCfg.creepsMasterId)
end

function FBBMissionFmtView:_getMonsterCo()
	local creepsMasterId = FbbchallengeModel.instance:getCurrCreepsMasterId()

	return FbbchallengeConfig.instance:getMonsterCfg(creepsMasterId)
end

function FBBMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function FBBMissionFmtView:_onClickPower()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员战斗力:？？？")
	else
		FBBMissionFmtView.super._onClickPower(self)
	end
end

function FBBMissionFmtView:_onClickSpeed()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员速度:？？？")
	else
		FBBMissionFmtView.super._onClickSpeed(self)
	end
end

function FBBMissionFmtView:_selectItem(index, isUp)
	if self._isHideZdl then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		FBBMissionFmtView.super._selectItem(self, index, isUp)
	end
end

return FBBMissionFmtView
