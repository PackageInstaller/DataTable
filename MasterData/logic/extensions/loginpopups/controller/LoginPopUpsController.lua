-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loginpopups/controller/LoginPopUpsController.lua

module("logic.extensions.loginpopups.controller.LoginPopUpsController", package.seeall)

local M = class("LoginPopUpsController", BaseController, IMainPopItem)

function M:ctor()
	self._jumpFuncMap = {}
	self._lastPopUpViewName = ""
end

function M:onInit()
	self:_setEvent(true)
	self:_registerJumpFunc()
end

function M:_registerJumpFunc()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.LOGIN_POP_UP_REG, self.handleLoginPopUpReg, self)
		GlobalDispatcher:addEventListener(EventType.LOGIN_POP_UP_VIEW_EXIT, self.handleLoginPopUpViewExit, self)
		GlobalDispatcher:addEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	else
		GlobalDispatcher:removeEventListener(EventType.LOGIN_POP_UP_REG, self.handleLoginPopUpReg, self)
		GlobalDispatcher:removeEventListener(EventType.LOGIN_POP_UP_VIEW_EXIT, self.handleLoginPopUpViewExit, self)
		GlobalDispatcher:removeEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	end
end

function M:getMainPopType()
	return MainPopEnum.Type.LoginPopUps
end

function M:onTriggerMainPop()
	self:triggerLoginPops()
end

function M:handleLoginPopUpReg(e, code, otherCode, append, jumpId, otherInfo)
	if append then
		LoginPopUpsModel.instance:AppendPopItem(code, otherCode, jumpId, otherInfo)
	else
		LoginPopUpsModel.instance:RemovePopItem(code, otherCode)
	end
end

function M:handleLoginPopUpViewExit(e)
	self:triggerLoginPops()
end

function M:_onDisconnectServer()
	LoginPopUpsModel.instance:onReset()
end

function M:hasPopUpData()
	return LoginPopUpsModel.instance:getCacheDataLstCount() > 0
end

function M:triggerLoginPops()
	settimer(0, function()
		local canPopUp = true
		local scene = SceneMgr.instance:getCurScene()

		if scene and scene:getSceneType() == SceneType.Room then
			-- block empty
		else
			canPopUp = false

			printWarn("登陆弹框不显示：非主场景")
		end

		if canPopUp and not ViewMgr.instance:isOpen(ViewName.MainUIView) then
			canPopUp = false

			printWarn("登陆弹框不显示：主界面未打开")
		end

		if canPopUp and GuideController.instance:isGuiding() then
			canPopUp = false

			printWarn("登陆弹框不显示：引导进行中")
		end

		if not canPopUp then
			MainPopController.instance:aboardPopShowing()

			return
		end

		local data = LoginPopUpsModel.instance:getShowData()

		if not data then
			MainPopController.instance:showNext()

			return
		end

		self:_showPop(data)
	end, self, false)
end

function M:_showPop(data)
	local code = data.code
	local otherCode = data.otherCode
	local jumpId = data.jumpId
	local popTyp = data.popTyp
	local otherInfo = data.otherInfo

	if popTyp < LoginPopEnum.PopType.NormalAct then
		local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpId)

		if jumpInfo then
			if jumpInfo.systemId ~= 0 and not SystemOpenFacade.instance:isOpen(jumpInfo.systemId, true) then
				self:triggerLoginPops()

				return
			end

			local info = {}

			info.jumpInfo = jumpInfo
			info.openByPopUp = true

			if otherInfo then
				for key, value in pairs(otherInfo) do
					info[key] = value
				end
			end

			local func = self._jumpFuncMap[jumpInfo.viewName]

			if func then
				func(self, jumpInfo, info)
			else
				if ViewMgr.instance:isOpen(jumpInfo.viewName) then
					ViewMgr.instance:close(jumpInfo.viewName, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
				end

				ViewMgr.instance:open(jumpInfo.viewName, info)

				self._lastPopUpViewName = jumpInfo.viewName
			end
		end
	elseif popTyp == LoginPopEnum.PopType.NormalAct and enableLog then
		print("comming soon...")
		self:triggerLoginPops()
	end

	LoginPopUpUtil.setDisplayState(code, otherCode)
end

function M:getLastPopUpViewName()
	return self._lastPopUpViewName or ""
end

M.instance = M.New()

return M
