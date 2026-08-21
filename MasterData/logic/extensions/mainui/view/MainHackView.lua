-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainHackView.lua

module("logic.extensions.mainui.view.MainHackView", package.seeall)

local M = class("MainHackView", ViewComponent)
local HackBtnPosKey = "hack_btn_pos"

function M:ctor()
	M.super.ctor(self)

	self._btnHackTool = false
end

function M:buildUI()
	self._btnHackTool = self:getBtn("main_hack_-1905511588")
	self._btnStopReStartServer = self:getBtn("main_hack_1965873986")

	goutil.setActive(self._btnHackTool.gameObject, enableDebug)

	self._goLogTips = self:getGoByPath("content_node/right/logTips")
	self._btnArrow = UIComponentType.ButtonAdapter(goutil.findChild(self._goLogTips, "btnArrow"))
	self._goArrowImg = goutil.findChild(self._goLogTips, "btnArrow/img")

	local logGO = goutil.findChild(self._goLogTips, "content")

	self._clickLog = Astral.UIClickTrigger.Get(logGO)
	self._txtLog = goutil.findChildTextComponent(logGO, "logTxt")
	self._txtLogWarn = goutil.findChildTextComponent(logGO, "warnTxt")
	self._txtLogError = goutil.findChildTextComponent(logGO, "errorTxt")
	self._transfBtns = self:getRectTransform("main_hack_1139370815")
	self.raycastProxy = RaycastProxy.Get(self:getGo("main_hack_-1905511588"))

	self.raycastProxy:SetClickListener(self._openHackToolView, self)
	self.raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self.raycastProxy:SetDragListener(self._onDrag, self)
	self.raycastProxy:SetEndDragListener(self._onEndDrag, self)
end

function M:destroyUI()
	return
end

function M:onEnter()
	self._isLogOpen = false

	self:setEvent(true)
	FrameUpdate:addListener(self)
	self:_refreshLogVisible()
	self:_refreshLogView()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SERVER_DELAY_SHUTDOWN, self._onServerDelayShutdown, self)
		GlobalDispatcher:addEventListener(EventType.SERVER_SHUTDOWN_CANCEL, self._onServerShutdownCancel, self)
		GlobalDispatcher:addEventListener(EventType.GM_LOG_TIPS_VISIBLE, self._refreshLogVisible, self)
		GlobalDispatcher:addEventListener(EventType.ENABLE_DEBUG_STATUS_CHANGE, self._onEnableDebugChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SERVER_DELAY_SHUTDOWN, self._onServerDelayShutdown, self)
		GlobalDispatcher:removeEventListener(EventType.SERVER_SHUTDOWN_CANCEL, self._onServerShutdownCancel, self)
		GlobalDispatcher:removeEventListener(EventType.GM_LOG_TIPS_VISIBLE, self._refreshLogVisible, self)
		GlobalDispatcher:removeEventListener(EventType.ENABLE_DEBUG_STATUS_CHANGE, self._onEnableDebugChange, self)
	end
end

function M:bindEvents()
	self._btnStopReStartServer:AddClickListener(self._onStopRestartServer, self)
	self._btnArrow:AddClickListener(self._onClickBtnArrow, self)
	self._clickLog:AddClickListener(self._onClickLog, self)
end

function M:unbindEvents()
	self._btnArrow:RemoveClickListener()
	self._clickLog:RemoveClickListener()
end

function M:onExit()
	self:setEvent(false)
	FrameUpdate:removeListener(self)
	removetimer(self._counterTimer, self)
end

function M:luaUpdate()
	self:_refreshLogNum()
end

function M:_onEnableDebugChange()
	goutil.setActive(self._btnHackTool.gameObject, enableDebug)
end

function M:_refreshLogNum()
	local numOfLogs = ReporterUtil.NumOfLogs()

	self._txtLog.text = numOfLogs > 999 and "999+" or numOfLogs

	local numOfLogsWarn = ReporterUtil.NumOfLogsWarn()

	self._txtLogWarn.text = numOfLogsWarn > 999 and "999+" or numOfLogsWarn

	local numOfLogsError = ReporterUtil.NumOfLogsError()

	self._txtLogError.text = numOfLogsError > 999 and "999+" or numOfLogsError
end

function M:_refreshLogView()
	local designWidth = 1520
	local designHeight = 750
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height
	local delta = width / height - designWidth / designHeight
	local offset = delta > 0 and (designHeight / height * width - designWidth) / 2 or 0

	offset = self._isLogOpen and offset - 120 or offset

	Astral.TransformUtil.SetAnchoredPos(self._goLogTips.transform, offset, 0)

	local scaleX = self._isLogOpen and -1 or 1

	Astral.TransformUtil.SetLocalScale(self._goArrowImg.transform, scaleX, 1, 1)
end

function M:_refreshLogVisible()
	goutil.setActive(self._goLogTips, MainUIModel.instance:getLogTipsVisible() and enableDebug)
end

function M:_refreshBtnPos()
	local posInfo = Astral.LocalStorage.Instance:GetString(HackBtnPosKey)

	if not string.nilorempty(posInfo) then
		local strs = string.split(posInfo, ",")
		local x = tonumber(strs[1]) or 466
		local y = tonumber(strs[2]) or -55

		Astral.TransformUtil.SetLocalPos(self._transfBtns, x, y, 0)
	end
end

function M:_onKeycodeChange()
	local inst = KeycodeListener.instance

	if inst:isOn(UnityEngine.KeyCode.LeftControl) and inst:isOn(UnityEngine.KeyCode.Q) then
		HackToolView:_quickCreateIssue()
	end
end

function M:_openHackToolView()
	ViewMgr.instance:open(ViewName.HackToolView)
end

function M:_onStopRestartServer()
	HackToolAgent.instance:sendCancelDelayShutdownRequest()
end

function M:_onServerDelayShutdown(sender, delay)
	self._shutdownDelay = delay

	self:showCountdownTime()
	goutil.setActive(self._btnStopReStartServer.gameObject, true)
	removetimer(self._counterTimer, self)
	settimer(1, self._counterTimer, self, true)
end

function M:_onServerShutdownCancel()
	self:onShutdownCancel()
end

function M:onShutdownCancel()
	self._shutdownDelay = 0

	removetimer(self._counterTimer, self)
	goutil.setActive(self._btnStopReStartServer.gameObject, false)
end

function M:_counterTimer()
	self._shutdownDelay = self._shutdownDelay - 1

	if self._shutdownDelay <= 0 then
		self:onShutdownCancel()
	end

	self:showCountdownTime()
end

function M:showCountdownTime()
	FloatWordMgr.instance:clear(true)
	FloatWordMgr.instance:show(string.format("服务器将在%d秒后重启", self._shutdownDelay))
end

function M:_onClickBtnArrow()
	self._isLogOpen = not self._isLogOpen

	self:_refreshLogView()
end

function M:_onClickLog()
	ReporterUtil.DoShow()
end

function M:_onBeginDrag(posX, posY, pointerId)
	self._beginDragX = posX
	self._beginDragY = posY
	self._goBeginDragX = self._transfBtns.localPosition.x
	self._goBeginDragY = self._transfBtns.localPosition.y
end

function M:_onDrag(posX, posY, pointerId)
	local deltaX = posX - self._beginDragX
	local deltaY = posY - self._beginDragY
	local x = self._goBeginDragX + deltaX
	local y = self._goBeginDragY + deltaY

	Astral.TransformUtil.SetLocalPos(self._transfBtns, x, y, 0)
end

function M:_onEndDrag(posX, posY, pointerId)
	local x, y = Astral.TransformUtil.GetAnchoredPos(self._transfBtns, 0, 0)
	local posInfo = string.format("%s,%s", x, y)
end

return M
