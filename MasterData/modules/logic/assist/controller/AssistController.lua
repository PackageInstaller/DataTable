-- chunkname: @modules/logic/assist/controller/AssistController.lua

module("modules.logic.assist.controller.AssistController", package.seeall)

local AssistController = class("AssistController", BaseController)

function AssistController:addConstEvents()
	self.addEventCb(self, LoginController.instance, LoginEvent.OnLoginEnterMainScene, self.onLoginFinish, self)
	self.addEventCb(self, OpenController.instance, OpenEvent.NewFuncUnlock, self.onNewFuncUnlock, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.checkToastTrigger, self)
end

function AssistController:onLoginFinish()
	PlayerRpc.instance:sendMainSceneLoadCompleteRequest()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		RoleBadgeRpc.instance:sendRoleBadgeGetInfoRequest()
	end
end

function AssistController:onNewFuncUnlock(ids)
	if tabletool.indexOf(ids, OpenEnum.UnlockFunc.Friend) then
		RoleBadgeRpc.instance:sendRoleBadgeGetInfoRequest()
	end
end

function AssistController:checkToastTrigger()
	if self:canPopUpToast() then
		local waitToastList = RoleBadgeModel.instance.waitToastList

		for _, param in ipairs(waitToastList) do
			local icon = ResUrl.getRoleBadgeSingleBg(param.icon)

			ToastController.instance:showToastWithIcon(ToastEnum.AssistRoleBadgeGet, icon, param.name, param.title)
		end

		RoleBadgeModel.instance:onToastFinished()
	end
end

function AssistController:canPopUpToast()
	return not ViewMgr.instance:isOpen(ViewName.StoryView) and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
end

AssistController.instance = AssistController.New()

return AssistController
