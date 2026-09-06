-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/controller/OrigindarkmoyanclgController.lua

module("logic.extensions.origindarkmoyanclg.controller.OrigindarkmoyanclgController", package.seeall)

local OrigindarkmoyanclgController = class("OrigindarkmoyanclgController", BaseController)

function OrigindarkmoyanclgController:ctor()
	return
end

function OrigindarkmoyanclgController:onInit()
	self:onReset()
end

function OrigindarkmoyanclgController:onReset()
	self._confirmCI = 0
end

function OrigindarkmoyanclgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginDarkMoYanClg)
end

function OrigindarkmoyanclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(314)
end

function OrigindarkmoyanclgController:onChallengeRes(msg)
	if not msg.win then
		return false
	end

	OrigindarkmoyanclgModel.instance:onChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:push(ViewName.OrigindarkmoyanclgresultView, msg.activityId, msg.stageId, msg.x, msg.y, msg.raceIds)

		return true
	end)
end

function OrigindarkmoyanclgController:onConfirmLockPetRes(msg)
	OrigindarkmoyanclgModel.instance:onConfirmLockPetRes(msg)

	self._confirmCI = 0

	if msg.saved and msg.changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._confirmCI = msg.changeSetId
	end
end

function OrigindarkmoyanclgController:checkConfirmCI()
	if self._confirmCI > 0 then
		MaterialController.instance:showChangeSetInTemp(self._confirmCI)

		self._confirmCI = 0
	end
end

OrigindarkmoyanclgController.instance = OrigindarkmoyanclgController.New()

return OrigindarkmoyanclgController
