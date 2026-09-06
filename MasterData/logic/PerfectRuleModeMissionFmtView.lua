-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/mission/PerfectRuleModeMissionFmtView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.mission.PerfectRuleModeMissionFmtView", package.seeall)

local PerfectRuleModeMissionFmtView = class("PerfectRuleModeMissionFmtView", MissionFmtView)

function PerfectRuleModeMissionFmtView:_getCreepCos()
	local monsterCfg = self:_getMonsterCo()

	return PerfectRuleModeConfig.instance:getMonsterCfgs(monsterCfg.creepsMasterId) or {}
end

function PerfectRuleModeMissionFmtView:_getMonsterCo()
	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])

	if self._challengeId > 0 then
		self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

		if self._curInfo then
			return PerfectRuleModeConfig.instance:getCreepCfgById(self._curInfo)
		end
	end

	return {}
end

function PerfectRuleModeMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()

	self._powerTxt.text = "？？？"
	self._speed.text = "？？？"
end

function PerfectRuleModeMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show(lang("全员战斗力:？？？"))
end

function PerfectRuleModeMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show(lang("全员速度:？？？"))
end

function PerfectRuleModeMissionFmtView:_selectItem(index, isUp)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return PerfectRuleModeMissionFmtView
