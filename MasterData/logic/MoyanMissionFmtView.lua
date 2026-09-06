-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanMissionFmtView.lua

module("logic.extensions.mission.view.MoyanMissionFmtView", package.seeall)

local MoyanMissionFmtView = class("MoyanMissionFmtView", MissionFmtView)

function MoyanMissionFmtView:_getCreepCos()
	local temp = self:_getMonsterCo()
	local creepsMasterId = -1

	if temp and temp.creepsMasterId then
		creepsMasterId = temp.creepsMasterId
	end

	local creepCfg = {}
	local params = self._viewPresentor:getFirstParam()

	if creepsMasterId > 0 then
		local stageId = params.stageId
		local monList = MoyanConfig.instance:getCreepsCfg(creepsMasterId)

		for i, v in ipairs(monList) do
			local hpVal = MoyanController.instance:getEnemyPetHpById(params, stageId, v.creepsId)

			if hpVal > 0 then
				table.insert(creepCfg, v)
			end
		end
	end

	return creepCfg
end

function MoyanMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local type = params.type
		local stageId = params.stageId
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)
		local stagePlan = cfg.stagePlan

		return (MoyanConfig.instance:getMonsterCfg(stagePlan, stageId))
	end

	return {}
end

function MoyanMissionFmtView:onEnter()
	self._isHideZdl = false

	local params = self._viewPresentor:getFirstParam()

	if params then
		local type = params.type
		local challengeId = params.challengeId

		if challengeId == 20 and (type == MoyanModel.TYPE_2 or type == MoyanModel.TYPE_3) then
			self._isHideZdl = true
		end
	end

	MoyanMissionFmtView.super.onEnter(self)
end

function MoyanMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function MoyanMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	if self._isHideZdl then
		self._powerTxt.text = "？？？"
		self._speed.text = "？？？"
	end
end

function MoyanMissionFmtView:_onClickPower()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员战斗力:？？？")
	else
		MoyanMissionFmtView.super._onClickPower(self)
	end
end

function MoyanMissionFmtView:_onClickSpeed()
	if self._isHideZdl then
		FloatWordMgr.instance:show("全员速度:？？？")
	else
		MoyanMissionFmtView.super._onClickSpeed(self)
	end
end

function MoyanMissionFmtView:_selectItem(index, isUp)
	if self._isHideZdl then
		if self._infoSeats[index] then
			local param = clone(self._infoSeats[index])

			param.hideZdl = true

			CommonTipsMgr.instance:showPetTips(param)
		end
	else
		MoyanMissionFmtView.super._selectItem(self, index, isUp)
	end
end

return MoyanMissionFmtView
