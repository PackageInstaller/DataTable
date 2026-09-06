-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceFormationLeftView.lua

module("logic.extensions.nineplace.view.NinePlaceFormationLeftView", package.seeall)

local NinePlaceFormationLeftView = class("NinePlaceFormationLeftView", FormationLeftView)

function NinePlaceFormationLeftView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._formInfoUpdate, self)
	NinePlaceFormationLeftView.super.onEnter(self)
end

function NinePlaceFormationLeftView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._formInfoUpdate, self)
	NinePlaceFormationLeftView.super.onExit(self)
end

function NinePlaceFormationLeftView:_filterFormationPosOnEnter()
	local params = self:getOpenParam()
	local stageId = params[1]
	local creepsMasterId = params[2]
	local cfg = NinePlaceConfig.instance:getMonsterCfg(stageId, creepsMasterId)

	if cfg then
		NinePlaceFormationLeftView.super._filterFormationPosOnEnter(self, cfg.formCondition)
	end
end

function NinePlaceFormationLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local params = self:getOpenParam()
	local stageId = params[1]
	local creepsMasterId = params[2]
	local cfg = NinePlaceConfig.instance:getMonsterCfg(stageId, creepsMasterId)

	if cfg then
		return (FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, cfg.formCondition, self:_getCurFormation(), isShowTip))
	end

	return true
end

function NinePlaceFormationLeftView:_formInfoUpdate(status)
	self:_filterFormationPosOnEnter()
end

return NinePlaceFormationLeftView
