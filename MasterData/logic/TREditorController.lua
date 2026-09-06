-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/TREditorController.lua

module("logic.extensions.treasureraider.controller.TREditorController", package.seeall)

local TREditorController = class("TREditorController", BaseController)

TREditorController.EMode_None = -1
TREditorController.EMode_DefaultMode = 1
TREditorController.EMode_EditorMode = 2

function TREditorController:ctor()
	return
end

function TREditorController:onInit()
	self:onReset()
end

function TREditorController:onReset()
	self._stateMachine = FiniteStateMachine.New()

	self._stateMachine:registerState(TRMode_None.New(TREditorController.EMode_None))
	self._stateMachine:registerState(TRMode_None.New(TREditorController.EMode_DefaultMode))
	self._stateMachine:registerState(TRMode_Edit.New())
end

function TREditorController:enterEdit()
	self._stateMachine:enterState(TREditorController.EMode_EditorMode)
end

function TREditorController:exitEdit()
	self._stateMachine:enterState(TREditorController.EMode_DefaultMode)
end

function TREditorController:isInState(stateId)
	return self._stateMachine:isActive(stateId)
end

function TREditorController:getState(stateId)
	return self._stateMachine:getState(stateId)
end

TREditorController.instance = TREditorController.New()

return TREditorController
