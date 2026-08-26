-- chunkname: @modules/logic/share/controller/ShareController.lua

module("modules.logic.share.controller.ShareController", package.seeall)

local ShareController = class("ShareController", BaseController)

function ShareController:onInit()
	return
end

function ShareController:reInit()
	return
end

function ShareController:onInitFinish()
	return
end

function ShareController:addConstEvents()
	SDKMgr.instance:setSocialShareCallBack(self._onSocialShare, self)
	SDKMgr.instance:setScreenShotCallBack(self._onScreenShot, self)
end

function ShareController:openShareEditorView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.ShareEditorView, param, isImmediate)
end

function ShareController:openShareTipView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.ShareTipView, param, isImmediate)
end

function ShareController:CaptureScreenshot()
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, self._onReadScene, self)
end

function ShareController:_onReadScene(texture2d)
	local pvPause = StoryModel.instance:isStoryPvPause()

	if not pvPause then
		self:openShareTipView(texture2d)
	end
end

function ShareController:_onSocialShare(code, msg)
	if code == 200 or code == -2 then
		ViewMgr.instance:closeView(ViewName.ShareEditorView)
	end

	local show = luaLang("datatrack_shareaction_success")

	if code == -1 then
		show = luaLang("datatrack_shareaction_failure")
	elseif code == -2 then
		show = luaLang("datatrack_shareaction_cancel")
	end

	StatController.instance:track(StatEnum.EventName.PlayerShare, {
		[StatEnum.EventProperties.ShareAction] = show
	})
end

function ShareController:_onScreenShot(success, msg)
	if not success then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ShareEditorView) then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if SettingsModel.instance:getScreenshotSwitch() then
		self:CaptureScreenshot()
	end
end

ShareController.instance = ShareController.New()

return ShareController
