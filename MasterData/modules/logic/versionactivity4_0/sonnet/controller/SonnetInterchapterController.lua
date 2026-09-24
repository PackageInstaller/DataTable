-- chunkname: @modules/logic/versionactivity4_0/sonnet/controller/SonnetInterchapterController.lua

module("modules.logic.versionactivity4_0.sonnet.controller.SonnetInterchapterController", package.seeall)

local SonnetInterchapterController = class("SonnetInterchapterController", BaseController)

function SonnetInterchapterController:onInit()
	return
end

function SonnetInterchapterController:onInitFinish()
	return
end

function SonnetInterchapterController:addConstEvents()
	return
end

function SonnetInterchapterController:reInit()
	return
end

function SonnetInterchapterController:openTaskView()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.SonnetInterchapter
	}, function()
		ViewMgr.instance:openView(ViewName.SonnetInterchapterTaskView)
	end)
end

function SonnetInterchapterController:openSonnetInterchapterBookView()
	ViewMgr.instance:openView(ViewName.SonnetInterchapterBookView)
end

function SonnetInterchapterController:openSonnetInterchapterGetView(id, callback, callbackObj)
	if not id then
		logError("openSonnetInterchapterGetView id is nil")

		return
	end

	ViewMgr.instance:openView(ViewName.SonnetInterchapterGetView, {
		id = id,
		callback = callback,
		callbackObj = callbackObj
	})
end

function SonnetInterchapterController.hasOnceActionKey(type, id)
	local key = SonnetInterchapterController._getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function SonnetInterchapterController.setOnceActionKey(type, id)
	local key = SonnetInterchapterController._getKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function SonnetInterchapterController._getKey(type, id)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.V4a0SonnetOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id))
end

SonnetInterchapterController.instance = SonnetInterchapterController.New()

return SonnetInterchapterController
