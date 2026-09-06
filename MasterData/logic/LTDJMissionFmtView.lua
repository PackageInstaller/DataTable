-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/formation/LTDJMissionFmtView.lua

module("logic.extensions.luotiandajiao.view.formation.LTDJMissionFmtView", package.seeall)

local LTDJMissionFmtView = class("LTDJMissionFmtView", MissionFmtView)

function LTDJMissionFmtView:_getTeamFormationCfg()
	local params = self:getOpenParam()

	if params[1] and params[2] and params[3] then
		local planId = params[1]
		local groupId = params[2]
		local stage = params[3]
		local cfgChallenge = LTDaJiaoConfig.instance:getGroupChallengeCfg(planId, groupId, stage)

		if cfgChallenge then
			return (LTDaJiaoConfig.instance:getCreepCfgs(cfgChallenge.creepsMasterId))
		end
	end

	return nil
end

function LTDJMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()

	if params[1] and params[2] and params[3] then
		local planId = params[1]
		local groupId = params[2]
		local stage = params[3]

		return (LTDaJiaoConfig.instance:getGroupChallengeCfg(planId, groupId, stage))
	else
		return nil
	end
end

function LTDJMissionFmtView:_getCreepCos()
	return (self:_getTeamFormationCfg())
end

function LTDJMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "???"
	self._speed.text = "???"
end

function LTDJMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力:？？？")
end

function LTDJMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度:？？？")
end

function LTDJMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return LTDJMissionFmtView
