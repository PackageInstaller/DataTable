-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/perfectrulemode/mission/PerfectRuleModeFmtRightView.lua

module("logic.extensions.timelimitedchallenge.view.perfectrulemode.mission.PerfectRuleModeFmtRightView", package.seeall)

local PerfectRuleModeFmtRightView = class("PerfectRuleModeFmtRightView", FormationRightView)

function PerfectRuleModeFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local params = self:getOpenParam()

	self._challengeId = checkint(params[1])

	if self._challengeId > 0 then
		self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

		local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, self._curInfo.curRuleId)
		local formConditionId = checknumber(ruleCfg and ruleCfg.formConditionId)

		if formConditionId > 0 then
			local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(formConditionId)

			if cfg and not string.nilorempty(cfg.label) then
				self._jobLabelStr = cfg.label
			end

			return
		end

		local perfectWinId = checknumber(ruleCfg and ruleCfg.perfectWinId)

		if perfectWinId > 0 then
			local cfg = PerfectRuleModeConfig.instance:getPerfectWinCfgById(perfectWinId)

			if cfg and not string.nilorempty(cfg.label) then
				self._jobLabelStr = cfg.label
			end
		end
	end
end

return PerfectRuleModeFmtRightView
