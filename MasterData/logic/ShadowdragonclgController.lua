-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/controller/ShadowdragonclgController.lua

module("logic.extensions.shadowdragonclg.controller.ShadowdragonclgController", package.seeall)

local ShadowdragonclgController = class("ShadowdragonclgController", BaseController)

ShadowdragonclgController.FloorType = {
	Now = 1,
	PassFuture = 2,
	None = 0
}
ShadowdragonclgController.PassFutureStageType = {
	Pass = 1,
	Future = 2
}
ShadowdragonclgController.Key_AutoSelectTab = "ShadowdragonclgController.Key_AutoSelectTab"

function ShadowdragonclgController:ctor()
	return
end

function ShadowdragonclgController:onInit()
	self:onReset()
end

function ShadowdragonclgController:onReset()
	self._currFloorType = ShadowdragonclgController.FloorType.None
	self._confirmChangeSetId = 0
end

function ShadowdragonclgController:getChallengeCfg()
	return TimeLimitedConfig.instance:getCfgById(258)
end

function ShadowdragonclgController:onNowStageFightNotifyRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		if not msg.isWin then
			return false
		end

		UIStateManager.instance:push(ViewName.ShadowdragonclglockView, msg)

		return true
	end, self)
end

function ShadowdragonclgController:setCurrFloorType(floorType)
	self._currFloorType = floorType
end

function ShadowdragonclgController:getCurrFloorType()
	return self._currFloorType
end

function ShadowdragonclgController:saveChangeSetToTemp(changeSetId)
	MaterialController.instance:saveChangeSetToTemp(changeSetId)

	self._confirmChangeSetId = changeSetId
end

function ShadowdragonclgController:getSaveChangeSetId()
	return self._confirmChangeSetId
end

ShadowdragonclgController.instance = ShadowdragonclgController.New()

return ShadowdragonclgController
