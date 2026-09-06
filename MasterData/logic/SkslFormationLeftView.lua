-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/formation/SkslFormationLeftView.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.formation.SkslFormationLeftView", package.seeall)

local SkslFormationLeftView = class("SkslFormationLeftView", FormationLeftView)

function SkslFormationLeftView:_filterFormationPosOnEnter()
	local params = self:getOpenParam()
	local creepsMasterId = params[2]

	SkslFormationLeftView.super._filterFormationPosOnEnter(self, (creepsMasterId or nil) and ShikongshenglongConfig.instance:getTeamCfg(creepsMasterId).formCondition)
end

function SkslFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local params = self:getOpenParam()
	local creepsMasterId = params[2]

	if creepsMasterId then
		local form = ShikongshenglongConfig.instance:getTeamCfg(creepsMasterId).formCondition

		return (FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, form, self:_getCurFormation(), isShowTip))
	end

	return true
end

return SkslFormationLeftView
