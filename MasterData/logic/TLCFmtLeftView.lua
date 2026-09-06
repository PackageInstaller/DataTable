-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCFmtLeftView.lua

module("logic.extensions.timelimitedchallenge.view.TLCFmtLeftView", package.seeall)

local TLCFmtLeftView = class("TLCFmtLeftView", FormationLeftView)

function TLCFmtLeftView:onEnter()
	self._info = TLChallengeController.instance:getMissionParams()
	self._formCondition = self._info.monsterCfg.formCondition

	TLCFmtLeftView.super.onEnter(self)
end

function TLCFmtLeftView:_filterFormationPosOnEnter()
	TLCFmtLeftView.super._filterFormationPosOnEnter(self, self._formCondition)
end

function TLCFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:_getCurFormation(), isShowTip)
end

return TLCFmtLeftView
