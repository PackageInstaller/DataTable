-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMMailView.lua

module("logic.extensions.gm.view.GMMailView", package.seeall)

local GMMailView = class("GMMailView", ViewComponent)

function GMMailView:ctor()
	GMMailView.super.ctor(self)
end

function GMMailView:bindEvents()
	self._btn_close:AddClickListener(self._onClickClose, self)
	self._btn_send:AddClickListener(self._onClickSend, self)
end

function GMMailView:unbindEvents()
	self._btn_close:RemoveClickListener()
	self._btn_send:RemoveClickListener()
end

function GMMailView:buildUI()
	self._btn_close = self:getBtn("Btn_close")
	self._btn_send = self:getBtn("Btn_send")
	self._input_sender = self:getInput("Inp_sender")
	self._input_recieve = self:getInput("Inp_recive")
	self._input_template = self:getInput("Inp_template")
	self._input_title = self:getInput("Inp_tittle")
	self._input_content = self:getInput("Inp_content")
	self._input_param = self:getInput("Inp_param")
	self._input_attachment = self:getInput("Inp_attachment")
end

function GMMailView:destroyUI()
	return
end

function GMMailView:onEnter()
	return
end

function GMMailView:onEnterFinished()
	return
end

function GMMailView:onExit()
	return
end

function GMMailView:onExitFinished()
	return
end

function GMMailView:_onClickClose()
	UIStateManager.instance:pop()
end

function GMMailView:_onClickSend()
	local req = GMExtension_pb.PM_SendMailReq()
	local txt_sender = self._input_sender.input.text
	local txt_recieve = self._input_recieve.input.text
	local txt_template = self._input_template.input.text
	local txt_title = self._input_title.input.text
	local txt_content = self._input_content.input.text
	local txt_param = self._input_param.input.text
	local txt_attachment = self._input_attachment.input.text

	GMAgent.instance:sendPM_SendMailReq(txt_recieve, txt_sender, (txt_template ~= "" or nil) and checknumber(txt_template), txt_title, txt_content, txt_param, txt_attachment, handler, handlerObj, errHandler)
end

return GMMailView
