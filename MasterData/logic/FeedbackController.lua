-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/controller/FeedbackController.lua

module("logic.extensions.feedback.controller.FeedbackController", package.seeall)

local FeedbackController = class("FeedbackController", BaseController)

function FeedbackController:onInit()
	FeedbackAgent.instance:addListener(FeedbackAgent.PM_NewFeedbackPushRes, self._onFeedbackPushed, self)

	self._firstRequested = false
	self._typeTable = {
		GameEnum.ChatItemType.ItemMy,
		GameEnum.ChatItemType.ItemMy,
		GameEnum.ChatItemType.ItemOther,
		GameEnum.ChatItemType.ItemMy
	}
end

function FeedbackController:onReset()
	self._firstRequested = false
end

function FeedbackController:_onFeedbackPushed(status, msg)
	if status == 0 then
		self:_onFeedbackRecieved(msg.feedback)
		self:localNotify("RefreshFeedBackData")
	end
end

function FeedbackController:loadFeedbackInfos()
	if self._firstRequested then
		self:localNotify("RefreshFeedBackData")

		return
	end

	FeedbackAgent.instance:sendPM_HandleLoadFeedbackInfosReq(FeedbackModel.instance:getCurFeedbackId(), function(msg)
		for i, v in ipairs(msg.feedbacks) do
			self:_onFeedbackRecieved(v)
		end

		if not self._firstRequested then
			FeedbackModel.instance:insertQuestion()

			self._firstRequested = true
		end

		self:localNotify("RefreshFeedBackData")
	end)
end

function FeedbackController:sendFeedback(_type, content)
	FeedbackAgent.instance:sendPM_HandleSendFeedbackReq(_type, content, function(msg)
		FeedbackModel.instance:addMsg(self._typeTable[_type], ServerTime.now(), content)
		FeedbackModel.instance:addCallBackMsg(_type)
		FeedbackModel.instance:saveMsg()
		self:localNotify("RefreshFeedBackData")
	end, self, self._onLoadInfoErr)
end

function FeedbackController:_onLoadInfoErr(msg, status)
	if status and status == -32001 then
		if not ("3_" .. ((msg or nil) and (msg.thirdPartyServiceResultCode or ""))) then
			local _errorPreTip = status
			local _errorTip = "网络异常，你的反馈未能发送成功，请稍后再试。"

			TipsFacade.instance:openTipWindowNoX("提示", _errorTip .. "(" .. _errorPreTip .. ")", nil, "知道了")
		end
	end
end

function FeedbackController:_onFeedbackRecieved(feedback)
	FeedbackModel.instance:setCurFeedbackId(feedback.id)
	FeedbackModel.instance:addMsg(self._typeTable[feedback.type], feedback.sendTime / 1000, feedback.content)
	FeedbackModel.instance:saveMsg()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FEEDBACK, true)
end

function FeedbackController:onClickQuestion(id)
	local cfg = FeedbackConfig.instance:getCfgById(id)
	local content = cfg.desc
	local reply = cfg.reply

	FeedbackAgent.instance:sendPM_HandleSendFeedbackReq(4, content, function(msg)
		FeedbackModel.instance:addMsg(self._typeTable[4], ServerTime.now(), content)
		FeedbackModel.instance:addMsg(self._typeTable[3], ServerTime.now(), reply)
		FeedbackModel.instance:saveMsg()
		self:localNotify("RefreshFeedBackData")
	end)
end

FeedbackController.instance = FeedbackController.New()

return FeedbackController
