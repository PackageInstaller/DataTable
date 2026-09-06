-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/actions/TActionFactory.lua

module("logic.extensions.task.model.actions.TActionFactory", package.seeall)

TActionFactory = {}

function TActionFactory.createTAction(actionType, ...)
	if actionType == TaskConst.GOTONPC then
		return TActionGotoNpc.New(...)
	elseif actionType == TaskConst.GOTOSCENE then
		return TActionGotoScene.New(...)
	elseif actionType == TaskConst.GOTO then
		return TActionGoto.New(...)
	elseif actionType == TaskConst.GOTOSCENETRIGGER then
		return TActionGotoSceneTrigger.New(...)
	elseif actionType == TaskConst.GOTOMONSTER then
		return TActionGotoMonster.New(...)
	elseif actionType == TaskConst.GOTOSOURCEMON then
		return TActionGotoSourceMon.New(...)
	end
end

return TActionFactory
