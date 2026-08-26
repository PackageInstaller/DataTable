-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/model/ChatRoomModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.model.ChatRoomModel", package.seeall)

local ChatRoomModel = class("ChatRoomModel", BaseModel)

function ChatRoomModel:onInit()
	self:reInit()
end

function ChatRoomModel:reInit()
	self.activityId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom
	self.curRoomId = 0
	self.chatRoomUserMoMap = {}
	self.npcInfoMap = {}
	self.hideLoadingDesc = false
end

function ChatRoomModel:getCurActivityId()
	return self.activityId
end

function ChatRoomModel:setAct225Info(msg)
	self.activityId = msg.activityId

	self:setLastRainId(msg.lastRedEnvelopeRainId)
	self:setCurQuestionId(msg.questionId)
	ChatRoomFingerGameModel.instance:setCurDayFingerGameCount(msg.rockPaperScissorsDailyCount)
end

function ChatRoomModel:onEnterChatRoomReply(msg)
	self.activityId = msg.activityId
	self.chatRoomData = msg.chatRoom
	self.chatRoomUserMoMap = {}

	if self.chatRoomData then
		self:setRoomUid(self.chatRoomData.uid)

		for _, userMo in ipairs(self.chatRoomData.users) do
			self:updateChatRoomUserMo(userMo)
		end

		self:setLastRainId(self.chatRoomData.lastRedEnvelopeRainId)
		self:setCurQuestionId(self.chatRoomData.questionId)
		ChatRoomFingerGameModel.instance:setCurDayFingerGameCount(self.chatRoomData.rockPaperScissorsDailyCount)
	end
end

function ChatRoomModel:updateChatRoomUserMo(userMo)
	local chatRoomUserMo = self.chatRoomUserMoMap[userMo.userId]

	if not chatRoomUserMo then
		chatRoomUserMo = ChatRoomUserMo.New()
		self.chatRoomUserMoMap[userMo.userId] = chatRoomUserMo
	end

	chatRoomUserMo:updateUserInfo(userMo)
end

function ChatRoomModel:onChatRoomInfoPush(msg)
	self.activityId = msg.activityId

	self:setRoomUid(msg.uid)

	for _, userMo in ipairs(msg.updateUsers) do
		self:updateChatRoomUserMo(userMo)
	end

	for _, userMo in ipairs(msg.removeUsers) do
		self.chatRoomUserMoMap[userMo.userId] = nil
	end
end

function ChatRoomModel:getChatRoomUserMoMap()
	return self.chatRoomUserMoMap
end

function ChatRoomModel:getChatRoomUserMo(userId)
	return self.chatRoomUserMoMap[userId]
end

function ChatRoomModel:checkIsInRoom()
	return self.roomUid and tonumber(self.roomUid) > 0
end

function ChatRoomModel:setRoomUid(roomUid)
	self.roomUid = roomUid
end

function ChatRoomModel:getRoomUid()
	return self.roomUid
end

function ChatRoomModel:setLastRainId(rainId)
	self._lastRainId = rainId
end

function ChatRoomModel:isRainRewardGet(rainId)
	rainId = rainId or self:getCurRainId()

	if rainId > 0 then
		return self._lastRainId == rainId
	end

	return false
end

function ChatRoomModel:isRainRewardCouldGet(rainId)
	rainId = rainId or self:getCurRainId()

	if rainId <= 0 then
		return false
	end

	if not self._lastRainId then
		return false
	end

	if rainId <= self._lastRainId then
		return false
	end

	local rainCo = Activity225Config.instance:getRedEnvelopRainCo(rainId)
	local serverTime = ServerTime.now()
	local startTime = TimeUtil.stringToTimestamp(rainCo.startTime)

	return startTime < serverTime, startTime - serverTime
end

function ChatRoomModel:isInLuckyRain()
	local serverTime = ServerTime.now()
	local rainCos = Activity225Config.instance:getRedEnvelopRainCos()

	for i = #rainCos, 1, -1 do
		local startTime = TimeUtil.stringToTimestamp(rainCos[i].startTime)
		local endTime = TimeUtil.stringToTimestamp(rainCos[i].endTime)

		if serverTime <= endTime and startTime < serverTime then
			return true, i
		end
	end

	return false
end

function ChatRoomModel:getCurRainId()
	local serverTime = ServerTime.now()
	local rainCos = Activity225Config.instance:getRedEnvelopRainCos()

	if serverTime < TimeUtil.stringToTimestamp(rainCos[1].endTime) then
		return 1
	end

	for i = #rainCos, 2, -1 do
		if serverTime <= TimeUtil.stringToTimestamp(rainCos[i].endTime) and serverTime > TimeUtil.stringToTimestamp(rainCos[i - 1].endTime) then
			return i
		end
	end

	return 0
end

function ChatRoomModel:getNextRainLimitTime()
	local isEnd = self:isActLuckyRainEnd()

	if isEnd then
		return 0
	end

	local serverTime = ServerTime.now()
	local rainCos = Activity225Config.instance:getRedEnvelopRainCos()

	for i = 1, #rainCos do
		local startTime = TimeUtil.stringToTimestamp(rainCos[i].startTime)

		if serverTime <= startTime then
			return startTime - serverTime
		end
	end

	return 0
end

function ChatRoomModel:isActLuckyRainEnd()
	local serverTime = ServerTime.now()
	local rainCos = Activity225Config.instance:getRedEnvelopRainCos()
	local endTime = TimeUtil.stringToTimestamp(rainCos[#rainCos].endTime)

	return endTime <= serverTime
end

function ChatRoomModel:setCurQuestionId(questionId)
	self._curQuestionId = questionId
end

function ChatRoomModel:getCurQuestionId()
	return self._curQuestionId or 0
end

function ChatRoomModel:hasQuestion()
	return self._curQuestionId and self._curQuestionId > 0
end

function ChatRoomModel:buildNpcInfoData()
	for npcType = ChatRoomEnum.NpcType.QAndA, ChatRoomEnum.NpcType.EasterEgg do
		local infoData = self.npcInfoMap[npcType]

		if not infoData then
			infoData = {}

			if npcType == ChatRoomEnum.NpcType.QAndA then
				infoData.npcType = npcType

				local npcCoList = Activity225Config.instance:getChatRoomNpcCoListByType(npcType)

				infoData.npcConfig = npcCoList[1]

				local posStr = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.QAndANpcPos)

				infoData.posList = string.splitToNumber(posStr, "#")
			elseif npcType == ChatRoomEnum.NpcType.FingerGame then
				infoData.npcType = npcType

				local npcCoList = Activity225Config.instance:getChatRoomNpcCoListByType(npcType)

				infoData.npcConfig = npcCoList[1]

				local posStr = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.FingerGuessNpcPos)

				infoData.posList = string.splitToNumber(posStr, "#")
			end
		end

		if npcType == ChatRoomEnum.NpcType.EasterEgg then
			infoData = self:createEasterEggNpcData()
		end

		self.npcInfoMap[npcType] = infoData
	end
end

function ChatRoomModel:createEasterEggNpcData()
	local infoData = {}

	math.randomseed(os.time())

	local npcBornRate = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.EasterEggNpcBornRate)
	local canCreateEasterEggNpc = math.random() <= npcBornRate / 1000

	if not canCreateEasterEggNpc then
		return nil
	end

	infoData.npcType = ChatRoomEnum.NpcType.EasterEgg

	local posStr = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.EasterEggNpcPos)
	local allPosList = GameUtil.splitString2(posStr, true)
	local randomPosIndex = math.random(1, #allPosList)

	infoData.posList = allPosList[randomPosIndex]

	local npcCoList = Activity225Config.instance:getChatRoomNpcCoListByType(ChatRoomEnum.NpcType.EasterEgg)
	local totalBornWeight = 0

	for _, npcConfig in ipairs(npcCoList) do
		totalBornWeight = totalBornWeight + npcConfig.weight
	end

	local randomWeight = math.random(1, totalBornWeight)
	local curWeight = 0

	for _, npcConfig in ipairs(npcCoList) do
		curWeight = curWeight + npcConfig.weight

		if randomWeight <= curWeight then
			infoData.npcConfig = npcConfig

			break
		end
	end

	return infoData
end

function ChatRoomModel:getNpcInfoMap()
	return self.npcInfoMap
end

function ChatRoomModel:removeNpc(npcType)
	if self.npcInfoMap[npcType] then
		self.npcInfoMap[npcType] = nil
	end
end

function ChatRoomModel:checkCanShowNpc(npcType)
	if not self.chatRoomData then
		return false
	end

	if npcType == ChatRoomEnum.NpcType.QAndA then
		local questionId = self:getCurQuestionId()

		return questionId > 0
	elseif npcType == ChatRoomEnum.NpcType.FingerGame then
		local fingerGameCount = ChatRoomFingerGameModel.instance:getCurDayFingerGameCount()
		local fingerGameConfig = Activity225Config.instance:getFingerGameCo(self.activityId)

		return fingerGameCount < fingerGameConfig.times
	elseif npcType == ChatRoomEnum.NpcType.EasterEgg then
		return self.npcInfoMap[npcType]
	end
end

function ChatRoomModel:setHideLoadingDescState(state)
	self.hideLoadingDesc = state
end

function ChatRoomModel:getHideLoadingDescState()
	return self.hideLoadingDesc
end

ChatRoomModel.instance = ChatRoomModel.New()

return ChatRoomModel
