-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/model/DrawandguessModel.lua

module("logic.extensions.drawandguess.view.DrawandguessModel", package.seeall)

local DrawandguessModel = class("DrawandguessModel", BaseModel)

function DrawandguessModel:ctor()
	return
end

function DrawandguessModel:onInit()
	self:onReset()
end

function DrawandguessModel:onReset()
	self._msgInfos = {}
	self._gameStartMsg = nil
	self._rankMsg = nil
	self._curActivityId = 0
	self._curUserId = nil
	self._selectQuestionStartMsg = nil
	self._questionIds = nil
	self._startTime = 0
	self._answerShowDataMap = {}
	self._curQuestionId = 0
end

function DrawandguessModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].gainedPrizeIds = self._msgInfos[msg.activityId].gainedPrizeIds or {}
end

function DrawandguessModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DrawandguessModel:setCurActivityId(activityId)
	self._curActivityId = activityId
end

function DrawandguessModel:getCurActivityId()
	return self._curActivityId
end

function DrawandguessModel:isGainPrize(activityId, prizeId)
	local info = self:getInfo(activityId)

	return table.indexof(info.gainedPrizeIds, prizeId)
end

function DrawandguessModel:onGainPrizeRes(msg)
	local info = self:getInfo(msg.activityId)

	table.insert(info.gainedPrizeIds, msg.prizeId)
end

function DrawandguessModel:onGameStartRes(msg)
	self._gameStartMsg = msg
	self._curQuestionId = 0

	self:_initPlayerDrawMap(msg.players, msg.curUserId)
	self:_setCurUserId(msg.curUserId)
	self:_setQuestionIds(msg.questionIds)
	self:_setPlayers(msg.players)
	self:_setStatrTime(msg.startTime)
end

function DrawandguessModel:_initPlayerDrawMap(players, curUserId)
	self._playerDrawMap = {}

	for i, v in ipairs(players) do
		self._playerDrawMap[checknumber(v.headInfo.userId)] = {
			hasDraw = false,
			player = v
		}
	end

	self:_recordPlayerDraw(curUserId)
end

function DrawandguessModel:_recordPlayerDraw(userId)
	userId = checknumber(userId)

	if self._playerDrawMap[userId] ~= nil then
		self._playerDrawMap[userId].hasDraw = true
	end
end

function DrawandguessModel:getPlayerDrawCount()
	local cnt = 0
	local total = 0

	for k, v in pairs(self._playerDrawMap) do
		total = total + 1

		if v.hasDraw then
			cnt = cnt + 1
		end
	end

	return cnt, total
end

function DrawandguessModel:getPlayerName(userId)
	userId = checknumber(userId)

	if self._playerDrawMap[userId] then
		return self._playerDrawMap[userId].player.headInfo.userName
	end

	return ""
end

function DrawandguessModel:getGameStartMsg()
	return self._gameStartMsg
end

function DrawandguessModel:_setQuestionIds(qIds)
	self._questionIds = qIds
end

function DrawandguessModel:getQuestionIds()
	return self._questionIds
end

function DrawandguessModel:_setPlayers(players)
	self._players = players
end

function DrawandguessModel:getPlayers()
	return self._players
end

function DrawandguessModel:_setStatrTime(startTime)
	local time = checknumber(startTime)

	self._startTime = time > 0 and math.floor(time / 1000) or 0
end

function DrawandguessModel:getStartTime()
	return self._startTime
end

function DrawandguessModel:onRankRes(msg)
	self._rankMsg = msg
end

function DrawandguessModel:getRankMsg()
	return self._rankMsg
end

function DrawandguessModel:isMeDraw()
	local userId = checknumber(RoleModel.instance:getUserId())

	return userId == checknumber(self._curUserId)
end

function DrawandguessModel:isDrawPlayer(userId)
	return checknumber(self._curUserId) == checknumber(userId)
end

function DrawandguessModel:getCurDrawUserId()
	return self._curUserId
end

function DrawandguessModel:onDrawStartRes(msg)
	self._drawStartMsg = msg
	self._curQuestionId = msg.questionId

	self:_setStatrTime(msg.startTime)

	self._gameStartMsg = nil
	self._selectQuestionStartMsg = nil
	self._answerShowDataMap = {}
end

function DrawandguessModel:onSelectQuestionStartRes(msg)
	self._curQuestionId = 0
	self._selectQuestionStartMsg = msg

	self:_setCurUserId(msg.curUserId)
	self:_setQuestionIds(msg.questionIds)
	self:_setStatrTime(msg.startTime)
	self:_recordPlayerDraw(msg.curUserId)
end

function DrawandguessModel:getSelectQuestionStartMsg()
	return self._selectQuestionStartMsg
end

function DrawandguessModel:_setCurUserId(curUserId)
	self._curUserId = curUserId
end

function DrawandguessModel:onAnswerResultRes(msg)
	local answer

	if msg.right then
		local sec = checknumber(msg.endTime) / 1000

		sec = math.floor(sec)

		self:_setEndTime(sec)

		answer = "****(正确)"
	else
		answer = string.format("%s(错误)", msg.answer)
	end

	local chatType = DrawandguessController.ChatType.Answer

	self:_insertAnswerShowData(msg.userId, chatType, answer)
end

function DrawandguessModel:_insertAnswerShowData(userId, chatType, answer, talkId, emojiId)
	userId = checknumber(userId)
	self._answerShowDataMap[userId] = self._answerShowDataMap[userId] or {
		talkId = 0,
		emojiId = 0,
		endTime = 0,
		answer = ""
	}
	self._answerShowDataMap[userId].endTime = ServerTime.now() + 2
	self._answerShowDataMap[userId].chatType = chatType

	if chatType == DrawandguessController.ChatType.Answer then
		self._answerShowDataMap[userId].answer = answer
	elseif chatType == DrawandguessController.ChatType.Talk then
		self._answerShowDataMap[userId].talkId = talkId
	elseif chatType == DrawandguessController.ChatType.Emoji then
		self._answerShowDataMap[userId].emojiId = emojiId
	end
end

function DrawandguessModel:getAnswerShowData(userId)
	userId = checknumber(userId)

	return self._answerShowDataMap[userId]
end

function DrawandguessModel:_setEndTime(endTime)
	self._endTime = checknumber(endTime)
end

function DrawandguessModel:getEndTime()
	return self._endTime
end

function DrawandguessModel:getCurQuestionId()
	return self._curQuestionId
end

DrawandguessModel.instance = DrawandguessModel.New()

return DrawandguessModel
