-- chunkname: @modules/logic/messagebox/controller/MessageBoxController.lua

module("modules.logic.messagebox.controller.MessageBoxController", package.seeall)

local MessageBoxController = class("MessageBoxController", BaseController)

function MessageBoxController:onInit()
	self._showQueue = {}
	self.enableClickAudio = true
end

function MessageBoxController:onInitFinish()
	return
end

function MessageBoxController:addConstEvents()
	return
end

function MessageBoxController:reInit()
	self._showQueue = {}
end

function MessageBoxController:setEnableClickAudio(enable)
	self.enableClickAudio = enable

	local viewContainer = ViewMgr.instance:getContainer(ViewName.MessageBoxView)

	if viewContainer and not gohelper.isNil(viewContainer.viewGO) then
		local btnGO1 = gohelper.findChild(viewContainer.viewGO, "#btn_yes")

		if not gohelper.isNil(btnGO1) then
			gohelper.addUIClickAudio(btnGO1, (enable or nil) and (AudioEnum.UI.UI_Common_Click or 0))
		end

		local btnGO2 = gohelper.findChild(viewContainer.viewGO, "#btn_no")

		if not gohelper.isNil(btnGO2) then
			gohelper.addUIClickAudio(btnGO2, (enable or nil) and (AudioEnum.UI.UI_Common_Click or 0))
		end
	end
end

function MessageBoxController:showSystemMsgBox(messageBoxId, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	self._showQueue = {}
	self._isShowSystemMsgBox = true

	local extra = {
		...
	}
	local param = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		extra = extra
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, param)
end

function MessageBoxController:showSystemMsgBoxByStr(msg, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	self._showQueue = {}
	self._isShowSystemMsgBox = true

	local extra = {
		...
	}
	local param = {
		msg = msg,
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		extra = extra
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, param)
end

function MessageBoxController:showSystemMsgBoxAndSetBtn(messageBoxId, msgBoxType, yesStr, yesStrEn, noStr, noStrEn, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	self._showQueue = {}
	self._isShowSystemMsgBox = true

	local extra = {
		...
	}
	local param = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		yesStr = yesStr,
		noStr = noStr,
		yesStrEn = yesStrEn,
		noStrEn = noStrEn,
		extra = extra
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, param)
end

function MessageBoxController:showMsgBoxAndSetBtn(messageBoxId, msgBoxType, yesStr, yesStrEn, noStr, noStrEn, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		self._isShowSystemMsgBox = false
	end

	if not self._isShowSystemMsgBox then
		local extra = {
			...
		}

		self:_internalShowMsgBox({
			messageBoxId = messageBoxId,
			msg = MessageBoxConfig.instance:getMessage(messageBoxId),
			msgBoxType = msgBoxType,
			yesCallback = yesCallback,
			noCallback = noCallback,
			openCallback = openCallback,
			yesCallbackObj = yesCallbackObj,
			noCallbackObj = noCallbackObj,
			openCallbackObj = openCallbackObj,
			yesStr = yesStr,
			noStr = noStr,
			yesStrEn = yesStrEn,
			noStrEn = noStrEn,
			extra = extra
		})
	end
end

function MessageBoxController:showMsgBox(messageBoxId, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		self._isShowSystemMsgBox = false
	end

	if not self._isShowSystemMsgBox then
		local extra = {
			...
		}

		self:_internalShowMsgBox({
			messageBoxId = messageBoxId,
			msg = MessageBoxConfig.instance:getMessage(messageBoxId),
			title = MessageBoxConfig.instance:getMessageTitle(messageBoxId),
			msgBoxType = msgBoxType,
			yesCallback = yesCallback,
			noCallback = noCallback,
			openCallback = openCallback,
			yesCallbackObj = yesCallbackObj,
			noCallbackObj = noCallbackObj,
			openCallbackObj = openCallbackObj,
			extra = extra
		})
	end
end

function MessageBoxController:showMsgBoxByStr(msg, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj)
	self:_internalShowMsgBox({
		msg = msg,
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj
	})
end

function MessageBoxController:_internalShowMsgBox(param)
	table.insert(self._showQueue, param)

	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	self:_showNextMsgBox()
end

function MessageBoxController:_showNextMsgBox()
	self._isShowSystemMsgBox = nil

	if #self._showQueue > 0 then
		local param = table.remove(self._showQueue, 1)

		ViewMgr.instance:openView(ViewName.MessageBoxView, param)

		return true
	end

	return false
end

function MessageBoxController:showOptionMsgBoxAndSetBtn(messageBoxId, msgBoxType, optionType, yesStr, yesStrEn, noStr, noStrEn, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	local canShowView = self:canShowMessageOptionBoxView(messageBoxId, optionType)

	if not canShowView then
		if yesCallback then
			yesCallback(yesCallbackObj)
		end

		return
	end

	self._isShowSystemMsgBox = false

	local extra = {
		...
	}
	local param = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		title = MessageBoxConfig.instance:getMessageTitle(messageBoxId),
		messageBoxId = messageBoxId,
		msgBoxType = msgBoxType,
		optionType = optionType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		yesStr = yesStr,
		noStr = noStr,
		yesStrEn = yesStrEn,
		noStrEn = noStrEn,
		extra = extra
	}

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, param)
end

function MessageBoxController:showOptionMsgBox(messageBoxId, msgBoxType, optionType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	self._isShowSystemMsgBox = false

	local extra = {
		...
	}
	local param = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		title = MessageBoxConfig.instance:getMessageTitle(messageBoxId),
		messageBoxId = messageBoxId,
		msgBoxType = msgBoxType,
		optionType = optionType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		extra = extra
	}

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, param)
end

function MessageBoxController:showOptionAndParamsMsgBox(messageBoxId, msgBoxType, optionType, optionExParam, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	self._isShowSystemMsgBox = false

	local extra = {
		...
	}
	local param = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		title = MessageBoxConfig.instance:getMessageTitle(messageBoxId),
		messageBoxId = messageBoxId,
		msgBoxType = msgBoxType,
		optionType = optionType,
		optionExParam = optionExParam,
		yesCallback = yesCallback,
		noCallback = noCallback,
		openCallback = openCallback,
		yesCallbackObj = yesCallbackObj,
		noCallbackObj = noCallbackObj,
		openCallbackObj = openCallbackObj,
		extra = extra
	}

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, param)
end

function MessageBoxController:canShowMessageOptionBoxView(messageBoxId, optionType, optionExParam)
	local key = self:getOptionLocalKey(messageBoxId, optionType, optionExParam)
	local canShowView = true

	if optionType == MsgBoxEnum.optionType.Daily then
		canShowView = TimeUtil.getDayFirstLoginRed(key)
	elseif optionType == MsgBoxEnum.optionType.NotShow then
		local saveStr = PlayerPrefsHelper.getString(key, "")

		canShowView = string.nilorempty(saveStr)
	end

	return canShowView
end

function MessageBoxController:getOptionLocalKey(messageBoxId, optionType, optionExParam)
	if optionExParam == nil then
		return string.format("MessageOptionBoxView#%s#%s#%s", messageBoxId, optionType, tostring(PlayerModel.instance:getPlayinfo().userId))
	else
		return string.format("MessageOptionBoxView#%s#%s#%s#%s", messageBoxId, optionType, optionExParam, tostring(PlayerModel.instance:getPlayinfo().userId))
	end
end

function MessageBoxController:clearOption(messageBoxId, optionType, optionExParam)
	local key = self:getOptionLocalKey(messageBoxId, optionType, optionExParam)

	PlayerPrefsHelper.deleteKey(key)
end

function MessageBoxController:showMsgBoxWithCurrency(messageBoxId, msgBoxType, currencyParam, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		self._isShowSystemMsgBox = false
	end

	if not self._isShowSystemMsgBox then
		local extra = {
			...
		}
		local config = MessageBoxConfig.instance:getMessageBoxCO(messageBoxId)

		self:_internalShowMsgBox({
			messageBoxId = messageBoxId,
			msg = config.content,
			title = config.title,
			currencyParam = currencyParam,
			msgBoxType = msgBoxType,
			yesCallback = yesCallback,
			noCallback = noCallback,
			openCallback = openCallback,
			yesCallbackObj = yesCallbackObj,
			noCallbackObj = noCallbackObj,
			openCallbackObj = openCallbackObj,
			extra = extra
		})
	end
end

MessageBoxController.instance = MessageBoxController.New()

return MessageBoxController
