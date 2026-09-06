-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/model/FeedbackModel.lua

module("logic.extensions.feedback.model.FeedbackModel", package.seeall)

local FeedbackModel = class("FeedbackModel", BaseModel)
local TimestampOffset = 300

function FeedbackModel:ctor()
	FeedbackModel.super.ctor(self)
	self:onReset()
end

function FeedbackModel:onReset()
	self._msgs = {}
	self._curFeedbackId = -1
end

function FeedbackModel:getCurFeedbackId()
	return self._curFeedbackId
end

function FeedbackModel:setCurFeedbackId(id)
	self._curFeedbackId = id
end

function FeedbackModel:getMsgs()
	local timestamp

	table.sort(self._msgs, function(x, y)
		return x.sendTime < y.sendTime
	end)

	local t = {}

	for _, msg in ipairs(self._msgs) do
		if not timestamp or msg.sendTime - timestamp >= TimestampOffset then
			local timeMsg = {}

			timeMsg.msgType = GameEnum.ChatItemType.ItemTime
			timeMsg.content = ""
			timeMsg.sendTime = msg.sendTime
			timestamp = msg.sendTime

			table.insert(t, timeMsg)
		end

		table.insert(t, msg)
	end

	return t
end

function FeedbackModel:addMsg(msgType, sendTime, content)
	local msg = {}

	msg.msgType = msgType
	msg.content = content
	msg.sendTime = sendTime

	table.insert(self._msgs, msg)
end

function FeedbackModel:saveMsg()
	return
end

function FeedbackModel:getAllMsg(cb)
	return
end

function FeedbackModel:insertQuestion()
	self:addMsg(GameEnum.ChatItemType.ItemOther, ServerTime.now(), (lang("亲爱的小奥奇，欢迎您对我们的世界提出宝贵的建议和意见。\n建议您不要将反馈内容分多次发送，并尽量不要发送无意义的聊天内容，\n以方便对反馈意见的统计和整理。")))
end

function FeedbackModel:addCallBackMsg(type)
	local firstContent = ""

	if type == 1 then
		local isOfficial = SDKManager.isOfficial()

		firstContent = isOfficial and lang("亲爱的小奥奇，感谢您对我们的世界提出宝贵的建议和意见。\n如果您在游戏内遇到了充值未到账、闪退、卡顿等游戏bug相关的问题，\n请您将截图或录屏发送到客服QQ公众号800165123，客服会第一时间为您解答的哦。") or lang("亲爱的小奥奇，感谢您对我们的世界提出宝贵的建议和意见。\n如果您在游戏内遇到了充值未到账、闪退、卡顿等游戏bug相关的问题，\n请您将截图或录屏发送给您所在渠道的客服，客服联系方式：\n【登录界面-悬浮窗-联系我们】、【应用商店-联系我们】，\n渠道客服会进一步为您解答的哦。")
	else
		firstContent = lang("亲爱的小奥奇，您的意见和建议我们已经收到，\n客服会定期汇总并转达至项目组，策划人员会进行综合评估并优化，\n希望您游戏愉快~\n\n如需反馈游戏bug，请选择[BUG反馈]类型，按指引联系客服哦。")
	end

	self:addMsg(GameEnum.ChatItemType.ItemOther, ServerTime.now() + 1, firstContent)
end

FeedbackModel.instance = FeedbackModel.New()

return FeedbackModel
