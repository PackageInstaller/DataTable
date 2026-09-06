-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/controller/DrawandguessController.lua

module("logic.extensions.drawandguess.controller.DrawandguessController", package.seeall)

local DrawandguessController = class("DrawandguessController", BaseController)

DrawandguessController.TeamGroupId = 67
DrawandguessController.ChatType = {
	Answer = 1,
	Emoji = 2,
	Talk = 3
}

function DrawandguessController:ctor()
	return
end

function DrawandguessController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function DrawandguessController:onReset()
	return
end

function DrawandguessController:_onChatItemClick(tpId, chatMsgMo)
	if tpId == 92 then
		local teamId = chatMsgMo:getParam("teamId", true)
		local groupId = chatMsgMo:getParam("groupId", true)
		local teamCode = chatMsgMo:getParam("teamCode", false)

		if not chatMsgMo:getIsMe() then
			FormTeamController.instance:getJoinTeamByChat(teamId, groupId, teamCode)
		else
			FloatWordMgr.instance:show("房间已解散")
		end
	end
end

function DrawandguessController:_onJoinTeam(groupId)
	local teamInfo = FormTeamModel.instance:getCurTeamInfo()

	if teamInfo and groupId == DrawandguessController.TeamGroupId then
		UIStateManager.instance:push(ViewName.DrawandguesscurteamView, teamInfo.groupId)
	end
end

function DrawandguessController:onGameStartRes(msg)
	UIStateManager.instance:push(ViewName.DrawandguessgameView, msg.activityId)
	UIStateManager.instance:popByName(ViewName.DrawandguessmatchView)
	UIStateManager.instance:push(ViewName.DrawandguessmatchsuccesView, msg.activityId)
end

function DrawandguessController:onDrawStartRes(msg)
	UIStateManager.instance:popByName(ViewName.DrawandguessselectView)
	UIStateManager.instance:popByName(ViewName.DrawandguessmatchsuccesView)
end

function DrawandguessController:onGameEndRes(msg)
	if msg.state == 0 then
		UIStateManager.instance:popByName(ViewName.DrawandguessgameView)
		UIStateManager.instance:push(ViewName.DrawandguessresultView, msg)
	else
		FloatWordMgr.instance:show("结算出现异常 state:" .. msg.state)
	end
end

function DrawandguessController:_timeStringToSeconds(timeStr)
	local h, m, s = string.match(timeStr, "^(%d+):(%d+):(%d+)$")

	if not h then
		do return nil end

		s = checknumber(s)
		m = checknumber(m)
	end

	h = checknumber(h)

	return h * 3600 + m * 60 + s
end

function DrawandguessController:isInTimeRange(timeRangeStr)
	local nowTimestamp = ServerTime.now()
	local now = GameUtil.time2date(nowTimestamp)
	local nowSeconds = now.hour * 3600 + now.min * 60 + now.sec

	for period in timeRangeStr:gmatch("[^,]+") do
		local startStr, endStr = period:match("^([^#]+)#([^#]+)$")

		if startStr and endStr then
			local startSec = self:_timeStringToSeconds(startStr)
			local endSec = self:_timeStringToSeconds(endStr)

			if startSec and endSec and startSec <= endSec and startSec <= nowSeconds and nowSeconds <= endSec then
				return true
			end
		end
	end

	return false
end

function DrawandguessController:onChatRes(msg)
	if msg.talkId > 0 then
		local chatType = DrawandguessController.ChatType.Talk

		DrawandguessModel.instance:_insertAnswerShowData(msg.userId, chatType, "", msg.talkId, 0)
	elseif msg.emojiId > 0 then
		local chatType = DrawandguessController.ChatType.Emoji

		DrawandguessModel.instance:_insertAnswerShowData(msg.userId, chatType, "", 0, msg.emojiId)
	end
end

DrawandguessController.instance = DrawandguessController.New()

return DrawandguessController
