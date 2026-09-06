-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/controller/NeweranuoyaController.lua

module("logic.extensions.neweranuoya.controller.NeweranuoyaController", package.seeall)

local NeweranuoyaController = class("NeweranuoyaController", BaseController)

NeweranuoyaController.ClgType = {
	Extreme = 2,
	Normal = 1
}
NeweranuoyaController.Floor = {
	Two = 2,
	One = 1
}

function NeweranuoyaController:ctor()
	return
end

function NeweranuoyaController:onInit()
	self:onReset()
end

function NeweranuoyaController:onReset()
	self._saveCI = 0
end

function NeweranuoyaController:onNotifyExtChallengeRes(msg)
	if msg.res.isWin then
		NeweranuoyaModel.instance:onNotifyExtChallengeRes(msg)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)

			if not msg.res.isWin then
				return false
			end

			UIStateManager.instance:push(ViewName.NeweranuoyaresultView, true, msg.activityId, msg.res.banRaceIdToIsDead, msg.res.jobIdToBuffNum)

			return true
		end, self)

		return true
	end
end

function NeweranuoyaController:onSaveRes(msg)
	self._saveCI = msg.changeSetId

	if self._saveCI > 0 then
		MaterialController.instance:saveChangeSetToTemp(self._saveCI)
	end
end

function NeweranuoyaController:openItemGetViewWithCI()
	if self._saveCI and self._saveCI > 0 then
		MaterialController.instance:showChangeSetInTemp(self._saveCI)

		self._saveCI = 0
	end
end

NeweranuoyaController.instance = NeweranuoyaController.New()

return NeweranuoyaController
