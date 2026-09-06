-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCFmtRightView.lua

module("logic.extensions.timelimitedchallenge.view.TLCFmtRightView", package.seeall)

local TLCFmtRightView = class("TLCFmtRightView", FormationRightView)

function TLCFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil
	self._info = TLChallengeController.instance:getMissionParams()
	self._formCondition = self._info.monsterCfg.formCondition

	local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(self._formCondition)

	if cfg then
		self._jobLabelStr = cfg.label
	end
end

return TLCFmtRightView
