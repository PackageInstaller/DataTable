-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/UserProtocalView.lua

module("logic.extensions.login.view.UserProtocalView", package.seeall)

local UserProtocalView = class("UserProtocalView", ViewComponent)

function UserProtocalView:buildUI()
	self._userProtocalEnsureBtn = self:getBtn("middleView/btnEnsure")
	self._userProtocalCloseBtn = self:getBtn("middleView/btnClose")
	self._userProtocalViewRect = self:getGo("View").transform
	self._title = self:getTxt("middleView/bg/Text")
end

function UserProtocalView:bindEvents()
	self._userProtocalEnsureBtn:AddClickListener(self._onClickEnsureProtocal, self)
	self._userProtocalCloseBtn:AddClickListener(self._onClickCloseProtocal, self)
end

function UserProtocalView:unbindEvents()
	self._userProtocalEnsureBtn:RemoveClickListener()
	self._userProtocalCloseBtn:RemoveClickListener()
end

function UserProtocalView:onEnter()
	self.addGEvent(self, GlobalNotify.SceneResolutionChange, self._onSceneResolutionChange, self)

	self._showType = self._viewPresentor._openParam[1] or 0
	self._showAll = self._viewPresentor._openParam[2]
	self._closeCallback = self._viewPresentor._openParam[3]
	self._closeCallbackObj = self._viewPresentor._openParam[4]

	self:_setUserProtocalContent(self._showType or 0)
end

function UserProtocalView:onExit()
	removetimer(self._resetSize, self)
end

function UserProtocalView:onExitFinished()
	self._closeCallback = nil
	self._closeCallbackObj = nil

	UnityWebBridge.closeWebView()
end

function UserProtocalView:_onCloseWebView()
	removetimer(self._yieldonCloseWebView, self)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Login)
	settimer(0.1, self._yieldonCloseWebView, self, false)
end

function UserProtocalView:_yieldonCloseWebView()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Login)

	if self._protoType == 0 and self._showAll then
		self:_setUserProtocalContent(1)
	else
		local callback = self._closeCallback
		local callbackObj = self._closeCallbackObj

		self:close()

		if callback then
			if callbackObj then
				self._closeCallback(callbackObj)
			else
				callback()
			end
		end
	end
end

function UserProtocalView:_setUserProtocalContent(type)
	UnityWebBridge.closeWebView()

	self._protoType = type

	local url

	if type == 0 then
		self._title.text = "天梯游戏许可及服务协议"
		url = "https://static.100bt.com/yducaccount/wap/html/protocol_game.html?t=" .. os.time()
	else
		self._title.text = "天梯游戏隐私政策"
		url = "https://static.100bt.com/yducaccount/wap/html/privacy_game.html?t=" .. os.time()
	end

	local rect = Framework.GeometryUtil.GetUnityPixelRect(self._userProtocalViewRect, GlobalModel.instance.uiCamera)

	rect.y = UnityEngine.Screen.height - rect.y - rect.height

	local percent = SceneResolution.Instance.directPercent
	local webViewRect = {
		x = math.floor(rect.x / percent),
		y = math.floor(rect.y / percent),
		width = math.floor(rect.width / percent),
		height = math.floor(rect.height / percent)
	}
	local x = webViewRect.x
	local y = webViewRect.y
	local width = webViewRect.width
	local height = webViewRect.height

	UnityWebBridge.openWebView(url, false, x, y, width, height)

	if type == 0 then
		Framework.LocalStorage.Instance:SetString(LoginController.strKeyHasShowUserProtocal, "Yes")
	else
		Framework.LocalStorage.Instance:SetString(LoginController.strKeyHasShowPrivateProtocal, "Yes")
	end
end

function UserProtocalView:_onClickEnsureProtocal()
	if not Framework.OSDef.isEditor then
		UnityWebBridge.closeWebView()
	end

	local evtName, keyName

	if self._protoType == 0 then
		evtName = "天梯游戏许可及服务协议"
		keyName = "stl_usr_proto"
	else
		evtName = "天梯游戏隐私政策"
		keyName = "stl_private_proto"
	end

	SDKManager.sensorsTrackLoadingOnce(evtName, keyName)
	self:_onCloseWebView()
end

function UserProtocalView:_onClickCloseProtocal()
	self:_onClickEnsureProtocal()
end

function UserProtocalView:_onSceneResolutionChange()
	goutil.setActive(self.mainGO, false)
	settimer(0.06, self._resetSize, self, false)
end

function UserProtocalView:_resetSize()
	local rect = Framework.GeometryUtil.GetUnityPixelRect(self._userProtocalViewRect, GlobalModel.instance.uiCamera)
	local _, cy = SceneResolution.Instance:GetCurrentResolution(0, 0)

	rect.y = cy - rect.y - rect.height

	local percent = SceneResolution.Instance.directPercent
	local webViewRect = {
		x = math.floor(rect.x / percent),
		y = math.floor(rect.y / percent),
		width = math.floor(rect.width / percent),
		height = math.floor(rect.height / percent)
	}
	local x = webViewRect.x
	local y = webViewRect.y
	local width = webViewRect.width
	local height = webViewRect.height

	UnityWebBridge.resetWebViewSize(x, y, width, height)
	goutil.setActive(self.mainGO, true)
end

function UserProtocalView:_calWebViewRect()
	return
end

return UserProtocalView
