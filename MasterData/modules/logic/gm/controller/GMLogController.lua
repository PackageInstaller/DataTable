-- chunkname: @modules/logic/gm/controller/GMLogController.lua

module("modules.logic.gm.controller.GMLogController", package.seeall)

local GMLogController = class("GMLogController", BaseController)
local RobotUrl = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=eea1a1a3-ed85-49a2-9178-449d249f1329"
local RobotMsgMaxLength = 1600
local MsgCoolDown = 1
local MsgCounterMax = 20

function GMLogController:onInitFinish()
	if isDebugBuild then
		self._msgCounter = MsgCounterMax

		SLFramework.SLLogger.SetErrorCallback(self._onErrorMsg, self)
		TaskDispatcher.runRepeat(self._onCoolDown, self, MsgCoolDown)
		TaskDispatcher.runRepeat(self._onTick, self, 1)
		GMController.instance:registerCallback(GMEvent.GMLog_UpdateCount, self._updateCount, self)

		self._logQueue = {}
	end

	self._errorAlertGO = nil
end

function GMLogController:block()
	self:hideAlert()
	SLFramework.SLLogger.SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(self._onCoolDown, self)
	TaskDispatcher.cancelTask(self._onTick, self)
end

function GMLogController:cancelBlock()
	self:showAlert()
	self:_updateCount()
	SLFramework.SLLogger.SetErrorCallback(self._onErrorMsg, self)
	TaskDispatcher.runRepeat(self._onCoolDown, self, MsgCoolDown)
end

function GMLogController:_onCoolDown()
	if self._msgCounter < MsgCounterMax then
		self._msgCounter = self._msgCounter + 1
	end
end

function GMLogController:_onTick()
	if not self._logQueue or #self._logQueue == 0 then
		return
	end

	for _, one in ipairs(self._logQueue) do
		local logString = one.logString
		local stackTrace = one.stackTrace
		local logType = one.logType

		GMLogModel.instance:addMsg(logString, stackTrace, logType)

		if logType == 0 then
			if not self._errorAlertGO then
				local topGO = ViewMgr.instance:getUILayer(UILayerName.Top)

				self._errorAlertGO = GMController.instance:getGMNode("erroralert", topGO)

				if self._errorAlertGO then
					self._btnAlert = gohelper.findChildButtonWithAudio(self._errorAlertGO, "btnAlert")

					self._btnAlert:AddClickListener(self._onClickAlert, self)

					self._txtCount = gohelper.findChildText(self._errorAlertGO, "btnAlert/image/txtCount")
				end
			end

			if self._errorAlertGO then
				gohelper.setActive(self._errorAlertGO, true)
				self:_updateCount()
			end
		end

		GMController.instance:dispatchEvent(GMEvent.GMLog_Trigger, logString, stackTrace, logType)
	end

	tabletool.clear(self._logQueue)
end

function GMLogController:_onErrorMsg(logString, stackTrace, logType)
	self._msgCounter = self._msgCounter - 1

	if self._msgCounter < 0 then
		self._msgCounter = 0

		return
	end

	table.insert(self._logQueue, {
		logString = logString,
		stackTrace = stackTrace,
		logType = logType
	})
end

function GMLogController:showAlert()
	gohelper.setActive(self._errorAlertGO, true)
end

function GMLogController:hideAlert()
	gohelper.setActive(self._errorAlertGO, false)
end

function GMLogController:_updateCount()
	if self._txtCount then
		self._txtCount.text = tostring(GMLogModel.instance.errorModel:getCount())
	end
end

function GMLogController:_onClickAlert()
	if not ViewMgr.instance:isOpen(ViewName.GMErrorView) then
		ViewMgr.instance:openView(ViewName.GMErrorView)
	end
end

function GMLogController:sendRobotMsg(msg, stackTrace)
	local msgSource = string.split(msg, "stack traceback:")

	logWarn(msgSource[1])

	local deviceUser = UnityEngine.SystemInfo.deviceModel
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if playerInfo and not string.nilorempty(playerInfo.userId) and playerInfo.userId ~= 0 then
		deviceUser = string.format("**角色ID：**<font color=\"info\">%s</font>\n**角色名：**%s\n**设备：**%s", tostring(playerInfo.userId), tostring(playerInfo.name), tostring(deviceUser))
	end

	if not string.nilorempty(LoginModel.instance.serverName) then
		deviceUser = string.format("%s\n**服务器：**%s\n", deviceUser, LoginModel.instance.serverName)
	end

	msg = not string.nilorempty(msgSource[2]) and string.format("%s\n**报错：**<font color=\"warning\">%s</font>\n**stack traceback：**\n%s\n \n%s", tostring(deviceUser), tostring(msgSource[1]), tostring(msgSource[2]), tostring(stackTrace)) or string.format("%s\n**报错：**<font color=\"warning\">%s</font>\n**stack traceback：**\n \n%s", tostring(deviceUser), tostring(msgSource[1]), tostring(stackTrace))

	if string.len(msg) > RobotMsgMaxLength then
		msg = string.sub(msg, 1, RobotMsgMaxLength)
	end

	local msgJson = {
		msgtype = "markdown",
		markdown = {
			content = msg
		}
	}
	local msgJsonStr = cjson.encode(msgJson)

	SLFramework.SLWebRequest.Instance:PostJson(RobotUrl, msgJsonStr, self._onSendSucc, self)
end

function GMLogController:_onSendSucc(isSuccess, msg)
	if isSuccess then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. msg)
	end
end

GMLogController.instance = GMLogController.New()

return GMLogController
