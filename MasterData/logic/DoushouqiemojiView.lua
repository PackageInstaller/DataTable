-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiemojiView.lua

module("logic.extensions.doushouqi.view.DoushouqiemojiView", package.seeall)

local DoushouqiemojiView = class("DoushouqiemojiView", ChatEmojiView)

function DoushouqiemojiView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[3]

	local branch = GuideModel.instance:getGuideBranch(121)

	self._isGuiding = branch and not branch:isFinished()

	DoushouqiemojiView.super.onEnter(self)
end

function DoushouqiemojiView:_onClickEmoji(data)
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.DoushouqiPlayLocalEmoji, data.id)

	if not DoushouqiGameController.instance:isLearn() then
		BeastFightingChessAgent.instance:sendBeastFightingChessSendEmoticonReq(self._activityId, data.id)
	elseif self._isGuiding then
		DoushouqiGameController.instance:endTutorial()
	end
end

return DoushouqiemojiView
