-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/model/GoddessModel.lua

module("logic.extensions.goddess.model.GoddessModel", package.seeall)

local GoddessModel = class("GoddessModel", BaseModel)

function GoddessModel:onInit()
	self._activityType = 121
	self._activityId = 0

	self:onReset()
end

function GoddessModel:onReset()
	self._infoList = {}
	self._actId = 0
	self._touchTimes = 0
	self._dailyFlowerFeelings = 0
	self._curGoddessInfo = nil
	self._CIList = nil
	self._dailyGameTime = 0
	self._reliveTimes = 0
	self._clientKey = 0
	self._encryptedKey = 0
	self._dailyChatTime = 0
	self._newMsgList = {}
end

function GoddessModel:getActIdByCfg()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GODDESS)

	return actCfg and actCfg.activityId
end

function GoddessModel:setActId(actId)
	self._actId = actId
end

function GoddessModel:getActId()
	return self._actId
end

function GoddessModel:getLeftTouchTimes()
	return GoddessConfig.instance:getTouchLimit() - self._touchTimes
end

function GoddessModel:getDailyFeeling()
	return self._dailyFlowerFeelings
end

function GoddessModel:_initGoddessInfo(info)
	local goddessInfo = {}

	goddessInfo.raceId = checkint(info.raceId)
	goddessInfo.curFeeling = checkint(info.feelings)
	goddessInfo.gainPrizeIds = info.gainPrizeIds or {}
	goddessInfo.chatTextId = info.chatTextId
	goddessInfo.raceCfg = GoddessConfig.instance:getGoddessCfg(self._actId, goddessInfo.raceId)
	goddessInfo.goodfeelingLvCfgs = GoddessConfig.instance:getGoodFeelingLvCfgs(self._actId, goddessInfo.raceId)
	goddessInfo.goodfeelingPrizeCfgs = GoddessConfig.instance:getGoodFeelingPrizeCfgsByIds(self._actId, goddessInfo.raceId)
	goddessInfo.curLv, goddessInfo.curShowFeeling, goddessInfo.isLvMax = self:_dealFeeling(goddessInfo.curFeeling, goddessInfo.goodfeelingLvCfgs)

	return goddessInfo
end

function GoddessModel:_dealFeeling(feeling, feelingCfgs)
	local curLv = 1
	local curShowFeeling = 0
	local isLvMax = false
	local temFeeling = feeling

	if temFeeling >= feelingCfgs[#feelingCfgs].feeling then
		isLvMax = true
		curLv = #feelingCfgs
	else
		for i = 1, #feelingCfgs do
			if temFeeling == feelingCfgs[i].feeling then
				curLv = i

				break
			elseif temFeeling < feelingCfgs[i].feeling then
				curLv = i - 1
				curShowFeeling = feeling - feelingCfgs[i - 1].feeling

				break
			end
		end
	end

	return curLv, curShowFeeling, isLvMax
end

function GoddessModel:getCurGoddessInfo()
	return self._curGoddessInfo
end

function GoddessModel:switchGoddess(raceId)
	if self._infoList[raceId] then
		self._curGoddessInfo = self._infoList[raceId]
	end
end

function GoddessModel:getGoddessInfo(raceId)
	return self._infoList[raceId]
end

function GoddessModel:showCI()
	return
end

function GoddessModel:updateGetInfo(msg)
	for k, v in ipairs(msg.goddessList) do
		local info = self:_initGoddessInfo(v)

		self._infoList[info.raceId] = info
		self._curGoddessInfo = self._curGoddessInfo or self._infoList[info.raceId]
	end

	self._touchTimes = checkint(msg.dailyTouchTime)
	self._dailyFlowerFeelings = checkint(msg.dailyFlowerfeelings)
	self._dailyGameTime = msg.dailyGameTime
	self._dailyChatTime = msg.dailyChatTime
end

function GoddessModel:updateTouch(msg)
	self._changeFeeling = 0
	self._isUp = false

	local infoNow = self:_initGoddessInfo(msg.goddessInfo)
	local infoBefore = self:getGoddessInfo(infoNow.raceId)

	if infoBefore then
		self._infoList[infoNow.raceId] = infoNow

		if self._curGoddessInfo == infoBefore then
			self._curGoddessInfo = infoNow
		end

		self._changeFeeling = infoNow.curFeeling - infoBefore.curFeeling
		self._isUp = infoNow.curLv > infoBefore.curLv
	end

	self._touchTimes = checkint(msg.dailyTouchTime)
end

function GoddessModel:getIsLvPrizeRedPointShow()
	if self._curGoddessInfo then
		local curInfoLv = self._curGoddessInfo.curLv
		local cfgs = self._curGoddessInfo.goodfeelingPrizeCfgs

		if not self._curGoddessInfo.gainPrizeIds then
			for k, v in ipairs(cfgs) do
				if curInfoLv >= v.level and not table.keyof(self._curGoddessInfo.gainPrizeIds, v.id) then
					return true
				end
			end
		end
	end

	return false
end

function GoddessModel:resetGoodFeelingChangeValue()
	self._changeFeeling = 0
	self._isUp = false
end

function GoddessModel:getGoodFeelingChangeValue()
	return checkint(self._changeFeeling), self._isUp
end

function GoddessModel:updateSendFlower(msg)
	self._changeFeeling = 0
	self._isUp = false

	local infoNow = self:_initGoddessInfo(msg.goddessInfo)
	local infoBefore = self:getGoddessInfo(infoNow.raceId)

	if infoBefore then
		if self._curGoddessInfo == infoBefore then
			self._curGoddessInfo = infoNow
		end

		self._infoList[infoNow.raceId] = infoNow
		self._changeFeeling = infoNow.curFeeling - infoBefore.curFeeling
		self._isUp = infoNow.curLv > infoBefore.curLv
	end

	self._dailyFlowerFeelings = checkint(msg.dailyFlowerfeelings)
end

function GoddessModel:updateGainGoodFeelingPrize(msg)
	local infoNow = self:_initGoddessInfo(msg.goddessInfo)

	self._infoList[infoNow.raceId] = infoNow
	self._curGoddessInfo = infoNow
end

function GoddessModel:getCurrActId()
	return self._actId
end

function GoddessModel:getGameLeftTime()
	local totalTime = GoddessConfig.instance:getGameTotalTime()

	return totalTime - self._dailyGameTime
end

function GoddessModel:updateReliveTimes(reliveTimes)
	self._reliveTimes = reliveTimes
end

function GoddessModel:updateEndGameData(msg)
	self._dailyGameTime = msg.dailyGameTime

	local info = self:_initGoddessInfo(msg.goddessInfo)

	self._infoList[info.raceId] = info

	self:switchGoddess(msg.goddessInfo.raceId)
end

function GoddessModel:updateChatData(msg)
	self._dailyChatTime = msg.dailyChatTime

	local oldInfo = self:getGoddessInfo(msg.goddessInfo.raceId)
	local info = self:_initGoddessInfo(msg.goddessInfo)

	self._infoList[info.raceId] = info

	self:switchGoddess(msg.goddessInfo.raceId)

	for i, v in ipairs(info.chatTextId) do
		if not oldInfo.chatTextId[i] then
			table.insert(self._newMsgList, v)
		end
	end

	self:startPlaySlowMsg()
end

function GoddessModel:getLeftReliveTimes()
	local totalTime = GoddessConfig.instance:getGameReliveTotalTime()

	return totalTime - self._reliveTimes
end

function GoddessModel:getGamePlanId()
	local activityId = self:getCurrActId()
	local acfg = GoddessConfig.instance:getActCfgByActId(activityId)

	return acfg.gamePlanId
end

function GoddessModel:getEncryptedKey(...)
	local clientKey = self:getClientKey()
	local serverKey = self:getServerKey()
	local nums = {
		...
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, nums)

	return tostring(encryptedKey)
end

function GoddessModel:setClientKey(key)
	self._clientKey = key
end

function GoddessModel:getClientKey()
	return self._clientKey
end

function GoddessModel:setServerKey(key)
	self._encryptedKey = key
end

function GoddessModel:getServerKey()
	return self._encryptedKey
end

function GoddessModel:getDailyChatTime()
	return self._dailyChatTime
end

function GoddessModel:getDailyChatLeftTime()
	return GoddessConfig.instance:getTotalChatTime() - self._dailyChatTime
end

function GoddessModel:checkChatRedPoint(raceId)
	local leftTime = self:getDailyChatLeftTime()

	if leftTime <= 0 then
		return false
	end

	local info = self:getGoddessInfo(raceId)

	if info then
		local chatId = info.chatTextId[#info.chatTextId]

		if chatId and chatId > 0 then
			local textCfg = GoddessConfig.instance:getChatTextCfgByChatId(chatId)
			local nextNum = textCfg.num + 1
			local list = GoddessConfig.instance:getChatTextCfgsByChatOrder(textCfg.planId, nextNum)

			if list and #list > 0 then
				for k, v in pairs(list) do
					if v.type == "spirit" then
						return false
					end
				end

				return true
			end
		end
	end

	return false
end

function GoddessModel:getChatTextIds(raceId, isFirstGet)
	local info = self:getGoddessInfo(raceId)

	if isFirstGet then
		self._cacheChatTextId = info.chatTextId
	elseif not self._cacheChatTextId then
		self._cacheChatTextId = info.chatTextId
	elseif self._newMsgList and #self._newMsgList > 0 then
		local msg = table.remove(self._newMsgList, 1)

		table.insert(self._cacheChatTextId, msg)
	end

	return self._cacheChatTextId
end

function GoddessModel:hasNewChatMsg()
	return self._newMsgList and #self._newMsgList > 0
end

function GoddessModel:startPlaySlowMsg()
	if self:hasNewChatMsg() then
		self:_onAddNewMsg()
		settimer(1, self._onAddNewMsg, self, true)
	else
		removetimer(self._onAddNewMsg, self)
	end
end

function GoddessModel:_onAddNewMsg()
	if self:hasNewChatMsg() then
		GlobalDispatcher:dispatch(GlobalNotify.GoddessNewChatRes)
	else
		removetimer(self._onAddNewMsg, self)
	end
end

GoddessModel.instance = GoddessModel.New()

return GoddessModel
