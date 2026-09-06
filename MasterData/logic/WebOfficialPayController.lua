-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/webofficialpay/controller/WebOfficialPayController.lua

module("logic.extensions.webofficialpay.controller.WebOfficialPayController", package.seeall)

local WebOfficialPayController = class("WebOfficialPayController", BaseController)

function WebOfficialPayController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.VIEWAUTOSHOW_DATA_INITED_OK, self._onAutoShowOk, self, NotifyPriority.Low)
end

function WebOfficialPayController:onReset()
	self._curRcdSceneType = -1
	self._msgList = {}
end

function WebOfficialPayController:_onSceneLoadedFinish(sceneType, sceneId)
	self._curRcdSceneType = sceneType

	self:tryShowNextAni()
end

function WebOfficialPayController:_onAutoShowOk()
	self:tryShowNextAni()
end

function WebOfficialPayController:pushOneMsg(msg)
	local items = MaterialController.instance:getItemsByChangeSetId(msg.changeSetId)

	if items and #items > 0 then
		local mo = items[1]

		if mo then
			local num = mo.num
			local toCount = MaterialModel.instance:getMaterialsNumber(mo.type, mo.id)
			local obj = {}

			obj.mo = mo
			obj.fromCount = toCount - num
			obj.toCount = toCount

			table.insert(self._msgList, obj)
		end
	end

	self:tryShowNextAni()
end

function WebOfficialPayController:tryShowNextAni()
	if self._curRcdSceneType == SceneType.City and ViewAutoShowController.instance.isInited and not ViewMgr.instance:isOpen(ViewName.WebofficialpaymainView) and #self._msgList > 0 then
		local p = table.remove(self._msgList, 1)

		UIStateManager.instance:push(ViewName.WebofficialpaymainView, p)
	end
end

WebOfficialPayController.instance = WebOfficialPayController.New()

return WebOfficialPayController
